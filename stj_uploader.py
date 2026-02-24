import os
import json
import time
import psutil
import requests
import threading
import collections
from io import BytesIO
from datetime import datetime
import platform

# Your settings
UPLOAD_DELAY = 0.7
GAME_PROCESS_NAME = "Balatro.exe"
BALATRO_PATH = "/media/Backup/Steam Games/steamapps/compatdata/2379780/pfx/drive_c/users/steamuser/AppData/Roaming/Balatro"
UPLOAD_KEY_PATH = os.path.join(BALATRO_PATH, "Mods", "SlayTheJokers", "upload.key")
LIVE_DATA_FILE_PATH = os.path.join(BALATRO_PATH, "stj-live-data.json")
REMOTE_LIVE_DATA_FILE_NAME = "live-data.json"
UPLOAD_URL = "https://edalo.net/stj/upload"
UPLOAD_INTERVAL = 0.9
MAX_UPLOAD_QUEUE_SIZE = 5

upload_queue = collections.deque(maxlen=MAX_UPLOAD_QUEUE_SIZE)
upload_lock = threading.Lock()

def is_game_running():
    if platform.system() == "Linux":
        # Proton: Scan cmdline for 'balatro.exe'
        for proc in psutil.process_iter(['pid', 'cmdline']):
            try:
                cmdline = proc.info['cmdline']
                if cmdline and 'balatro.exe' in ' '.join(cmdline).lower():
                    return True
            except (psutil.NoSuchProcess, psutil.AccessDenied):
                continue
        return False
    else:
        return any(GAME_PROCESS_NAME.lower() in p.info["name"].lower() 
                   for p in psutil.process_iter(attrs=["name"]))

# Rest of your code unchanged...
def get_upload_key():
    if not os.path.exists(UPLOAD_KEY_PATH):
        print(f"Slay the Jokers Error: Upload key file not found: {UPLOAD_KEY_PATH}")
        return None
    try:
        with open(UPLOAD_KEY_PATH, "r") as f:
            return f.read().strip()
    except Exception as e:
        print(f"Slay the Jokers Error: Failed to read upload key file: {e}")
        return None

def get_formatted_time():
    return datetime.now().strftime("%H:%M:%S.%f")[:-4]

def upload_to_server(upload_data, remote_filename, upload_key):
    tmp_file = BytesIO(upload_data.encode())
    files = {"file": (remote_filename, tmp_file)}
    payload = {"key": upload_key}
    response = requests.post(UPLOAD_URL, files=files, data=payload, timeout=5)
    if response.status_code != 200:
        print(f"Slay the Jokers Error: Failed to upload file: {response.text}", flush=True)
    else:
        print(f"Slay the Jokers uploaded data successfully at {get_formatted_time()}", flush=True)

def reader_thread():
    MAX_FILE_SIZE = 50 * 1024
    while True:
        try:
            live_data = ""
            with open(LIVE_DATA_FILE_PATH, "r", encoding="utf-8") as f:
                f.seek(0, os.SEEK_END)
                file_size = f.tell()
                f.seek(0, os.SEEK_SET)
                if file_size <= MAX_FILE_SIZE:
                    live_data = f.read()
                else:
                    print(f"Slay the Jokers Warning: live data file is too large", flush=True)
            with upload_lock:
                upload_queue.append((live_data, time.time()))
        except Exception as e:
            print(f"Slay the Jokers Error: Failed to read live data file: {e}", flush=True)
            live_data = ""
        time.sleep(UPLOAD_INTERVAL)

def uploader_thread(upload_key):
    while True:
        time_until_upload = 0
        with upload_lock:
            if upload_queue:
                current_time = time.time()
                for _ in range(len(upload_queue)):
                    upload_data, request_time = upload_queue.popleft()
                    if current_time - request_time > UPLOAD_DELAY:
                        upload_to_server(upload_data, REMOTE_LIVE_DATA_FILE_NAME, upload_key)
                    else:
                        time_until_upload = UPLOAD_DELAY - (current_time - request_time)
                        upload_queue.appendleft((upload_data, request_time))
                        break
            else:
                time_until_upload = UPLOAD_DELAY
        time.sleep(max(time_until_upload / 2, 0.1))

def main():
    if UPLOAD_INTERVAL * MAX_UPLOAD_QUEUE_SIZE <= UPLOAD_DELAY:
        print("Slay the Jokers Error: Chosen upload delay is too high")
        return
    print(f"Slay the Jokers starting... Game running? {is_game_running()}")
    if not is_game_running():
        print("Slay the Jokers Error: Game is not running")
        return
    upload_key = get_upload_key()
    if not upload_key:
        print(f"Slay the Jokers Error: Failed to get upload key")
        return
    reader = threading.Thread(target=reader_thread, daemon=True)
    uploader = threading.Thread(target=uploader_thread, args=(upload_key,), daemon=True)
    reader.start()
    uploader.start()
    while True:
        if not reader.is_alive() or not uploader.is_alive():
            print("Slay the Jokers Error: One of the threads has exited unexpectedly")
            break
        if not is_game_running():
            print("Game closed. Slay the Jokers is exiting...")
            break
        time.sleep(1)

if __name__ == "__main__":
    main()

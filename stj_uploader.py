import os
import time
import ctypes
import psutil
import requests
import threading
import collections
from io import BytesIO
from datetime import datetime

# Change this to your estimated stream delay in seconds
# Adjust by multiples of 0.1
# Not recommended to go above 3.5
UPLOAD_DELAY = 0.7

# Don't change the values below unless you know what you're doing
GAME_PROCESS_NAME = "Balatro.exe"
APPDATA_PATH = os.getenv("APPDATA")
BALATRO_PATH = os.path.join(APPDATA_PATH, "Balatro")
UPLOAD_KEY_PATH = os.path.join(os.path.dirname(__file__), "upload.key")
LIVE_DATA_FILE_PATH = os.path.join(BALATRO_PATH, "stj-live-data.json")
REMOTE_LIVE_DATA_FILE_NAME = "live-data.json"
UPLOAD_URL = "https://edalo.net/stj/upload"
UPLOAD_INTERVAL = 0.9
MAX_UPLOAD_QUEUE_SIZE = 5

upload_queue = collections.deque(maxlen=MAX_UPLOAD_QUEUE_SIZE)
upload_lock = threading.Lock()

def is_game_running():
    return any(GAME_PROCESS_NAME.lower() in process.info["name"].lower() for process in psutil.process_iter(attrs=["name"]))

def get_upload_key():
    if not os.path.exists(UPLOAD_KEY_PATH):
        message = (
            "Slay the Jokers requires an upload key to function.\n\n"
            "You can get one by logging in at:\n"
            "https://edalo.net/stj/get-key\n"
            "Then, move the key file to the same directory as this script."
        )
        ctypes.windll.user32.MessageBoxW(0, message, "Slay the Jokers - Missing Upload Key", 0x40 | 0x1)
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
            break
        time.sleep(UPLOAD_INTERVAL)

    print("Slay the Jokers: Reader thread exiting...", flush=True)
    return

def uploader_thread(upload_key):
    while True:
        time_until_upload = 0
        with upload_lock:
            if upload_queue:
                current_time = time.time()
                for _ in range(len(upload_queue)):
                    upload_data, request_time = upload_queue.popleft()
                    if current_time - request_time > UPLOAD_DELAY:
                        try:
                            upload_to_server(upload_data, REMOTE_LIVE_DATA_FILE_NAME, upload_key)
                        except Exception as e:
                            print(f"Slay the Jokers Error: Failed uploading file: {e}", flush=True)
                    else:
                        time_until_upload = UPLOAD_DELAY - (current_time - request_time)
                        upload_queue.appendleft((upload_data, request_time))
                        break
            else:
                time_until_upload = UPLOAD_DELAY
        time.sleep(max(time_until_upload / 2, 0.1))
    print("Slay the Jokers: Uploader thread exiting...", flush=True)
    return

def main():
    if UPLOAD_INTERVAL * MAX_UPLOAD_QUEUE_SIZE <= UPLOAD_DELAY:
        print("Slay the Jokers Error: Chosen upload delay is too high")
        return

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

    return

if __name__ == "__main__":
    main()

import os
import json
import time
import psutil
import collections
from datetime import datetime
from google.cloud import storage

# Change this to your estimated stream delay in seconds
# Adjust by multiples of 0.1
# Not recommended to go below 0.5 or above 3.5
UPLOAD_DELAY = 0.7

# Don't change the values below unless you know what you're doing
GAME_PROCESS_NAME = "Balatro.exe"
BUCKET_NAME = "stj-live-data"
APPDATA_PATH = os.getenv("APPDATA")
CREDENTIAL_FILE_PATH = os.path.join(APPDATA_PATH, "Balatro", "Mods", "SlayTheJokers", "stj-credentials.json")
CARD_DATA_FILE_PATH = os.path.join(APPDATA_PATH, "Balatro", "stj-live-data.csv")
UPLOAD_PATH_TEMPLATE = "streamers/{streamer_id}/card-data.csv"
UPLOAD_INTERVAL = 0.9
LOOP_INTERVAL = 0.1
MAX_UPLOAD_QUEUE_SIZE = 5

def is_game_running():
    return any(GAME_PROCESS_NAME.lower() in process.info["name"].lower() for process in psutil.process_iter(attrs=["name"]))

def get_cloud_blob():
    if not os.path.exists(CREDENTIAL_FILE_PATH):
        print(f"Slay the Jokers Error: Credential file not found: {CREDENTIAL_FILE_PATH}")
        return None

    try:
        with open(CREDENTIAL_FILE_PATH, "r") as f:
            credentials = json.load(f)
            streamer_id = credentials.get("streamer_id")
            if not streamer_id:
                print("Slay the Jokers Error: 'streamer_id' not found in credentials file.")
                return None
    except Exception as e:
        print(f"Slay the Jokers Error: Failed to read credentials file: {e}")
        return None

    os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = CREDENTIAL_FILE_PATH
    upload_path = UPLOAD_PATH_TEMPLATE.format(streamer_id=streamer_id)
    client = storage.Client()
    bucket = client.bucket(BUCKET_NAME)
    blob = bucket.blob(upload_path)

    return blob

def get_formatted_time():
    return datetime.now().strftime("%H:%M:%S.%f")[:-4]

def upload_card_data(blob, card_data):
    blob.upload_from_string(card_data)
    print(f"Uploaded card data to {BUCKET_NAME}/{blob.name} at {get_formatted_time()}")

def main():
    if UPLOAD_INTERVAL * MAX_UPLOAD_QUEUE_SIZE <= UPLOAD_DELAY:
        print("Slay the Jokers Error: Chosen upload delay is too high")
        return

    if not is_game_running():
        print("Slay the Jokers Error: Game is not running.")
        return

    blob = get_cloud_blob()
    if not blob:
        print(f"Slay the Jokers Error: Failed to create cloud blob.")
        return

    upload_queue = collections.deque(maxlen=MAX_UPLOAD_QUEUE_SIZE)
    last_upload_request_time = 0

    while True:
        current_time = time.time()
        if current_time - last_upload_request_time > UPLOAD_INTERVAL:
            try:
                with open(CARD_DATA_FILE_PATH, "r") as f:
                    card_data = f.read()
                upload_queue.append((card_data, current_time))
                last_upload_request_time = current_time
            except Exception as e:
                print(f"Slay the Jokers Error: Failed to read card data file: {e}")
                break
        
        for _ in range(len(upload_queue)):
            card_data, request_time = upload_queue.popleft()
            if current_time - request_time > UPLOAD_DELAY:
                try:
                    upload_card_data(blob, card_data)
                except Exception as e:
                    print(f"Slay the Jokers Error: Failed uploading file: {e}")
            else:
                upload_queue.appendleft((card_data, request_time))

        time.sleep(LOOP_INTERVAL)
        if not is_game_running():
            print("Game closed. Slay the Jokers is exiting...")
            break
    
    return

if __name__ == "__main__":
    main()

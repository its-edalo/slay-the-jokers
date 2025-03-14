import os
import json
import time
import psutil
from google.cloud import storage

GAME_PROCESS_NAME = "Balatro.exe"
appdata_path = os.getenv("APPDATA")

credential_file = os.path.join(appdata_path, "Balatro", "Mods", "SlayTheJokers", "stj-credentials.json")
if not os.path.exists(credential_file):
    print(f"Slay the Jokers Error: Credential file not found: {credential_file}")
    exit()

try:
    with open(credential_file, "r") as f:
        credentials = json.load(f)
        streamer_id = credentials.get("streamer_id")
        if not streamer_id:
            print("Slay the Jokers Error: 'streamer_id' not found in credentials file.")
            exit()
except Exception as e:
    print(f"Slay the Jokers Error: Failed to read credentials file: {e}")
    exit()

upload_path = f"streamers/{streamer_id}/card-data.csv"

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_file
client = storage.Client()
bucket_name = "stj-live-data"
bucket = client.bucket(bucket_name)
bucket_blob = bucket.blob(upload_path)

data_file_path = os.path.join(appdata_path, "Balatro", "stj-live-data.csv")

def is_game_running():
    return any(GAME_PROCESS_NAME.lower() in process.info["name"].lower() for process in psutil.process_iter(attrs=["name"]))

def upload_stj_live_data():
    if not is_game_running():
        print("Slay the Jokers Error: Game is not running")
        return
    if not os.path.exists(data_file_path):
        print(f"Slay the Jokers Error: Data file not found: {data_file_path}")
        return
    while is_game_running():
        try:
            bucket_blob.upload_from_filename(data_file_path)
            print(f"Uploaded stj-live-data.csv to {bucket_name}/{upload_path} at {time.ctime()}")
        except Exception as e:
            print(f"Slay the Jokers Error: Failed uploading file: {e}")
        time.sleep(0.75)
    print("Game closed. Slay the Jokers is exiting...")

upload_stj_live_data()

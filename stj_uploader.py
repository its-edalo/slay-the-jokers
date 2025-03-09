import os
import time
import psutil
from google.cloud import storage

GAME_PROCESS_NAME = "Balatro.exe"
appdata_path = os.getenv("APPDATA")

credential_file = os.path.join(appdata_path, "Balatro", "Mods", "SlayTheJokers", "stj-credentials.json")
if not os.path.exists(credential_file):
    print(f"Slay the Jokers Error: Credential file not found: {credential_file}")
    exit()

os.environ["GOOGLE_APPLICATION_CREDENTIALS"] = credential_file
client = storage.Client()
bucket_name = "stj-live-data"
bucket = client.bucket(bucket_name)
bucket_blob = bucket.blob("stj-live-data.csv")

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
            print(f"Uploaded stj-live-data.csv to {bucket_name}/stj-live-data.csv at {time.ctime()}")
        except Exception as e:
            print(f"Slay the Jokers Error: Failed uploading file: {e}")
        time.sleep(0.75)
    print("Game closed. Slay the Jokers is exiting...")

upload_stj_live_data()

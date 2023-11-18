from google.cloud import storage

def upload_file(credentials, source_file_name):
    """Uploads a file to the bucket."""
    storage_client = storage.Client(credentials=credentials)
    bucket = storage_client.bucket("ai-atl-transcriptions")
    new_file = bucket.blob("random")

    new_file.upload_from_filename("temp_text.txt")

    print(
        f"File {source_file_name} uploaded to {'ai-atl-transcriptions'}."
    )

def get_text_from_storage(location):
    with open('data.txt', 'r') as file:
        data = file.read().replace('\n', '')
    return data

def write_text_to_file(text):
    f = open('temp_text.txt', 'w')
    f.write(text)
    f.close()
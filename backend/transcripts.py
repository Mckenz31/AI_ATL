from google.cloud import storage

def upload_file(credentials, file_name):
    """Uploads a file to the bucket."""
    storage_client = storage.Client(credentials=credentials)
    bucket_name = "ai-atl-transcriptions"
    bucket = storage_client.bucket(bucket_name)
    new_file = bucket.blob(file_name)

    new_file.upload_from_filename(file_name)

    return f"gs://{bucket_name}/{file_name}"

def get_text_from_storage(location):
    with open('data.txt', 'r') as file:
        data = file.read().replace('\n', '')
    return data

def write_text_to_file(text):
    f = open('temp_text.txt', 'w')
    f.write(text)
    f.close()
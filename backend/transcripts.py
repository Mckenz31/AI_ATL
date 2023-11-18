from google.cloud import storage

def upload_file(credentials, file_name, cloud_file_name, bucket_name):
    """Uploads a file to the bucket."""
    storage_client = storage.Client(credentials=credentials)
    bucket = storage_client.bucket(bucket_name)
    new_file = bucket.blob(cloud_file_name)
    new_file.upload_from_filename(file_name)

    return f"gs://{bucket_name}/{file_name}"

def get_text_from_storage(credentials, bucket, file_name):
    client = storage.Client(credentials=credentials)
    bucket = client.get_bucket(bucket)
    blob = bucket.get_blob(file_name)

    return blob.download_as_string()

def write_text_to_file(text):
    f = open('temp_text.txt', 'w')
    f.write(text)
    f.close()
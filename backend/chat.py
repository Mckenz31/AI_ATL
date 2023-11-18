
import vertexai
from vertexai.language_models import TextGenerationModel
from vertexai.language_models import TextEmbeddingModel
from google.cloud import bigquery, storage
import pandas as pd
import time
import numpy as np
import nltk
import pickle
import csv
import numpy as np
import ast
from sklearn.metrics.pairwise import cosine_similarity



from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import time

nltk.download('punkt')


REGION = 'us-central1'
PROJECT_ID ="ai-atl-405503"

def chatBot(credentials,text):
    vertexai.init(project=PROJECT_ID, location=REGION, credentials = credentials)
    sentences = nltk.sent_tokenize(text)  
    batches = generate_batches(sentences = sentences)  
    batch=next(batches)


    batch_embeddings = encode_texts_to_embeddings(batch)
    data = list(zip(batch, batch_embeddings))
    df = pd.DataFrame(data, columns=['text', 'embeddings'])
    csv_filename = 'text_embeddings.csv'
    df.to_csv(csv_filename, index=False)

    return upload_csv(credentials,csv_filename)
    return 'success'

    
def generate_batches(sentences, batch_size = 5):
    for i in range(0, len(sentences), batch_size):
        yield sentences[i : i + batch_size]
def encode_texts_to_embeddings(sentences):
    model = TextEmbeddingModel.from_pretrained(
    "textembedding-gecko@001")
    try:
        embeddings = model.get_embeddings(sentences)
        return [embedding.values for embedding in embeddings]
    except Exception:
        return [None for _ in range(len(sentences))]

#Q&A

def askQuestion(question,credentials):
    vertexai.init(project=PROJECT_ID, location=REGION, credentials = credentials)
    so_database = download_file(credentials)
    so_database = pd.read_csv('text_embeddings.csv')
    embedding_model = TextEmbeddingModel.from_pretrained(
    "textembedding-gecko@001")
    generation_model = TextGenerationModel.from_pretrained(
    "text-bison@001")
    start = time.time()


    query_embedding = embedding_model.get_embeddings([question])[0].values


    lists=so_database['embeddings'].values
    embeddings = [ast.literal_eval(num) for num in lists]
    similarities = cosine_similarity([query_embedding], embeddings)[0]

    so_database['similarities'] = similarities
    df_sorted = so_database.sort_values('similarities', ascending=False)
    
    returns = []
    cur_len = 0

    # Iterate through sorted DataFrame and add text until the context is too long
    for i, row in df_sorted.iterrows():
        # Add the length of the text to the current length
        cur_len += len(row['text'].split()) + 4  # Assuming 'text' represents text or tokens
        
        # If the context is too long, break
        if cur_len > 2000:
            break
        
        # Else add it to the text that is being returned
        returns.append(row["text"])
        xx= "\n\n###\n\n".join(returns)
        # print(xx)

    context = xx 
    print('++',context)
    prompt = f"""Imagine you are an expert teaching assistant answering a student's question. The student asks: {question} 
    The relevant lecture context is: {context}  
    Using only the information provided, please answer the student's question in a helpful and explanatory way. If the context does not contain enough information to answer the question, respond with ["I'm sorry, I don't have enough information to answer that fully. Let me know if you need any clarification or have additional questions!"]."""
    t_value = 0.2
    response = generation_model.predict(prompt = prompt,
                                    temperature = t_value,
                                    max_output_tokens = 1024)
    print('00',response.text)
    return response.text
    
    
def upload_csv(credentials,file):
    bucket_name='embedding_bucket_atl'
    file_name='text_embeddings.csv'
    storage_client = storage.Client(credentials=credentials)
    bucket = storage_client.bucket(bucket_name)
    new_file = bucket.blob(file_name)
    if new_file.exists():
        # If the file exists, delete it
        new_file.delete()
    new_file.upload_from_filename(file)

    return f"gs://{bucket_name}/{file_name}"


def download_file(credentials):
    """Downloads a file from the bucket."""
    storage_client = storage.Client(credentials=credentials)
    bucket_name='embedding_bucket_atl'
    file_name='text_embeddings.csv'
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)
    
    # Download the file to the local directory
    blob.download_to_filename(file_name)
    
    return f"Downloaded {file_name} to {file_name}"
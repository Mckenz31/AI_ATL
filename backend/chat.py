
import vertexai
from vertexai.language_models import TextGenerationModel
from vertexai.language_models import TextEmbeddingModel
from google.cloud import bigquery
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

    my_text = """
Leo Messi: More Than Just a Soccer Player 

Growing up in Argentina, soccer was a way of life. Every kid dreamed of being the next Diego Maradona and bringing glory to the national team. For me, that player was Lionel Messi. From a young age, Messi captured my imagination with his incredible skill on the ball and seemingly effortless ability to breeze past defenders. He played the game in a way I had never seen before. 

Watching Messi weave through opposing players, I was inspired to go out to the concrete soccer field near my house and try to imitate his fancy footwork and creative dribbling. I would spend hours out there practicing Messi’s signature moves, trying to perfect that special connection between mind and body that allowed him to pull off his magical plays. Though I didn’t come close to achieving Messi’s mastery, his style of play opened my eyes to what was possible on the soccer field.

Beyond the fancy tricks, what struck me most was Messi’s passion for the game. Even with his shy demeanor off the field, he played with sheer joy that was contagious to watch. Seeing the childlike grin on his face after scoring a goal, you could tell that he loved playing soccer simply for the sake of playing. At a time when many star athletes are accused of just being in it for the money and fame, Messi’s authentic love for soccer was special.

"""
    sentences = nltk.sent_tokenize(my_text)  
    batches = generate_batches(sentences = sentences)  
    batch=next(batches)
    print(len(batch))


    batch_embeddings = encode_texts_to_embeddings(batch)
    print(len(batch_embeddings))
    print(len(batch_embeddings[0]))
    data = list(zip(batch, batch_embeddings))
    df = pd.DataFrame(data, columns=['text', 'embeddings'])
    print(df)
    csv_filename = 'text_embeddings.csv'
    df.to_csv(csv_filename, index=False)
    query = ['give me multiple choice question about messi career then provide the correct answer']
    print('++',type(df))
    askQuestion(query,df)

    
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

def askQuestion(question,so_database):
    so_database = pd.read_csv('text_embeddings.csv')
    embedding_model = TextEmbeddingModel.from_pretrained(
    "textembedding-gecko@001")
    generation_model = TextGenerationModel.from_pretrained(
    "text-bison@001")
    start = time.time()

    query_embedding = embedding_model.get_embeddings(question)[0].values
    # print('==',(so_database['embeddings'].values))


    lists=so_database['embeddings'].values
    embeddings = [ast.literal_eval(num) for num in lists]
    similarities = cosine_similarity([query_embedding], embeddings)[0]
    print(similarities)
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
        print(xx)

        context = xx + \
        "\n Answer: " + xx
        prompt = f"""Here is the context: {context}
             Using the relevant information from the context,
             provide an answer to the query: {question}."
             If the context doesn't provide \
             any relevant information, answer with 
             [I couldn't find a good answer]
             """
        t_value = 0.2
        response = generation_model.predict(prompt = prompt,
                                    temperature = t_value,
                                    max_output_tokens = 1024)
        print('999 ',response.text)
    
    
    # Add similarities as a new column in the DataFrame



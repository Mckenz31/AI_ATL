from fastapi import FastAPI, Request
from fastapi.responses import FileResponse
import uvicorn 
import requests
from fastapi.middleware.cors import CORSMiddleware  # Import the CORS middleware
from google.oauth2 import service_account
from google.cloud import speech
from vertex_interactive import generate_flash_cards, generate_open_questions, generate_mcq, validate_open_answer
from chat import chatBot,askQuestion
import json
from audio import summarize, transcribe_audio, speak_summary, clone_audio
from transcripts import upload_file, write_text_to_file, get_text_from_storage, download_file

client_file = 'ai-atl.json'
credentials = service_account.Credentials.from_service_account_file(client_file)

client = speech.SpeechClient(credentials=credentials)

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],  # Allow both POST and OPTIONS methods
    allow_headers=["*"],
)


@app.post("/")
def index(request: Request):
   return
@app.post("/mcq")
async def getMCQ(request:Request):
    data = await request.json()
    id = data.get("id")
    num_mcq = data.get("mcq")
    text = get_text_from_storage(credentials, "ai-atl-transcriptions", "transcription_"+id+".txt")
    mcq_questions = generate_mcq(credentials, text, num_of_mcq=num_mcq)
    return mcq_questions

@app.post("/openEnded")
async def getOpenEnded(request:Request):
    data = await request.json()
    id = data.get("id")
    num_open = data.get("open")
    text = get_text_from_storage(credentials, "ai-atl-transcriptions", "transcription_"+id+".txt")
    open_ended_questions = generate_open_questions(credentials, text, number_of_questions=num_open)
    return open_ended_questions

@app.post("/flashcards")
async def getFlashcards(request:Request):
    data = await request.json()
    id = data.get("id")
    text = get_text_from_storage(credentials, "ai-atl-transcriptions", "transcription_"+id+".txt")
    flash_cards = generate_flash_cards(credentials, text, 10)
    return flash_cards

@app.post("/getSummary")
async def getSummary(request: Request):
    data = await request.json()
    id = data.get("id")
    percentage = data.get("percentage")
    summary = summarize(credentials=credentials, percentage=percentage, bucket_name="ai-atl-transcriptions", file_name="transcription_"+id+".txt")
    return summary

@app.post("/downloadSpeech")
async def downloadSpeech(request: Request):
    data = await request.json()
    id = data.get("id")
    summary = data.get("summary")
    file_name = id+".mp3"
    download_file(credentials, "ai_atl_audio", file_name)
    voice = clone_audio(file_name)
    speak_summary(summary, voice)
    return file_name

@app.post("/giveFeedback")
async def giveFeedback(request: Request):
    data = await request.json()
    id = data.get("id")
    question = data.get("question")
    answer = data.get("answer")
    text = get_text_from_storage(credentials, "ai-atl-transcriptions", "transcription_"+id+".txt")
    feedback = validate_open_answer(credentials, text, question, answer)
    return feedback

@app.post("/uploadFile")
async def addFileToCloudStorage(request: Request):
    # extract file name
    data = await request.json()
    file = data.get("fileName")
    file_name = file.split(".")[0]

    # add file to storage and get the file location in Google Cloud storage
    audio_location = upload_file(credentials=credentials, file_name=file, cloud_file_name=file, bucket_name="ai_atl_audio")
    
    # transcribe the audio to text and store in Google Cloud
    transcription = transcribe_audio(client, location=audio_location)
    write_text_to_file(transcription)

    # upload the transcribed text file
    transcript_location = upload_file(credentials=credentials, file_name="temp_text.txt", cloud_file_name="transcription_"+file_name+".txt", bucket_name="ai-atl-transcriptions")
    summary = summarize(credentials=credentials, bucket_name="ai-atl-transcriptions", file_name="transcription_"+file_name+".txt")
    # train the voice model and output the summary.
    voice = clone_audio(file)
    speak_summary(summary, voice)
    # return {"location":location}

@app.get("/chatbot")
def chatbot():
   text = get_text_from_storage(credentials,"ai-atl-transcriptions","transcription_train.txt") #Todo change this txt
   embeddings = chatBot(credentials,text.decode('utf-8'))
   embeddings = chatBot(credentials,text)
   return embeddings

@app.post("/askChatbot")
async def askchatbot(request: Request):
   data = await request.json()
   question = data.get("question")
   response = askQuestion(question,credentials)
   return response

if __name__ == "__main__":
   uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)

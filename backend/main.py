from fastapi import FastAPI, Request
import uvicorn 
import requests
from fastapi.middleware.cors import CORSMiddleware  # Import the CORS middleware
from google.oauth2 import service_account
from google.cloud import speech
from audio import summarize, transcribe_audio, speak_summary, clone_audio
from transcripts import upload_file, write_text_to_file

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
@app.get("/quiz")
def generateQuiz():
    return
@app.get("/queryChatbot")
def queryChatbot():
    return
@app.get("/createNewAudio")
def createNewAudio():
    return

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
    print(summary)
    # train the voice model and output the summary.
    voice = clone_audio(file)
    speak_summary(summary, voice)
    # return {"location":location}

# to add routes follow the format above

if __name__ == "__main__":
   uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)

from fastapi import FastAPI, Request
import uvicorn 
from fastapi.middleware.cors import CORSMiddleware  # Import the CORS middleware
from google.oauth2 import service_account
from google.cloud import speech
from audio import summarize, transcribe_audio
from transcripts import upload_file

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

@app.get("/summary")
def getSummary():
   return

@app.get("/transcript")
def getTranscript():
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

@app.post("/addFileToCloud")
async def addFileToCloudStorage(request: Request):
    data = await request.json()
    file_name = data.get("file_name")
    location = upload_file(credentials=credentials, file_name=file_name)
    return {"location":location}

# to add routes follow the format above

if __name__ == "__main__":
   uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)

from fastapi import FastAPI, Request
import requests
import uvicorn 
import requests
from fastapi.middleware.cors import CORSMiddleware  # Import the CORS middleware
from google.oauth2 import service_account
from google.cloud import speech
from chat import chatBot,askQuestion


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

@app.get("/chatbot")
def chatbot():
   text = """
Leo Messi: More Than Just a Soccer Player 

Growing up in Argentina, soccer was a way of life. Every kid dreamed of being the next Diego Maradona and bringing glory to the national team. For me, that player was Lionel Messi. From a young age, Messi captured my imagination with his incredible skill on the ball and seemingly effortless ability to breeze past defenders. He played the game in a way I had never seen before. 

Watching Messi weave through opposing players, I was inspired to go out to the concrete soccer field near my house and try to imitate his fancy footwork and creative dribbling. I would spend hours out there practicing Messi’s signature moves, trying to perfect that special connection between mind and body that allowed him to pull off his magical plays. Though I didn’t come close to achieving Messi’s mastery, his style of play opened my eyes to what was possible on the soccer field.

Beyond the fancy tricks, what struck me most was Messi’s passion for the game. Even with his shy demeanor off the field, he played with sheer joy that was contagious to watch. Seeing the childlike grin on his face after scoring a goal, you could tell that he loved playing soccer simply for the sake of playing. At a time when many star athletes are accused of just being in it for the money and fame, Messi’s authentic love for soccer was special.

"""
   chatBot(credentials,text)
   return ""
# to add routes follow the format above

@app.get("/askChatbot")
def askchatbot():
   question='give me multiple choice question about messi career then provide the correct answer'
   askQuestion(question,credentials)
   return ""

if __name__ == "__main__":
   uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)

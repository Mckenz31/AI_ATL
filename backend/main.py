from fastapi import FastAPI, Request
import requests
import uvicorn 
from fastapi.middleware.cors import CORSMiddleware  # Import the CORS middleware
from google.oauth2 import service_account
from google.cloud import speech
from audio import summarize, transcribe_audio
from chat import chatBot,askQuestion



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

@app.get("/")
def index():
   return ""

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
   askQuestion("what teams did messi play for",credentials)
   return ""

if __name__ == "__main__":
   uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
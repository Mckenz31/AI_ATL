from fastapi import FastAPI, Request
import uvicorn 
from fastapi.middleware.cors import CORSMiddleware  # Import the CORS middleware
import os
import ssl

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

# to add routes follow the format above

if __name__ == "__main__":
   uvicorn.run("main:app", host="127.0.0.1", port=8000, reload=True)
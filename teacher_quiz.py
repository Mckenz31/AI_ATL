import streamlit as st
import backend.transcripts as ts
from google.oauth2 import service_account
import backend.audio as audio
from google.cloud import speech

st.title("My Fucking Streamlit App")
uploaded_file = st.file_uploader("Choose a file", type=["mp3"])
uploaded = False
upload_result = ""
transcribed_text = ""
if uploaded_file is not None:
    # To read file as bytes:
    client_file = "ai-atl.json"
    credentials = service_account.Credentials.from_service_account_file(client_file)
    upload_result = ts.upload_file(credentials, uploaded_file.name, uploaded_file.name, "ai_atl_audio")
    if upload_result:
        st.success("Lecture successfully uploaded")
        uploaded = True
if uploaded:
    create_quiz_button = st.button("Generate quiz")
    if create_quiz_button:
        transcribed_text = audio.transcribe_audio(speech.SpeechClient, upload_result)
        st.success("Done")
        st.write(transcribed_text)

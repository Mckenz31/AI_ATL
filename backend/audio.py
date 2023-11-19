import vertexai
import dotenv
from vertexai.language_models import TextGenerationModel
import io
from google.cloud import speech
from elevenlabs import Voice, VoiceSettings, generate, play, save, set_api_key, clone
from google.oauth2 import service_account
from transcripts import get_text_from_storage
import os
from pathlib import Path

# Environement variable setup
env_path = Path('.') / '.env'
dotenv.load_dotenv()

set_api_key(os.environ["ELEVEN_LABS_API"])

client_file = 'ai-atl.json'
credentials = service_account.Credentials.from_service_account_file(client_file)

client = speech.SpeechClient(credentials=credentials)

def transcribe_audio(client: speech.SpeechClient, location: str="gs://ai_atl_audio/test.mp3"):
    audio_file = 'preamble.wav'
    with io.open(audio_file, 'rb') as f:
        content = f.read()
        audio = speech.RecognitionAudio(uri=location)

    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.MP3,
        enable_automatic_punctuation=True,
        sample_rate_hertz=44100,
        language_code="en-US",
    )
    operation = client.long_running_recognize(config=config, audio=audio)

    result = operation.result(timeout=90)
    output = ""
    for result in result.results:
        alternative = result.alternatives[0]
        output += alternative.transcript
        # print(f"Transcript: {alternative.transcript}")
        # print(f"Confidence: {alternative.confidence}")

        # for word_info in alternative.words:
        #     word = word_info.word
        #     start_time = word_info.start_time
        #     end_time = word_info.end_time

        #     print(
        #         f"Word: {word}, start_time: {start_time.total_seconds()}, end_time: {end_time.total_seconds()}"
        #     )
    return output


def summarize(credentials, percentage, bucket_name, file_name):
    transcription = get_text_from_storage(credentials, bucket_name, file_name)
    # transcription = "My name is Finn Bledsoe and I'm going to be talking about why I think react is way better than vanilla JavaScript. First off react is component base, which is allows for much better organization. It allows to basically Blends book JavaScript and HTML into one file, which is just very nice and it give you all sorts of different things like States like All sorts of cool things but I'm also going to argue why Swift is way better than JavaScript and that is because Swift all of Handler functions for handling states are gone. All you have to do is pass findings in just way better and I think of that Swift is ultimately way Superior to react."
    print(len(transcription))
    vertexai.init(project="ai-atl-405503", location="us-central1", credentials=credentials)
    parameters = {
        "candidate_count": 1,
        "max_output_tokens": 256,
        "temperature": 0.2,
        "top_p": 0.95,
        "top_k": 40
    }
    model = TextGenerationModel.from_pretrained("text-bison")
    response = model.predict(
        f"""You will be given a full length transcribed lecture or educational excerpt. Consolidate the text to be approximately {percentage}% of the original length of the following text, while maintaining the original feel of the initial input: {transcription}""",
        **parameters
    )
    return response.text


def clone_audio(file_name):
    voice=clone(
        name="Finn",
        files=[file_name]
    )
    return voice

def speak_summary(summary, voice):
    audio = generate(text=summary, voice=voice)
    save(audio, "audio.mp3")

if __name__ == "__main__":
    print(summarize(credentials, "", ""))
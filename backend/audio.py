import vertexai
from vertexai.language_models import TextGenerationModel
import io
from google.cloud import speech
from elevenlabs import Voice, VoiceSettings, generate, play
from google.oauth2 import service_account
from elevenlabs import set_api_key
set_api_key("11c304ce9a726a86acdd07932edf9d97")

client_file = 'ai-atl.json'
credentials = service_account.Credentials.from_service_account_file(client_file)

client = speech.SpeechClient(credentials=credentials)

def transcribe_audio(client: speech.SpeechClient):
    audio_file = 'preamble.wav'
    with io.open(audio_file, 'rb') as f:
        content = f.read()
        audio = speech.RecognitionAudio(uri="gs://ai_atl_audio/test.mp3")

    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.MP3,
        enable_automatic_punctuation=True,
        sample_rate_hertz=44100,
        language_code="en-US",
    )
    operation = client.long_running_recognize(config=config, audio=audio)

    result = operation.result(timeout=90)

    for result in result.results:
        alternative = result.alternatives[0]
        print(f"Transcript: {alternative.transcript}")
        print(f"Confidence: {alternative.confidence}")

        for word_info in alternative.words:
            word = word_info.word
            start_time = word_info.start_time
            end_time = word_info.end_time

            print(
                f"Word: {word}, start_time: {start_time.total_seconds()}, end_time: {end_time.total_seconds()}"
            )

def summarize(credentials):
    vertexai.init(project="ai-atl-405503", location="us-central1", credentials=credentials)
    parameters = {
        "candidate_count": 1,
        "max_output_tokens": 256,
        "temperature": 0.2,
        "top_p": 0.95,
        "top_k": 40
    }
    model = TextGenerationModel.from_pretrained("text-bison")
    length = 50
    text = "The efficient-market hypothesis (EMH) is a hypothesis in financial economics that states that asset prices reflect all available information. A direct implication is that it is impossible to \"beat the market\" consistently on a risk-adjusted basis since market prices should only react to new information. Because the EMH is formulated in terms of risk adjustment, it only makes testable predictions when coupled with a particular model of risk. As a result, research in financial economics since at least the 1990s has focused on market anomalies, that is, deviations from specific models of risk. The idea that financial market returns are difficult to predict goes back to Bachelier, Mandelbrot, and Samuelson, but is closely associated with Eugene Fama, in part due to his influential 1970 review of the theoretical and empirical research. The EMH provides the basic logic for modern risk-based theories of asset prices, and frameworks such as consumption-based asset pricing and intermediary asset pricing can be thought of as the combination of a model of risk with the EMH. Many decades of empirical research on return predictability has found mixed evidence. Research in the 1950s and 1960s often found a lack of predictability (e.g. Ball and Brown 1968; Fama, Fisher, Jensen, and Roll 1969), yet the 1980s-2000s saw an explosion of discovered return predictors (e.g. Rosenberg, Reid, and Lanstein 1985; Campbell and Shiller 1988; Jegadeesh and Titman 1993). Since the 2010s, studies have often found that return predictability has become more elusive, as predictability fails to work out-of-sample (Goyal and Welch 2008), or has been weakened by advances in trading technology and investor learning."
    response = model.predict(
        f"""Provide a summary approximately {length}% of the original length of the following test: {text}""",
        **parameters
    )
    return response.text


def create_new_audio(text):
    audio = generate(
    text=text,
    voice=Voice(
        voice_id='EXAVITQu4vr4xnSDxMaL',
        settings=VoiceSettings(stability=0.71, similarity_boost=0.5, style=0.0, use_speaker_boost=True)
        )
    )
    play(audio)

# summary = summarize(credentials)
# create_new_audio(summary)


transcribe_audio(client)
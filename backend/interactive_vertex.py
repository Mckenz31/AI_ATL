import pandas as pd
import vertexai
import json
from vertexai.preview.language_models import (ChatModel, InputOutputTextPair,
                                              TextEmbeddingModel,
                                              TextGenerationModel)

PROJECT_ID = "graphite-space-405515" 
REGION = "us-central1"

def generate_open_questions(genModel: TextEmbeddingModel, lecture: str, number_of_quiz: int = 20):
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {number_of_quiz} or less quiz questions based on this lecture.\
            Give the questions as a list of JSON objects in the format: [{"question: Question, answer: Answer"}]\
            For example, [{"question: What is an electron valence, response: The outermost electron in an atom"},\
            {"question: What is the logarithm base 2 of 8, answers: 3"}].\
            """,
        temperature=0,
        max_output_tokens=256,
        top_k=40,
        top_p=1,
    )
    return response.text

def generate_flash_cards(genModel: TextEmbeddingModel, lecture: str, number_of_cards: int = 20):
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {number_of_cards} or less flash card content based on this lecture.\
            Give the flash cards content as a list of JSON objects in the format: [{"card: Card term, explanation: Explanation"}]\
            For example, [{"card: Atom, response: The central part of the atom, containing protons and neutrons"},\
            {"card: mars, explanation: A planet in the solar system"}].\
            """,
        temperature=0,
        max_output_tokens=256,
        top_k=40,
        top_p=1,
    )
    return response.text
def generate_mcq(genModel: TextEmbeddingModel, lecture: str, number_of_cards: int = 20):
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {number_of_cards} or less flash card content based on this lecture.\
            Give the flash cards content as a list of JSON objects in the format: [{"card: Card term, explanation: Explanation"}]\
            For example, [{"card: Atom, response: The central part of the atom, containing protons and neutrons"},\
            {"card: mars, explanation: A planet in the solar system"}].\
            """,
        temperature=0,
        max_output_tokens=256,
        top_k=40,
        top_p=1,
    )
    return response.text

def main():
    vertexai.init(project=PROJECT_ID, location=REGION)
    genModel = TextGenerationModel.from_pretrained("text-bison@001")
    cards = ""
    with open("sample_lecture.txt", "r") as file:
        lecture = file.read()
        questions = generate_open_questions(genModel, lecture, 6)
    print(questions)

main()

import vertexai
from vertexai.preview.language_models import (ChatModel, InputOutputTextPair,
                                              TextEmbeddingModel,
                                              TextGenerationModel)
import json
PROJECT_ID = "ai-atl-405503" 
REGION = "us-central1"

def generate_open_questions(credentials,lecture: str, number_of_questions: int = 20):
    vertexai.init(project="ai-atl-405503", location="us-central1", credentials=credentials)
    genModel = TextGenerationModel.from_pretrained("text-bison@001")
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {number_of_questions} or less quiz questions based on this lecture.\
            Give well elaborated questions, one question per line. No extra formatting, just the questions
            """,
        temperature=0,
        max_output_tokens=1024,
        top_k=1,
        top_p=1,
    )
    questions:str = response.text
    return questions.split("\n")

def generate_flash_cards(credentials,lecture: str, number_of_cards: int = 20):
    vertexai.init(project="ai-atl-405503", location="us-central1", credentials=credentials)
    genModel = TextGenerationModel.from_pretrained("text-bison@001")
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {number_of_cards} or less flash card content based on this lecture.\
            Give the flash cards content in the format "question : answer / explanation", each on a new line
            For example, 
            What is the third planet of the solar system : Earth
            Which god is the most powerful god of Greek mytholody : Zeus
            """,
        temperature=0,
        max_output_tokens=1024,
        top_k=1,
        top_p=1,
    )

    flashcards = response.text.split("\n")
    result = []
    for card in flashcards:
        result.append(card.split(" : "))

    return result

def generate_mcq(credentials,lecture: str, num_of_mcq: int = 20):
    vertexai.init(project="ai-atl-405503", location="us-central1", credentials=credentials)
    genModel = TextGenerationModel.from_pretrained("text-bison@001")
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {num_of_mcq} multiple choice questions based on this lecture. There must be three CLEAR incorrect answers, and one CLEAR correct answer. \
            Give the questions formatted like so: Some question, The, Choices, All, Four, The answer
            For example: Which god is the most powerful in Greek mythology?, Hermes, Athena, Zeus, Apollo, Zeus \
            Give one question per line, no extra formattings.
            """,
        temperature=0.2,
        max_output_tokens=1024,
        top_k=1,
        top_p=1,
    )
    questions:str = response.text
    result = []
    for question in questions.split("\n"):
        question = question.strip()
        split = question.split(", ")
        quest = split[0]
        answer = split[-1]
        choices = split[1:-1]
        result.append([quest, choices, answer])

    return result

def validate_open_answer(credentials, lecture: str, question: str, answer):
    vertexai.init(project="ai-atl-405503", location="us-central1", credentials=credentials)
    genModel = TextGenerationModel.from_pretrained("text-bison@001")
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Based on the content in the lecture, is this answer: {answer} valid for the question: {question}? \
            Give about one sentence of feedback on that answer, BUT NO MORE THAN TWO SENTENCES, for instance: That answer is not quite right, a valence electron is the outermost electron in an atom, not the innermost.
            """,
        temperature=0,
        max_output_tokens=1024,
        top_k=1,
        top_p=1,
    )
    print(response.text)
    return response.text
def main():
    vertexai.init(project=PROJECT_ID, location=REGION)
    genModel = TextGenerationModel.from_pretrained("text-bison@001")
    with open("sample_lecture.txt", "r") as file:
        lecture = file.read()
        questions = generate_open_questions(genModel, lecture, 10)
        flashcards = generate_flash_cards(genModel, lecture, 16)
        mcq = generate_mcq(genModel, lecture, 12)
    print(questions)
    print(flashcards)
    print(mcq)
    question = "What is the third planet of the solar system"
    answer = "Venus"
    validation = validate_open_answer(genModel, lecture, question, answer)
    print(validation)

if __name__ == "__main__":
    main()

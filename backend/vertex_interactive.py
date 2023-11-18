import vertexai
from vertexai.preview.language_models import (ChatModel, InputOutputTextPair,
                                              TextEmbeddingModel,
                                              TextGenerationModel)

PROJECT_ID = "graphite-space-405515" 
REGION = "us-central1"

def generate_open_questions(genModel: TextEmbeddingModel, lecture: str, number_of_quiz: int = 20):
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {number_of_quiz} or less quiz questions based on this lecture.\
            Give well elaborated questions, one question per line. No extra formatting, just the questions
            """,
        temperature=0,
        max_output_tokens=1024,
        top_k=1,
        top_p=1,
    )
    questions:str = response.text
    return questions.split("\n")

def generate_flash_cards(genModel: TextEmbeddingModel, lecture: str, number_of_cards: int = 20):
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
    return response.text.split("\n")
def generate_mcq(genModel: TextEmbeddingModel, lecture: str, num_of_mcq: int = 20):
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Generate {num_of_mcq} or less multiple choice questions based on this lecture.\
            Give the questions in this format: Question : choices : answer
            For example, Which god is the most powerful in Greek mythology? : A Hermes B Athena C Zeus D Apollo : C) \
            Give one question per line
            """,
        temperature=0,
        max_output_tokens=1024,
        top_k=1,
        top_p=1,
    )
    questions:str = response.text
    return questions.split("\n")

def validate_open_answer(genModel: TextEmbeddingModel, lecture: str, question: str, answer):
    response = genModel.predict(
        f"""Background: You are a college professor who gave this lecture : {lecture}\
            Based on the content in the lecture, is this answer: {answer} valid for the question: {question}? \
            Say "yes" or "no" and explain why
            """,
        temperature=0,
        max_output_tokens=1024,
        top_k=1,
        top_p=1,
    )
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

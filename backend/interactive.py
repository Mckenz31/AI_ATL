from openai import OpenAI
import api

def generate_quiz_questions():
    client = OpenAI()
    lecture = api.get_lecture()
    number_of_questions = 20
    # Generate questions for the quiz
    quizset = client.chat.completions.create(
    model="gpt-3.5-turbo",
    messages=[
        {"role": "system", "content": f"You are a physics professor who gave this lecture {lecture}."},
        {"role": "user", "content": f"Generate {number_of_questions} pertinent questions and responses based on this lecture. Give the question  - response in this format: question: (your question). response: ( your response)"}
    ]
    )
    return quizset.choices[0].message.content

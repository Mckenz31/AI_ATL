
# Takes some quiz questions - response and process to form two dictionaries of commons keys where values are questions and responses respctively
def process_quiz(quiz_content):
    lines = []
    questions = {}
    responses = {}
    index  = 1
    with open (quiz_content, "r") as quiz_content:
        lines = quiz_content.readlines()
        index = 1
        while index < len(lines):
            question = lines[index - 1]
            quiz_content = lines[index]
            questions[index] = question.removeprefix("Question {index}: ")
            responses[index] = quiz_content.removeprefix("Question {index}: ")
            index += 3
    return [questions,responses]

# def main():
#     questions, responses = process_response("response.txt")
#     for key in questions.keys():
#         print(questions[key])
#         print(responses[key])

# main()

import json
# Takes some quiz questions - response and process to form two dictionaries of commons keys where values are questions and responses respctively
def process_quiz(quiz_content:str):
    json_arr = []
    content_parts = quiz_content.split("\n")
    index = 1
    while index < len(content_parts):
        question = content_parts[index - 1]
        response = content_parts[index]
        json_object = json.dumps({
            "question": question[12:],
            "response": response[12:]
            }, indent=2
        )
        json_arr.append(json_object)
        index += 3
    return json_arr



# def main():
#     with open("response.txt", "r") as file:
#         content = file.read()
#         json_arr = process_quiz(content)
#         for json_o in json_arr:
#             print(json_o)
# main()
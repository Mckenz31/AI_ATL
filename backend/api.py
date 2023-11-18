def get_lecture():
    line = ""
    with open("sample_lecture.txt", "r") as file:
        line = file.readline()
    return line
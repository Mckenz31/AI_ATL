import streamlit as st
import datetime
import pandas as pd
import plotly.express as px
import backend.transcripts as ts
from google.oauth2 import service_account
import backend.audio as audio
from google.cloud import speech
import backend.vertex_interactive as vi


# Define the FastAPI backend URL
BACKEND_URL = "http://127.0.0.1:8000"

def display_flashcards():
    # Display existing flashcards as big cards
    st.header("Teacher Dashboard")
    add_new_flashcard()

    # Logic to display existing flashcards can be added here
    # for i in range(6):
    #     add_new_flashcard()


def add_new_flashcard():
    st.subheader("Lessons")
    flash_list = [
        {
            "name": "LLMs",
            "date": "10/9/2023"
        },
        {
            "name": "Machine learning",
            "date": "11/10/2023"
        },
    ]

    for i in flash_list:
        with st.expander(f"{i['name']} added on {i['date']}", expanded=True):
            st.markdown(
                f"""
                <div style="background-color: #949494; color: white; padding: 10px; border-radius: 5px;">
                    <h3 style="font-size: 29px;">{i['name']}</h3>
                    <p style="font-size: 16px;">Date: {i['date']}</p>
                </div>
                """,
                unsafe_allow_html=True
            )

    # Use st.session_state to store the state of the input field
    if 'lesson_name' not in st.session_state:
        st.session_state.lesson_name = ""

    placeholder = st.empty()

    flashcard_name = st.text_input("Lesson Name", value=st.session_state.lesson_name)
    flashcard_date = st.date_input("Lesson Date", value=datetime.date.today())

    # if st.button("Add Lesson"):
    #     new_flashcard = {
    #         "name": flashcard_name,
    #         "date": flashcard_date.strftime("%Y-%m-%d")
    #     }

    #     with placeholder:
    #         with st.expander(f"Lesson '{new_flashcard['name']}' added on {new_flashcard['date']}", expanded=True):
    #             st.markdown(
    #                 f"""
    #                 <div style="background-color: #949494; color: white; padding: 10px; border-radius: 5px;">
    #                     <h3 style="font-size: 29px;">{new_flashcard['name']}</h3>
    #                     <p style="font-size: 16px;">Date: {new_flashcard['date']}</p>
    #                 </div>
    #                 """,
    #                 unsafe_allow_html=True
    #             )

    #     # Update the state of the input field to clear it
    #     st.session_state.lesson_name = ""
                
def generate_quiz_results():
    # Example quiz results data
    quiz_results = {
        'Question Type': ['MCQs', 'Open-ended'],
        'Percentage': [80, 60]  # Replace with your quiz results percentages
    }
    return pd.DataFrame(quiz_results)

def results_page():
    st.title("Quiz Results")

    # Get quiz results data
    quiz_results_df = generate_quiz_results()

    # Display results for MCQs and Open-ended questions using a bar chart
    fig = px.bar(
        quiz_results_df,
        x='Question Type',
        y='Percentage',
        text='Percentage',
        title='Quiz Results',
        labels={'Percentage': 'Percentage Correct'},
        color='Question Type',
        color_discrete_map={'MCQs': 'blue', 'Open-ended': 'green'}
    )
    fig.update_traces(texttemplate='%{text:.2s}%', textposition='outside')

    # Show the chart in the results page
    st.plotly_chart(fig)


def create_new_quiz():
    client_file = 'ai-atl.json'
    credentials = service_account.Credentials.from_service_account_file(client_file)

    client = speech.SpeechClient(credentials=credentials)
    st.title("Generate new quiz")
    uploaded_file = st.file_uploader("Choose a file", type=["mp3"])
    uploaded = False
    upload_result = ""
    transcribed_text = ""
    credentials = None
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
            transcribed_text = audio.transcribe_audio(client=client, location=upload_result)
            st.success("Done")
            questions = vi.generate_open_questions(credentials, transcribed_text, 4)
            with open("teach_quizzes.txt") as file:
                file.write(" ".join(questions))
            # for question in questions:
                # st.write(question)


def main():
    navigation = st.sidebar.radio("Navigation", ("Home", "Quiz Results", "Create new Quiz"))
    if navigation == "Home":
        display_flashcards()
    elif navigation == "Quiz Results":
        results_page()
    elif navigation == "Create new Quiz":
        create_new_quiz()


    st.markdown(
        """
        <style>
        body {
            background-color: #949494; /* Desired background color */
        }
        .appview-container {
            background-color: #343641;
        }
        </style>
        """,
        unsafe_allow_html=True
    )

    # display_flashcards()
    # # add_new_flashcard()
    # if st.button("Go to Another Page"):
    #     display_another_page()

if __name__ == "__main__":
    main()
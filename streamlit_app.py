import streamlit as st
import requests
import datetime

# Define the FastAPI backend URL
BACKEND_URL = "http://127.0.0.1:8000"

def display_flashcards():
    # Display existing flashcards as big cards
    st.header("Teacher Dashboard")

    # Logic to display existing flashcards can be added here
    # for i in range(6):
    #     add_new_flashcard()


def add_new_flashcard():
    # Add a new flashcard with a name and date
    st.subheader("Add New Flashcard")

    flashcard_name = st.text_input("Flashcard Name")
    flashcard_date = st.date_input("Flashcard Date", value=datetime.date.today())

    if st.button("Add Flashcard"):
        # Logic to add the new flashcard
        new_flashcard = {
            "name": flashcard_name,
            "date": flashcard_date.strftime("%Y-%m-%d")  # Format date as needed
        }

        # Assuming you have a list to store flashcards
        flashcards_list = []  # This could be a list of dictionaries or a database

        # Add the new flashcard to the list
        flashcards_list.append(new_flashcard)

        # Display success message
        st.success(f"Flashcard '{flashcard_name}' added on {flashcard_date}")

def main():
    display_flashcards()
    add_new_flashcard()

    # Display the fetched data in Streamlit
    # if data:
    #     st.write("Fetched Data:")
    #     st.write(data)

if __name__ == "__main__":
    main()
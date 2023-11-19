# AI_ATL - Rewind.io 

## Inspiration
Our team was inspired to create an AI-powered learning platform after recognizing the potential for generative AI models like large language models to enhance education. We saw an opportunity to leverage these advanced technologies to make learning more interactive, personalized, and accessible for students. Our goal was to create an innovative tool that could help students better engage with course content and study more effectively.

### Demonstration Video
https://vimeo.com/886101643?share=copy#t=0

### DevPost link
https://devpost.com/software/recall-io?ref_content=user-portfolio&ref_feature=in_progress

## What it does
Our platform, App Name, allows students to upload a video lecture which is then automatically summarized via LLMs. Students can also request the summary be read back in the instructor's voice or a voice of their choosing, thanks to the latest advances in AI speech generation. Beyond summarization, students can utilize generative AI to create quizzes, flashcards and study guides tailored to the lecture content. We also employ semantic search algorithms so the platform can understand and respond to student questions about specific parts of the lecture.

## How we built it
For the interactive chat features with lecture content, we leveraged Google Vertex AI to create custom text embeddings based on the lecture contexts. This allowed us to perform cosine similarity searches to answer student questions with higher accuracy with more focus on the context compared to pre-trained models. The application has 2 views, a student view, and a teacher view. The student view contains a web and mobile application built using Google's Flutter and Dart. The teacher view is a web application developed using Streamlit. FastAPI was utilized for the backend, interacting with the frontend applications, databases, and Google's cloud services including Vertex AI.

## Challenges we ran into
It was difficult to develop an AI-powered application in a short amount of time. As first-time users of tools like Flutter and Streamlit, there was a significant learning curve to quickly gain proficiency. Overcoming technological obstacles, such as establishing Google Vertex AI embeddings to enable contextual chat interactions relating to lecture material, was another requirement for integrating different AI APIs. It took a lot of time to test these APIs, adjust parameters, and assess their performance. Challenges arose while also tweaking Flutter code to ensure that it works on both web and mobile applications. 
It took a lot of teamwork to coordinate between various components and troubleshoot problems from start to finish.

## Accomplishments that we're proud of
We are proud to have created a lecture summarization tool with Generative AI and voice generation capabilities in a short hackathon timeframe. The text-to-speech functionality allowing lecture audio in any voice was something we did for the first time and it was impressive. From a technical perspective, we are happy to have rapidly learned and implemented new technologies like Google's Vertex AI, synthesized multiple AI services, and built an engaging UI with Flutter. Most of all, we are excited to have built a functional prototype that demonstrates how AI can enhance education when applied thoughtfully. In the end, we are very proud of what we accomplished. Despite the demanding development sprint, we were able to persevere through these challenges to create a functional prototype demonstrating the possibilities of AI in education.

## What we learned
We decided to incorporate several new technologies during this hackathon including Streamlit, Vertex AI, Elevenlabs, etc., and thereby gained a strong fundamental understanding of various concepts in the new technologies. 

## What's next for Rewind.io
We have some exciting plans to continue improving wind.io's capabilities. A top priority is expanding the types of files and data sources students can upload beyond just video lectures. Our goal is to enable file uploads like PDF textbooks, notes, presentations, and more for wind.io to summarize and process.


## License

This project is licensed under [MIT](https://mit-license.org/). 

 
## Contributors

- [Mckenzie Prince](https://github.com/Mckenz31)
- [Ala Qasem](https://github.com/qasema)
- [Finn Bledsoe](https://github.com/bledsoef)
- [Moise Dete-Kpinssounon](https://github.com/moisedk)

# chatbot-project
# SDA-bootcamp-project

Stage 2 - Basic Chatbot with FastAPI

A basic chatbot using streamlit and openai api. At this stage we move the call to openai to the backend using FastAPI

Store your `OPENAI_API_KEY` in `.env` file.


Start the Backend:
Before running the chatbot, start the FastAPI backend:

uvicorn backend:app --reload

Start the Frontend
Once the backend is running, launch the Streamlit app with:

streamlit run chatbot.py

Note: Always start the backend first to ensure the chatbot functions properly.

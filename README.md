Chatbot Project
RAG Chatbot with Chat History
📌 Stage Introduction
This project implements a Retrieval-Augmented Generation (RAG) chatbot using Streamlit for the frontend and FastAPI for backend logic.

By Stage 1–4, the chatbot now supports:

Chat history
PDF upload: Users can upload PDF documents and ask questions specifically related to their content.
Under the hood, the system uses ChromaDB as a vector store to retrieve relevant content from uploaded documents. This context-aware retrieval boosts the accuracy of answers, enabling document-focused conversations instead of just general chat.

The architecture integrates:

🖥️ Streamlit – User Interface
⚙️ FastAPI – Business Logic
🗄️ PostgreSQL – Persistent Storage
🧠 ChromaDB – Vector-based Document Retrieval
💡 Note: Some LLM-related components may seem complex. The main goal is to get the project running, and full comprehension of LLM internals is not mandatory. Dive deeper if you’re curious, but don’t let complexity block progress.

🚀 How to Get Started
✅ Step 1: Set Up Environment Variables
Create a .env file in the root directory of the project and populate it with your credentials:

OPENAI_API_KEY=
DB_NAME=
DB_USER=
DB_PASSWORD=
DB_HOST=
DB_PORT=
AZURE_STORAGE_SAS_URL=
AZURE_STORAGE_CONTAINER=

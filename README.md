RAG Chatbot - Stage 8
Serverless Backend with CosmosDB & Azure Functions
This stage transitions the chatbot's backend from using Blob Storage for storing chat history to a fully serverless architecture using Azure CosmosDB and Azure Functions.

📦 Features
Chat history is now stored in CosmosDB.
Backend powered by Azure Functions.
Secrets and configurations managed via Azure Key Vault.
Frontend reads the function URL from Key Vault dynamically.
Optional: PostgreSQL can be completely replaced for a full serverless setup.
🛠 Database Migration
If you're still using PostgreSQL, remove the file_path column from the advanced_chats table, or create a new table:

CREATE TABLE IF NOT EXISTS advanced_chats_new (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    -- file_path TEXT NOT null,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pdf_path TEXT,
    pdf_name TEXT,
    pdf_uuid TEXT
);

# PostgreSQL (Optional)
PROJ-DB-NAME
PROJ-DB-USER
PROJ-DB-PASSWORD
PROJ-DB-HOST
PROJ-DB-PORT

# OpenAI API
PROJ-OPENAI-API-KEY

# Azure Storage
PROJ-AZURE-STORAGE-SAS-URL
PROJ-AZURE-STORAGE-CONTAINER

# ChromaDB
PROJ-CHROMADB-HOST
PROJ-CHROMADB-PORT

# Base Endpoint
PROJ-BASE-ENDPOINT-URL

# CosmosDB (New)
PROJ-COSMOSDB-ENDPOINT  
PROJ-COSMOSDB-KEY  
PROJ-COSMOSDB-DATABASE  
PROJ-COSMOSDB-CONTAINER  

⚙️ Azure Function Deployment
Ensure the following values are included in your local.settings.json.

Deploy your Azure Function to the cloud.

Upload the local.settings.json securely if needed.

🌐 Frontend Setup
Since the frontend is hosted on a VM or other environment, it needs access to Azure Key Vault to retrieve the Function URL.

Update your frontend code to load the Azure Function URL from Key Vault.

Add the following to your .env file:

KEY_VAULT_NAME=your-keyvault-name

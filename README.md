Chatbot Project – Stage 8
Migrating to CosmosDB (Serverless Backend with Azure Functions)
In this stage, we'll move the chat history from Blob Storage files to CosmosDB.

Database Update
If you're using PostgreSQL, you should remove the file_path column from the advanced_chats table. Alternatively, you can create a new table using the following structure:

sql
Copy
Edit
CREATE TABLE IF NOT EXISTS advanced_chats_new (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    -- file_path TEXT NOT null,
    last_update TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pdf_path TEXT,
    pdf_name TEXT,
    pdf_uuid TEXT
);
Note: The code in this branch is just a demo showing how to interact with CosmosDB. Right now, we’re only storing chat history there. However, you can also move all the metadata to CosmosDB and eliminate PostgreSQL entirely—making the whole system fully serverless.

Connecting Azure Function to CosmosDB
To connect your Azure Function to CosmosDB, store the following values in Azure Key Vault:

PROJ-COSMOSDB-ENDPOINT

PROJ-COSMOSDB-KEY

PROJ-COSMOSDB-DATABASE

PROJ-COSMOSDB-CONTAINER

Don't forget to upload the local.settings.json file to Azure when deploying your Azure Function.

Frontend Integration with Azure Function
Since the frontend is still running on a VM or instance and needs to communicate with the Azure Function, you'll also need to store the Function URL in the Azure Key Vault.

To allow the frontend to retrieve this URL:

Update the frontend code so it can read the URL from Azure Key Vault.

Add the following environment variable in the .env file on your instance:

ini
Copy
Edit
KEY_VAULT_NAME=your-keyvault-name
Make sure the instance has the correct permissions to access secrets from the Key Vault.

Secrets to Store in Azure Key Vault
Ensure the following secrets are available in your Azure Key Vault:

PROJ-DB-NAME

PROJ-DB-USER

PROJ-DB-PASSWORD

PROJ-DB-HOST

PROJ-DB-PORT

PROJ-OPENAI-API-KEY

PROJ-AZURE-STORAGE-SAS-URL

PROJ-AZURE-STORAGE-CONTAINER

PROJ-CHROMADB-HOST

PROJ-CHROMADB-PORT

PROJ-BASE-ENDPOINT-URL

PROJ-COSMOSDB-ENDPOINT

PROJ-COSMOSDB-KEY

PROJ-COSMOSDB-DATABASE

PROJ-COSMOSDB-CONTAINER


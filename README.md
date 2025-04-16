# Craft Everything

**Craft Everything** is a mobile game where players combine basic elements to discover new ones.  
The backend uses Bun, Hono, Prisma, and LLMs (OpenAI + LLaMA). The frontend is built with Flutter.
</br></br>*The project was coded in less than a day on April 16, 2025, so there may be bugs or missing features.*

## 🛠 Tech Stack
- Backend: Bun, Hono, Prisma, OpenAI API, Ollama (LLaMA)
- Database: PostgreSQL
- Frontend: Flutter (Dart)
- Extras: SharedPreferences, LLM Prompt Engineering

## 🤖 AI-Powered Crafting
If a combination doesn't exist, GPT generates a name for the result. LLaMA checks if it's similar to any existing element and helps validate or enhance it. The result is stored and becomes available for future crafts.

## 🚀 Getting Started

### 1. Clone the repo

```bash
git clone https://github.com/LoukaG/CraftEverything.git
cd craft-everything
```
### 2. Environment variables (.env)
Create a backend/.env file:

```env
DB_USER=admin
DB_PASSWORD=secret1234
DB_NAME=craft-everything
DB_PORT=5432

OPENAI_API_KEY=my_api_key
OPENAI_PROJECT_ID=my_project_id

DATABASE_URL="postgresql://${DB_USER}:${DB_PASSWORD}@localhost:${DB_PORT}/${DB_NAME}"
```

### 3. Running Docker Services (PostgreSQL + Ollama)
Run the following from the root of the project:
```bash
cd backend
docker-compose up -d
```

Run the following command to download LLaMA 3:
```bash
docker exec -it ollama bash
ollama pull llama3
```


### 3. Backend (Bun + Hono + Prisma)
**Requirements:**
- Bun
- Docker
- OpenAI API Key

```bash
cd backend
bun install
bunx prisma generate
bunx prisma migrate dev --name init
bun run seed.ts      # Load starter elements
bun run dev
```

### 4. Client (Flutter)
Run the app
```bash
cd client
flutter pub get
flutter run
```

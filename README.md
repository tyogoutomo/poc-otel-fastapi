# FastAPI with SQLAlchemy

This is a simple FastAPI application with SQLAlchemy database integration, ready for OpenTelemetry integration.

## Prerequisites

- Python 3.8
- PostgreSQL database
- Docker and Docker Compose (for containerized setup)

## Setup

### Option 1: Local Setup

1. Create a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
```

3. Set up PostgreSQL database:
- Create a database named `fastapi_db`
- Update the database URL in `database.py` if your credentials are different

### Option 2: Docker Setup

1. Build and run using Docker Compose:
```bash
docker-compose up --build
```

This will start both the FastAPI application and PostgreSQL database in containers.

## Running the Application

### Local Run
Start the application with:
```bash
uvicorn main:app --reload
```

### Docker Run
The application will automatically start when using Docker Compose.

The API will be available at `http://localhost:8000`

## API Documentation

Once the application is running, you can access:
- Swagger UI documentation: `http://localhost:8000/docs`
- ReDoc documentation: `http://localhost:8000/redoc`

## API Endpoints

- `POST /items/` - Create a new item
- `GET /items/` - List all items
- `GET /items/{item_id}` - Get a specific item
- `PUT /items/{item_id}` - Update an item
- `DELETE /items/{item_id}` - Delete an item 
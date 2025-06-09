# Use Python 3.8 slim image
FROM python:3.8-slim

ARG ENV_NAME
# Setup ENV pyhton
ENV PYTHONFAULTHANDLER=1 \
    PYTHONUNBUFFERED=1 \
    PYTHONHASHSEED=random \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    # OpenTelemetry Configuration
    OTEL_SERVICE_NAME="newcrm-api-${ENV_NAME}" \
    OTEL_EXPORTER_OTLP_ENDPOINT="0.0.0.0:4317" \
    OTEL_RESOURCE_ATTRIBUTES="deployment.environment=${ENV_NAME}" \
    OTEL_TRACES_EXPORTER="otlp" \
    OTEL_METRICS_EXPORTER="otlp" \
    PIP_DEFAULT_TIMEOUT=100 \
    POETRY_VERSION=1.4.2 \
    POETRY_CORE=1.5.2 \
    PYTHONPATH=${PYTHONPATH}:${PWD}

# Set working directory
WORKDIR /app

# Install system dependencies including PostgreSQL client
RUN apt-get update && apt-get install -y \
    postgresql-client \
    && rm -rf /var/lib/apt/lists/*

RUN pip install "poetry==$POETRY_VERSION" poetry-core==$POETRY_CORE

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Install OpenTelemetry auto-instrumentation
RUN opentelemetry-bootstrap -a install

# Copy the rest of the application
COPY . .

# Expose the port the app runs on
EXPOSE 8000

# Command to run the application with OpenTelemetry instrumentation
CMD ["opentelemetry-instrument", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"] 

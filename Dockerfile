# syntax=docker/dockerfile:1
FROM python:3.8

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | python3 -

# Set the working directory in the Docker container
WORKDIR /app

# Copy the 'pyproject.toml' and 'poetry.lock' files
COPY ./backend/pyproject.toml ./backend/poetry.lock ./backend/

# Go into the backend directory
WORKDIR /app/backend

# Install dependencies with Poetry
RUN poetry config virtualenvs.create false \
  && poetry install --no-interaction --no-ansi --no-root

# Go back to the app directory
WORKDIR /app

# Copy the rest of your app's source code from your host to your image filesystem.
COPY . .

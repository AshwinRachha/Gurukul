# Step 1: Build the frontend
FROM node:14 as frontend-builder

WORKDIR /app

# Copy the frontend files to the container
COPY web/package.json web/package-lock.json ./
RUN npm install

# Copy the rest of the frontend files to the container
COPY web .

# Build the frontend
RUN npm run build

# Step 2: Build the backend
FROM python:3.9 as backend-builder

WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y --no-install-recommends gcc libpq-dev

# Copy the backend files to the container
COPY backend/requirements.txt .

# Create and activate the virtual environment
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Install backend dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the backend files to the container
COPY backend .

# Step 3: Create the production image
FROM python:3.9-slim

WORKDIR /app

# Install OS dependencies
RUN apt-get update && apt-get install -y --no-install-recommends libpq-dev

# Copy the virtual environment from the backend image
COPY --from=backend-builder /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Copy the backend files to the container
COPY backend .

# Copy the frontend build files to the container
COPY --from=frontend-builder /app/build /app/web/build

# Expose the backend port (change this if your FastAPI app uses a different port)
EXPOSE 8000

# Install `concurrently` to run multiple commands
RUN pip install gunicorn

# Start the FastAPI server and React frontend web server using `concurrently`
CMD ["gunicorn", "main:app", "-w", "4", "--bind", "0.0.0.0:8000", "&", "npm", "start", "--prefix", "web"]

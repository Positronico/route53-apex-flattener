# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file, script, and entrypoint into the container
COPY requirements.txt requirements.txt
COPY route53-apex-flattener route53-apex-flattener
COPY entrypoint.sh entrypoint.sh

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure the script and entrypoint are executable
RUN chmod +x route53-apex-flattener
RUN chmod +x entrypoint.sh

# Set the entrypoint
ENTRYPOINT ["./entrypoint.sh"]

# Use the official Python image from the Docker Hub
FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Copy the requirements file and the script into the container
COPY requirements.txt requirements.txt
COPY route53-apex-flattener route53-apex-flattener

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Ensure the script is executable
RUN chmod +x route53-apex-flattener

# Command to run the script
ENTRYPOINT ["./route53-apex-flattener"]


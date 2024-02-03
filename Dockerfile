# Use Ubuntu as the base image
FROM ubuntu:latest

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update apt repository and install Python and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    apt-get install -y iptables && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install requests library for Python
RUN pip3 install requests

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the Python script into the container
COPY server.py .
COPY start-up.sh .

RUN chmod +x ./start-up.sh

# Make port 8080 available to the world outside this container
EXPOSE 8080

ENTRYPOINT ["./start-up.sh"]

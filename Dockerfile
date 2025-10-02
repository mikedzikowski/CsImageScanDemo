# Use Ubuntu as base image
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Update and install basic packages
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    nginx \
    python3 \
    vim \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a work directory
WORKDIR /app

# Create a simple file to demonstrate file creation
RUN echo "Hello from Ubuntu container" > hello.txt

# Copy a local file into the container (optional)
COPY . /app/

# Expose port 80 for nginx
EXPOSE 80

# Default command
CMD ["nginx", "-g", "daemon off;"]

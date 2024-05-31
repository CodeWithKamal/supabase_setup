# Use the latest official Ubuntu image as the base
FROM ubuntu:latest

# Install necessary tools and dependencies
RUN apt-get update && \
    apt-get install -y curl && \
    curl -sSL https://get.docker.com | sh && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Set the working directory inside the container
WORKDIR /app

# Clone the Supabase repository (depth 1 for faster initial cloning)
RUN git clone --depth 1 https://github.com/supabase/supabase

# Change directory to the Supabase Docker configuration
WORKDIR /app/supabase/docker

# Copy the example environment variables (replace with your actual values)
COPY .env.example .env

# Pull the latest Docker images for Supabase services
RUN docker compose pull

# Start the Supabase services in detached mode
CMD ["docker", "compose", "up", "-d"]

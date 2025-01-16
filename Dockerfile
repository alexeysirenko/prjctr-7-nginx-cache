FROM ubuntu:22.04

# Install prerequisites and nginx-extras
RUN apt-get update && apt-get install -y \
    software-properties-common \
    nginx-extras && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Expose the default HTTP port
EXPOSE 80

# Start Nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]

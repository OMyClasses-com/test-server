# Debian Docker image with SSH server
FROM debian:bullseye-slim

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Installing packages:
# - openssh-server: SSH daemon for remote access
# - sudo: allows users to run commands as other users
# - curl: command line tool for transferring data with URLs
# - wget: utility for non-interactive download of files from web

# Update package list and install SSH server and essential packages
RUN apt-get update && \
    apt-get install -y \
    openssh-server \
    sudo \
    curl \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create SSH host keys
RUN ssh-keygen -A

# Create the privilege separation directory
RUN mkdir -p /var/run/sshd

# Configure SSH
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Set root password
RUN echo 'root:rootpassword' | chpasswd

# Expose SSH port
EXPOSE 22

# Start SSH service in background and keep container running
CMD ["/bin/bash", "-c", "/usr/sbin/sshd && sleep infinity"]

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# OMYCLASSES.COM | GITHUB.COM/THE-TEACHER
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Server management commands via Docker

# Help for server commands
help-server:
	@echo "=== Server Management Commands ==="
	@echo "  make server-start           - Start the test server container"
	@echo "  make server-stop            - Stop the test server container"
	@echo "  make server-restart         - Restart the test server container"
	@echo "  make server-build           - Build the test server image"
	@echo "  make server-rebuild         - Rebuild the test server image from scratch"
	@echo "  make server-clean           - Stop and remove containers, volumes, and images"
	@echo "  make server-status          - Show test server container status"
	@echo "  make server-shell           - Get shell access to the running container"
	@echo "  make server-ssh             - Connect to the SSH server via SSH"
	@echo "  make server-prepare         - Create necessary files"
	@echo ""

# Start the SSH server
server-start:
	make server-prepare
	@echo "Starting Debian SSH server..."
	docker-compose -f $(COMPOSE_FILE) up -d
	@echo "Test server is running on port $(SSH_PORT)"
	@echo "Connect with: ssh root@localhost -p $(SSH_PORT)"

# Stop the SSH server
server-stop:
	@echo "Stopping Debian SSH server..."
	docker-compose -f $(COMPOSE_FILE) down

# Restart the SSH server
server-restart:
	@echo "Restarting Debian SSH server..."
	make server-stop
	make server-start

# Build the SSH server image
server-build:
	@echo "Building Debian SSH server image..."
	docker-compose -f $(COMPOSE_FILE) build --no-cache


# Rebuild the SSH server image from scratch
server-rebuild:
	@echo "Rebuilding Debian SSH server image from scratch..."
	docker-compose -f $(COMPOSE_FILE) down
	docker-compose -f $(COMPOSE_FILE) build --no-cache --pull
	docker-compose -f $(COMPOSE_FILE) up -d
	@echo "Rebuild completed. Server is running on port $(SSH_PORT)"

# Clean up everything
server-clean:
	@echo "Cleaning up SSH server resources..."
	docker-compose -f $(COMPOSE_FILE) down -v --rmi all
	@echo "Cleanup completed"

# Status check
server-status:
	@echo "SSH Server Status:"
	docker-compose -f $(COMPOSE_FILE) ps

# Prepare necessary files
server-prepare:
	@mkdir -p logs
	@touch logs/.bash_history
	@echo "Preparation completed. Logs directory and files are ready."

# Get shell access to the running container
server-shell:
	@echo "Connecting to SSH server container..."
	docker-compose -f $(COMPOSE_FILE) exec debian-server /bin/bash

# Connect via SSH
server-ssh:
	@echo "Connecting via SSH..."
	@echo "Password: rootpassword"
	ssh root@localhost -p $(SSH_PORT)

server-processes:
	@echo "Listing processes in the SSH server container..."
	docker-compose -f $(COMPOSE_FILE) exec debian-server ps aux | grep -v defunct

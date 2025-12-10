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
	make server-ssh-keys-clean
	@echo "Cleaning up SSH server resources..."
	docker-compose -f $(COMPOSE_FILE) down -v --rmi all
	@echo "Cleanup completed"

# Status check
server-status:
	docker-compose -f $(COMPOSE_FILE) ps --format "table {{.Name}}\t{{.Status}}\t{{.Ports}}"

# Prepare necessary files
server-prepare:
	@mkdir -p logs
	@touch logs/.keep
	@touch logs/.bash_history
	@mkdir -p home
	@touch home/.gitkeep
	@echo "Preparation completed. Logs directory and files are ready."

# Get shell access to the running container
server-shell:
	@echo "Connecting to SSH server container..."
	docker-compose -f $(COMPOSE_FILE) exec debian-server /bin/bash

# Clean old SSH host keys from known_hosts
server-ssh-keys-clean:
	@echo "Removing old SSH host keys for localhost:$(SSH_PORT)..."
	ssh-keygen -R "[localhost]:$(SSH_PORT)"
	@echo "SSH host keys cleaned. You can now connect without host key warnings."

# Connect via SSH
server-ssh:
	@echo "Connecting via SSH..."
	@echo "Password: rootpassword"
	ssh root@localhost -p $(SSH_PORT)

# List processes in the SSH server container
server-processes:
	@echo "Listing processes in the SSH server container..."
	docker-compose -f $(COMPOSE_FILE) exec debian-server ps aux | grep -v defunct

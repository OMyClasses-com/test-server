# Makefile for Debian SSH Server management

# Docker Compose file path
COMPOSE_FILE = docker/docker-compose.yml

# SSH Server port
SSH_PORT = 2222

# Include separate makefiles
include ./Makefiles/server.mk
include ./Makefiles/aliases.mk

# Default target
help:
	@echo "🚀 Debian Test Server Management System"
	@echo "======================================"
	@echo ""
	@echo "=== Quick Start ==="
	@echo "  make server-start      - Start the server"
	@echo "  make server-stop       - Stop the server"
	@echo "  make server-status     - Check server status"
	@echo ""
	@echo "=== Help Commands ==="
	@echo "  make help-server     - Show server management commands"
	@echo "  make help-aliases    - Show short command aliases"
	@echo ""
	@echo "=== Connection Info ==="
	@echo "  ROOT password: rootpassword"
	@echo "  SSH: ssh root@localhost -p $(SSH_PORT)"
	@echo ""
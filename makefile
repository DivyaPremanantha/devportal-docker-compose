# Makefile for managing Docker Compose services

# Define variables
DOCKER_COMPOSE_FILE=docker-compose.yml
PROJECT_NAME=devportal

# Targets
.PHONY: up down restart logs

up:
	@echo "Starting Docker Compose services in $(MODE) mode..."
	MODE=$(MODE) docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) up --build

down:
	@echo "Stopping Docker Compose services..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) down

restart: down up

logs:
	@echo "Displaying logs for all services..."
	docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) logs -f

# Additional targets
.PHONY: db-backup db-restore

db-backup:
	@echo "Backing up the database..."
	docker exec -t devportal-postgres pg_dumpall -c -U postgres > db_backup.sql

db-restore:
	@echo "Restoring the database..."
	cat db_backup.sql | docker exec -i devportal-postgres psql -U postgres -d devportal

# Usage help
.PHONY: help

help:
	@echo "Usage:"
	@echo "  make up        - Start the Docker Compose services"
	@echo "  make down      - Stop the Docker Compose services"
	@echo "  make restart   - Restart the Docker Compose services"
	@echo "  make logs      - Display logs for all services"
	@echo "  make db-backup - Backup the database"
	@echo "  make db-restore - Restore the database"
	@echo "  make help      - Display this help message"

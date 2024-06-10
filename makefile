# Makefile for managing Docker Compose services

# Define variables
DOCKER_COMPOSE_FILE=docker-compose.yml
PROJECT_NAME=devportal

# Targets
.PHONY: up down restart logs

DEV: MODE := dev
DEV:
	@echo "Starting Docker Compose services in $(MODE) mode..."
	MODE=$(MODE) docker-compose -f $(DOCKER_COMPOSE_FILE) -p $(PROJECT_NAME) up --build

# Production target
PROD: MODE := prod
PROD:
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

clean:
	@echo "Removing Docker service volumes..."
	docker volume rm devportal_db-data

# Usage help
.PHONY: help

help:
	@echo "Usage:"
	@echo "  make [TARGET]  - Start the Docker Compose services"
	@echo "Targets:"
	@echo "  DEV         - Run docker-compose in development mode"
	@echo "  PROD        - Run docker-compose in production mode"
	@echo "  down        - Stop the Docker Compose services"
	@echo "  restart     - Restart the Docker Compose services"
	@echo "  logs        - Display logs for all services"
	@echo "  db-backup   - Backup the database"
	@echo "  db-restore  - Restore the database"
	@echo "  help        - Display this help message"
	@echo "  clean       - Remove Docker services volume"

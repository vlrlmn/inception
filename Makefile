SRC_DIR=./srcs
DOCKER_COMPOSE_FILE=$(SRC_DIR)/docker-compose.yml
DATA_DIR=${HOME}/data


all: up

build:
	@echo "Building docker images..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) up -d --build

up: directories
	@echo "Starting up services..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) up -d

down:
	@echo "Stopping services..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down

clean: down
	@echo "Cleaning up..."
	@docker-compose -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans
	@docker system prune -f
	@docker volume prune -f
	@sudo rm -rf $(DATA_DIR)/wordpress
	@sudo rm -rf $(DATA_DIR)/mariadb

fclean: clean
	@echo "Removing all Docker containers, images, and volumes..."
	@docker system prune -a -f --volumes

directories:
	@echo "Creating directories for database and WordPress..."
	mkdir -p $(DATA_DIR)/mariadb
	mkdir -p $(DATA_DIR)/wordpress

re: fclean
	$(MAKE) up
.PHONY: all build up down clean fclean directories

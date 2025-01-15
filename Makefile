all:
		@echo "Launch configuration...\n"
		@bash srcs/requirements/wordpress/tools/start.sh
		@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

build:
		@echo "Building configuration...\n"
		@bash srcs/requirements/wordpress/tools/start.sh
		@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down:
		@echo "Stopping configuration...\n"
		@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env down

re:
		@echo "Rebuilding configuration...\n"
		@docker compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

clean: 	down
		@echo "Cleaning configuration...\n"
		@docker stop $$(docker ps -qa)
		@docker system prune --all --force --volumes
		@docker network prune --force
		@docker volume prune --force
		@sudo rm -rf ~/data/wordpress/*
		@sudo rm -rf ~/data/mariadb/*

.PHONY: all build down re clean fclean
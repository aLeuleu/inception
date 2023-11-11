DOCKER_COMPOSE_PATH	= srcs/docker-compose.yml
DOCKER_COMPOSE		= docker compose -f $(DOCKER_COMPOSE_PATH)
WORDPRESS_VOLUME_PATH = ~/data/wordpress
MARIADB_VOLUME_PATH = ~/data/mariadb

include srcs/.env

all: $(WORDPRESS_VOLUME_PATH) $(MARIADB_VOLUME_PATH)
	$(MAKE) up

up: $(WORDPRESS_VOLUME_PATH) $(MARIADB_VOLUME_PATH)
	$(DOCKER_COMPOSE) up --build

down:
	$(DOCKER_COMPOSE) down

stop:
	$(DOCKER_COMPOSE) stop

restart:
	$(DOCKER_COMPOSE) restart

clean:
	$(DOCKER_COMPOSE) down --volumes --rmi all

fclean: clean
	rm -rf $(WORDPRESS_VOLUME_PATH) $(MARIADB_VOLUME_PATH)

re: fclean
	$(MAKE) all

$(WORDPRESS_VOLUME_PATH):
	mkdir -p $(WORDPRESS_VOLUME_PATH)

$(MARIADB_VOLUME_PATH):
	mkdir -p $(MARIADB_VOLUME_PATH)

.PHONY: all up down stop restart clean fclean re
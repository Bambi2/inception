all:
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker-compose -f ./srcs/docker-compose.yml down

clean:
	docker container stop nginx mariadb wordpress

fclean: clean
	docker network rm inception
	@sudo rm -rf /home/mmalphit/data/mariadb/*
	@sudo rm -rf /home/mmalphit/data/wordpress/*
	docker system prune -af
	docker volume rm srcs_mariadb srcs_wordpress

re: fclean all

.PHONY: all re down clean
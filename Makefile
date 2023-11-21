all: 
	mkdir -p /home/mmalphit/data/mariadb
	mkdir -p /home/mmalphit/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml --env-file srcs/.env up -d

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

.Phony: all logs clean fclean re display

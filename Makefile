all:
	mkdir -p /home/mmalphit/data/mariadb
	mkdir -p /home/mmalphit/data/wordpress
	docker-compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker-compose -f ./srcs/docker-compose.yml down

clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
	sudo rm -rf /home/mmalphit/data/mysql/*; \
    sudo rm -rf /home/mmalphit/data/wordpress/*

.PHONY: all re down clean
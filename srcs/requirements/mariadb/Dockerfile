FROM debian:buster

# install MariaDB and other dependencies
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        mariadb-server \
        mariadb-client \
        procps

# copy the provided config file to the container
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Allow to run the daemon of mysql
# re-create /var/lib/mysql with appropriate ownership
# ensure that /var/run/mysqld (used for socket and 
# lock files) is writable
RUN mkdir -p /var/run/mysqld
RUN mkdir -p /var/lib/mysql
RUN chown mysql:mysql /var/run/mysqld/
RUN chmod -R 755 /var/run/mysqld/
RUN chown mysql:mysql /var/lib/mysql/
RUN chmod -R 755 /var/lib/mysql/

EXPOSE 3306

COPY ./tools/init.sh ./usr/local/bin
RUN chmod +x ./usr/local/bin/init.sh

ENTRYPOINT ["/usr/local/bin/init.sh"]

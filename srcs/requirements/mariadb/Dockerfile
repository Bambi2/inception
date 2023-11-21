FROM alpine:3.18

# Arguments for building
ARG USERNAME
ARG MARIADB_ROOT_PWD
ARG MARIADB_USER_PWD

# Downloading MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Initializing database directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Giving mysql user access to var/run/mysqld so mariadb can use it during runtine
RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld/ && chmod -R 755 /var/run/mysqld/

# Initializing db with a script
COPY ./tools/init.sh .
RUN sh init.sh && rm init.sh

# Setting a user to run the server
USER mysql

# Running the server
CMD ["/usr/bin/mysqld", "--skip-networking=OFF"]
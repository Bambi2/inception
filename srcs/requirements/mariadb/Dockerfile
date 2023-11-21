FROM alpine:3.18

# Downloading MariaDB
RUN apk update && apk add --no-cache mariadb mariadb-client

# Initializing database directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Giving mysql user access to var/run/mysqld so mariadb can use it during runtine
RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld/ && chmod -R 755 /var/run/mysqld/

# Initializing db with a script
COPY ./tools/init.sh ./usr/local/bin
RUN chmod +x ./usr/local/bin/init.sh

# Setting a user to run the server
USER mysql

# Running the server
ENTRYPOINT ["/usr/local/bin/init.sh"]
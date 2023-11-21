FROM debian:buster

# Downloading MariaDB
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
        mariadb-server \
        mariadb-client \
        procps

# Initializing database directory
RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

# Giving mysql user access to var/run/mysqld so mariadb can use it during runtine
RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld/ && chmod -R 755 /var/run/mysqld/

# Initializing db with a script
COPY ./tools/init.sh ./usr/local/bin
RUN chmod +x ./usr/local/bin/init.sh

# Running the server
ENTRYPOINT ["/usr/local/bin/init.sh"]
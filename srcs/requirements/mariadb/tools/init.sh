#!/bin/bash
#set -eux

service mysql start;

# log into MariaDB as root and create database and the user
mysql -e "CREATE DATABASE IF NOT EXISTS \`${MARIADB_DATABASE}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${USERNAME}\`@'localhost' IDENTIFIED BY '${MARIADB_USER_PWD}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${MARIADB_DATABASE}\`.* TO \`${USERNAME}\`@'%' IDENTIFIED BY '${MARIADB_USER_PWD}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PWD}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${MARIADB_ROOT_PWD} shutdown

#mysqladmin -u root shutdown
exec mysqld_safe

#print status
echo "MariaDB database and user were created successfully! "

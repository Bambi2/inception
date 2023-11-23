#!/bin/sh

mysql_install_db

/etc/init.d/mysql start

#Check if the database exists

if [ -d "/var/lib/mysql/$MARIADB_DATABASE" ]
then 

	echo "Database already exists"
else

# Set root option so that connexion without root password is impossible

mysql_secure_installation << _EOF_

Y
root4life
root4life
Y
n
Y
Y
_EOF_

#Add a root user on 127.0.0.1 to allow remote connexion 
#Flush privileges allow to your sql tables to be updated automatically when you modify it
#mysql -uroot launch mysql command line client
echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MARIADB_ROOT_PWD'; FLUSH PRIVILEGES;" | mysql -uroot

#Create database and user in the database for wordpress

echo "CREATE DATABASE IF NOT EXISTS $MARIADB_DATABASE; GRANT ALL ON $MARIADB_DATABASE.* TO '$USERNAME'@'%' IDENTIFIED BY '$MARIADB_USER_PWD'; FLUSH PRIVILEGES;" | mysql -u root

#Import database in the mysql command line
mysql -uroot -p$MARIADB_ROOT_PWD $MARIADB_DATABASE < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"
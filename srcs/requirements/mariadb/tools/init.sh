#!bin/sh
#set -eux

# sql commands to create user, update adming password and create wordpress database
# TODO: add permissions of wordpress db to username
cat << EOF > /tmp/init.sql
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MARIADB_ROOT_PWD}';
CREATE DATABASE ${MARIADB_DATABASE};
CREATE USER '${USERNAME}'@'%' IDENTIFIED by '${MARIADB_USER_PWD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${USERNAME}'@'%';
FLUSH PRIVILEGES;
EOF

# run sql script
/usr/bin/mysqld --user=mysql --bootstrap < /tmp/init.sql
rm -f /tmp/init.sql
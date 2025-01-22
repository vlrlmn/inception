#!/bin/sh

echo "Creating database ${MYSQL_NAME} and user ${MYSQL_USER}"

if [ -d "/var/lib/mysql/wordpress" ]; then
        mysqld --user=mysql
fi

echo "Creating database ${MYSQL_NAME} and user ${MYSQL_USER}"

DB="USE mysql;
FLUSH PRIVILEGES;
DELETE FROM     mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED by '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;"

echo "${DB}" | /usr/bin/mysqld --user=mysql --bootstrap

rm -f /tmp/create_db.sql
mysqld --user=mysql


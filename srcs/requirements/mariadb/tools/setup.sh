#!/bin/sh

if [ -d "/var/lib/mysql/wordpress" ]; then
        mysqld --user=mysql
fi

DB="USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS}';
CREATE DATABASE ${MYSQL_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;"

echo "${DB}" | /usr/bin/mysqld --user=mysql --bootstrap
rm -f /tmp/create_db.sql
mysqld --user=mysql
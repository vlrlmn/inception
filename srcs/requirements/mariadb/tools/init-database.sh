#!/bin/sh

if [ -d "/var/lib/mysql/wordpress" ]; then
        mysqld --user=mysql
fi

DB="USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASS}';
CREATE DATABASE ${DB_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE USER '${DB_USER}'@'%' IDENTIFIED by '${DB_PASS}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;"

echo "${DB}" | /usr/bin/mysqld --user=mysql --bootstrap
rm -f /tmp/create_db.sql
mysqld --user=mysql
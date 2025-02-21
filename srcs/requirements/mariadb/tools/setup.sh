#!/bin/sh

echo "MYSQL_NAME=${MYSQL_NAME}, MYSQL_USER=${MYSQL_USER}, MYSQL_PASSWORD=${MYSQL_PASSWORD}, MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}"

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."
    mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

DB_SETUP="
USE mysql;
FLUSH PRIVILEGES;
DELETE FROM mysql.user WHERE User='';
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS ${MYSQL_NAME} CHARACTER SET utf8 COLLATE utf8_general_ci;
FLUSH PRIVILEGES;
DROP USER IF EXISTS '${MYSQL_USER}'@'%';
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${MYSQL_NAME}.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;
"

echo "${DB_SETUP}" > /tmp/setup.sql

/usr/bin/mysqld --user=mysql --bootstrap < /tmp/setup.sql
rm -f /tmp/setup.sql

exec mysqld --user=mysql --socket=/run/mysqld/mysqld.sock

#!/bin/sh

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir -p /var/www/html/wordpress
cd /var/www/html/wordpress
chmod 777 -R /var/www/html/wordpress

sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php83/php.ini

wp --allow-root core download --force

mv wp-config-sample.php wp-config.php

sed -i "s/'database_name_here'/'$MYSQL_NAME'/g" wp-config.php
sed -i "s/'username_here'/'$MYSQL_USER'/g" wp-config.php
sed -i "s/'password_here'/'$MYSQL_PASSWORD'/g" wp-config.php
sed -i "s/'localhost'/'mariadb'/g" wp-config.php

sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php83/php-fpm.d/www.conf
echo 'listen.owner = nobody' >> /etc/php83/php-fpm.d/www.conf
echo 'listen.group = nobody' >> /etc/php83/php-fpm.d/www.conf

wp --allow-root --path=/var/www/html/wordpress core install \
	--url='https://vlomakin.42.fr' --title='WordPress' \
	--skip-email --admin_email="${WP_EMAIL1}" \
	--admin_user="$WP_USER1" \
	--admin_password="$WP_PASSWORD1"

wp --allow-root user create $WP_USER2 "${WP_EMAIL2}" --user_pass=$WP_PASSWORD2 --role=editor

chmod -R 777 /var/www/html/wordpress

if [ -f /var/www/html/wordpress/wp-config.php ]; then
	php-fpm83 --nodaemonize
fi
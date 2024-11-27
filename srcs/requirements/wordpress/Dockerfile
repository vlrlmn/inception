FROM sebian:buster

RUN apt-get update
RUN apt-ge -y install php7.3 php-mysqli php-fpm maiadb-client curl
COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d

ADD https://ru.wordpress.org/wordpress-5.7.2-ru_RU.tar.gz /var/www/
RUN cd /var/www && tar -xzvf wordpress-5.7.2-ru_RU.tar.gz
RUN rm -f /var/www/wordpress-5.7.2-ru_RU.tar.gz

#finish https://.....wp-cli 
RUN curl -0 https://.....wp-cli 
RUN chmod _x wp-cli.phar
RUN mv wp-cli..phar /usr/;ocal/bin/wp

RUN rm -f /var/www/wordpress/wp-config-sample.php
RUN mkdir /run/php/

WORKDIR /var/www/wordpress
COPY /tools/start.sh /
RUN chmod 777 /start.sh
CMD /start.sh

FROM alpine:3.19

ARG MYSQL_NAME MYSQL_USER MYSQL_PASSWORD

RUN apk add --no-cache mariadb mariadb-client \
	&& rm -rf /var/cache/apk/* \
	&& mysql_install_db --verbose --user=mysql --datadir=/var/lib/mysql;

RUN  mkdir /var/run/mysqld; \
	chmod 777 /var/run/mysqld

EXPOSE 3306

COPY conf/my.cnf /etc/my.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh

CMD ["/bin/sh", "/usr/local/bin/setup.sh"]
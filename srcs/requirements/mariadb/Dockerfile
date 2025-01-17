FROM alpine:3.17.4

ARG DB_NAME DB_USER DB_PASS

RUN apk add --no-cache mariadb mariadb-client \
	&& rm -rf /var/cache/apk/* \
	&& mysql_install_db --verbose --user=mysql --datadir=/var/lib/mysql;

EXPOSE 3306

COPY conf/my.cnf /etc/my.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh

CMD ["/bin/sh", "/usr/local/bin/init-database.sh"]
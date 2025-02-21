FROM alpine:3.20

ARG MYSQL_NAME MYSQL_USER MYSQL_PASSWORD

RUN apk add --no-cache mariadb mariadb-client && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

EXPOSE 3306

COPY conf/my.cnf /etc/my.cnf
COPY tools/setup.sh /usr/local/bin/setup.sh

CMD ["/bin/sh", "/usr/local/bin/setup.sh"]

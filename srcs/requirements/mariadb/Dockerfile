FROM mariadb:10.5

ENV MYSQL_ROOT_PASSWORD=${DB_ROOT} \
    MYSQL_DATABASE=${DB_NAME} \
    MYSQL_USER=${DB_USER} \
    MYSQL_PASSWORD=${DB_PASS}

COPY conf/my.cnf /etc/mysql/my.cnf

COPY tools/*sql /docker-entrypoint-initdb.d/

EXPOSE 3306
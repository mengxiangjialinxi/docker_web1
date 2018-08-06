FROM php:5.6-apache
RUN docker-php-ext-install mysqli
COPY ext/redis.tar.gz /tmp
RUN tar xfz /tmp/redis.tar.gz &&\
    rm -r /tmp/redis.tar.gz &&\
    mkdir -p /usr/src/php/ext  &&\
    mv phpredis-3.1.3 /usr/src/php/ext/redis &&\
    docker-php-ext-install redis

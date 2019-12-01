FROM php:7.4.0-fpm-alpine

COPY php.ini /usr/local/etc/php/conf.d/php.ini

RUN apk update && \
    apk add --no-cache libpng-dev libjpeg-turbo-dev && \
    docker-php-ext-configure gd && \
    docker-php-ext-install gd pdo_mysql

FROM php:7.4.12-fpm-alpine

COPY php.ini /usr/local/etc/php/conf.d/php.ini

RUN apk update && \
    apk add --no-cache \
    autoconf \
    gcc \
    libc-dev \
    make \
    vim \
    libpng-dev \
    libjpeg-turbo-dev && \
    printf "\n" | pecl install redis-5.1.1 && \
    docker-php-ext-configure gd && \
    docker-php-ext-install bcmath gd pdo_mysql && \
    pecl install xdebug && \
    pecl install mongodb

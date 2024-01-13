FROM php:7.4.33-fpm-alpine

COPY php.ini /usr/local/etc/php/conf.d/php.ini

RUN apk update && \
    apk add --no-cache \
    autoconf \
    gcc \
    libc-dev \
    make \
    vim \
    libpng-dev \
    libjpeg-turbo-dev \
    openssl-dev \
    tzdata && \
    ln -s /usr/share/zoneinfo/Europe/Copenhagen /etc/localtime && \
    printf "\n" | pecl install redis-5.1.1 && \
    docker-php-ext-configure gd -enable-gd --with-jpeg && \
    docker-php-ext-install bcmath gd pdo_mysql && \
    pecl uninstall mongodb && pecl install mongodb

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
    pecl uninstall mongodb && pecl install mongodb && \
    rm -rf /tmp/*

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" && \
    php composer-setup.php --install-dir=/usr/local/bin --filename=composer && \
    php -r "unlink('composer-setup.php');"

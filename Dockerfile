FROM php:7.4-fpm-alpine

RUN docker-php-ext-install pdo pdo_mysql

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug-3.1.2 \
    && docker-php-ext-enable xdebug \
    && apk del -f .build-deps

WORKDIR /var/www/html/

RUN php -r "readfile('http://getcomposer.org/installer');" | php -- --install-dir=/usr/bin/ --filename=composer

COPY . .

RUN composer install

FROM php:7.2-cli

RUN apt-get update \
    && apt-get install -y nano git zlib1g-dev mariadb-client libzip-dev zlibc unzip

RUN docker-php-ext-install zip mysqli pdo_mysql pcntl \
    && pecl install swoole \
    && docker-php-ext-enable pcntl
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer global require seregazhuk/php-watcher --dev

RUN echo "extension=swoole.so" > $PHP_INI_DIR/conf.d/swoole.ini

ENV PATH="/root/.composer/vendor/bin:${PATH}"

RUN mv /var/www/html /var/www/public

WORKDIR /var/www

CMD ["php-watcher", "server.php"]

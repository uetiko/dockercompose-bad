FROM php:5.6-apache

WORKDIR /var/www/

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update && apt-get install -y libcurl3-dev vim \
        gcc make autoconf libc-dev pkg-config libmcrypt-dev \
        openssl gnupg2 libxml2-dev libxslt-dev libicu-dev \
        zsh python3 python wget git

RUN pecl install xdebug-2.5.5

RUN docker-php-ext-configure intl

RUN docker-php-ext-enable xdebug

RUN docker-php-ext-install -j$(nproc) \
            pdo_mysql \
            curl \
            mcrypt \
            bcmath \
            soap \
            dom \
            xsl \
            iconv

RUN a2enmod rewrite

RUN a2enmod ssl

COPY ./etc/infrastructure/php/ /usr/local/etc/php/

COPY ./etc/infrastructure/apache/sites-available/ /etc/apache2/sites-available/

RUN mkdir -p /etc/ssl/certs/local/

EXPOSE 443

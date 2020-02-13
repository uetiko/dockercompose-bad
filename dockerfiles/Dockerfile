FROM php:7.3-apache

ENV PHP_MEMORY_LIMIT 2G
ENV UPLOAD_MAX_FILESIZE 64M
ENV XDEBUG_PORT 9001

WORKDIR /var/www/

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y --no-install-recommends \
        apt-utils \
        sendmail-bin \
        sendmail \
        libbz2-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        libfreetype6-dev \
        libgeoip-dev \
        wget \
        libgmp-dev \
        libmagickwand-dev \
        libmagickcore-dev \
        libc-client-dev \
        libkrb5-dev \
        libicu-dev \
        libldap2-dev \
        libpspell-dev \
        librecode0 \
        librecode-dev \
        libssh2-1 \
        libssh2-1-dev \
        libtidy-dev \
        libxslt1-dev \
        libyaml-dev \
        libzip-dev \
        zip \
        git \
        zsh

RUN docker-php-ext-configure \
    gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-configure \
    imap --with-kerberos --with-imap-ssl
RUN docker-php-ext-configure \
    ldap --with-libdir=lib/x86_64-linux-gnu
RUN docker-php-ext-configure \
    opcache --enable-opcache
RUN docker-php-ext-configure \
    zip --with-libzip

RUN docker-php-ext-install -j$(nproc) \
    bcmath \
    bz2 \
    calendar \
    exif \
    gd \
    gettext \
    gmp \
    imap \
    intl \
    ldap \
    mysqli \
    opcache \
    pdo_mysql \
    pspell \
    recode \
    shmop \
    soap \
    sockets \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    xmlrpc \
    xsl \
    zip \
    pcntl

RUN pecl install -o -f \
    geoip-1.1.1 \
    igbinary \
    imagick \
    mailparse \
    msgpack \
    oauth \
    pcov \
    propro \
    raphf \
    redis \
    xdebug-2.7.1 \
    yaml

RUN rm -f /usr/local/etc/php/conf.d/*sodium.ini 
RUN rm -f /usr/local/lib/php/extensions/*/*sodium.so 
RUN apt-get remove libsodium* -y  
RUN mkdir -p /tmp/libsodium  
RUN curl -sL https://github.com/jedisct1/libsodium/archive/1.0.18-RELEASE.tar.gz | tar xzf - -C  /tmp/libsodium 
RUN cd /tmp/libsodium/libsodium-1.0.18-RELEASE/ && ./configure \
   && make && make check && make install  
RUN cd / &&  rm -rf /tmp/libsodium &&  pecl install -o -f libsodium
RUN cd /tmp 

RUN docker-php-ext-enable \
    bcmath \
    bz2 \
    calendar \
    exif \
    gd \
    geoip \
    gettext \
    gmp \
    igbinary \
    imagick \
    imap \
    intl \
    ldap \
    mailparse \
    msgpack \
    mysqli \
    oauth \
    opcache \
    pcov \
    pdo_mysql \
    propro \
    pspell \
    raphf \
    recode \
    redis \
    shmop \
    soap \
    sockets \
    sodium \
    sysvmsg \
    sysvsem \
    sysvshm \
    tidy \
    xdebug \
    xmlrpc \
    xsl \
    yaml \
    zip \
    pcntl 

RUN apt-get clean

RUN set -uex; \
    wget https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh; \
    sh ./install.sh; \
    rm ./install.sh

ADD ./etc/infrastructure/php/ /usr/local/etc/php/

ADD ./etc/infrastructure/apache/sites-available/ /etc/apache2/sites-available/

RUN a2enmod rewrite 
RUN a2enmod headers 
RUN a2enmod ssl

RUN mkdir -p /etc/ssl/certs/local/

EXPOSE 443

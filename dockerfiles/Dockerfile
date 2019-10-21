FROM php:7.3-apache

WORKDIR /var/www/

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

RUN apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	software-properties-common \
	&& apt-get update \
	&& DEBIAN_FRONTEND=noninteractive apt-get install -y \
	libfreetype6-dev \
	libicu-dev \
  libssl-dev \
	libjpeg62-turbo-dev \
	libmcrypt-dev \
	libzip-dev \
	libedit-dev \
	libedit2 \
	libxslt1-dev \
	apt-utils \
	gnupg \
	redis-tools \
	git \
	vim \
	wget \
	curl \
	zsh \
	lynx \
	psmisc \
	unzip \
	tar \
	cron

RUN apt-get install -y \
  	libpcre3 \
  	libpcre3-dev \
  	&& pecl install oauth \
  	&& echo "extension=oauth.so" > /usr/local/etc/php/conf.d/docker-php-ext-oauth.ini \
	&& apt-get clean

RUN docker-php-ext-configure \
  	gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/; \
  	docker-php-ext-install \
  	opcache \
  	gd \
  	bcmath \
  	intl \
  	mbstring \
  	pdo_mysql \
  	soap \
  	xsl \
  	zip

RUN DEBIAN_FRONTEND=noninteractive apt-get -y install golang-go \
   && mkdir /opt/go \
   && export GOPATH=/opt/go \
   && go get github.com/mailhog/mhsendmail

RUN a2enmod rewrite \
	&& a2enmod headers \
	&& a2enmod ssl

ENV XDEBUG_PORT 9000

ADD ./etc/infrastructure/php/ /usr/local/etc/php/

ADD ./etc/infrastructure/apache/sites-available/ /etc/apache2/sites-available/

RUN mkdir -p /etc/ssl/certs/local/

EXPOSE 443

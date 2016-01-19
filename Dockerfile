FROM php:5.6-apache

RUN a2enmod rewrite
RUN apt-get update -y && apt-get install -y \
    libpq-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    ruby \
    imagemagick \
    libmemcached-dev \
    npm \
    git
    
RUN docker-php-ext-configure pdo_pgsql && \
    docker-php-ext-install pdo pdo_pgsql mbstring bcmath zip gd exif

RUN gem install -n /usr/bin sass

RUN pecl install memcached
RUN pecl install apcu-4.0.8
RUN ln -s /usr/bin/nodejs /usr/bin/node && npm install -g react-tools

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

COPY server-config/site.conf /etc/apache2/sites-enabled/app.conf
COPY server-config/apache2.conf /etc/apache2/apache2.conf
COPY server-config/php.ini /usr/local/etc/php/php.ini

RUN rm -rf /var/www/* && mkdir /var/www/web

WORKDIR /var/www

FROM alpine:3.12

ENV TERM="xterm-256color" \
  LC_ALL="en_US.UTF-8" \
  LANG="en_US.UTF-8" \
  PATH="$PATH:/app/vendor/bin:/app/node_modules/.bin:/app" \
  PHP_MEMORY_LIMIT="256M" \
  PHP_OPCACHE_ENABLED="1" \
  PHP_OPCACHE_VALIDATE_TIMESTAMPS="0" \
  PHP_OPCACHE_BLACKLIST_FILENAME="/etc/php/opcache-enabled.blacklist" \
  COMPOSER_ALLOW_SUPERUSER="1" \
  APP_ENV="production" \
  APP_NAME="elephantbox-app"

ADD https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN echo "https://dl.bintray.com/php-alpine/v3.12/php-8.0" >> /etc/apk/repositories

RUN apk --update-cache add ca-certificates \
  && apk add --update --no-cache \
    less \
    bash \
    curl \
    nano \
    php8 \
    php8-apcu \
    php8-bcmath \
    php8-bz2 \
    php8-calendar \
    php8-common \
    php8-ctype \
    php8-curl \
    php8-dba \
    php8-dev \
    php8-doc \
    php8-dom \
    php8-enchant \
    php8-exif \
    php8-fpm \
    php8-ftp \
    php8-gd \
    php8-gettext \
    php8-gmp \
    php8-hashids \
    php8-iconv \
    php8-imap \
    php8-intl \
    php8-ldap \
    php8-mbstring \
    php8-memcached \
    php8-mongodb \
    php8-msgpack \
    php8-mysqli \
    php8-mysqlnd \
    php8-odbc \
    php8-opcache \
    php8-openssl \
    php8-pcntl \
    php8-pdo \
    php8-pdo_dblib \
    php8-pdo_mysql \
    php8-pdo_odbc \
    php8-pdo_pgsql \
    php8-pdo_sqlite \
    php8-pear \
    php8-pgsql \
    php8-phar \
    php8-phpdbg \
    php8-posix \
    php8-pspell \
    php8-redis \
    php8-session \
    php8-soap \
    php8-sockets \
    php8-sodium \
    php8-sqlite3 \
    php8-xdebug \
    php8-xml \
    php8-xmlreader \
    php8-xsl \
    php8-zip \
    php8-zlib \
    nodejs-current \
    nodejs-current-npm \
  && ln -s /usr/bin/php8 /usr/bin/php \
  && ln -s /etc/php8 /etc/php \
  && ln -s /usr/sbin/php-fpm8 /usr/sbin/php-fpm \
  && rm /etc/php8/conf.d/00_xdebug.ini

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY bin/ /usr/local/bin/
COPY etc/ /etc/
COPY root/ /root/

ENTRYPOINT ["entrypoint"]

WORKDIR /app

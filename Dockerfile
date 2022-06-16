FROM php:8.1.7-fpm-alpine3.15

# create non-root user
RUN adduser -D -h /var/www/html shopware shopware

# install required php extensions
# @see https://docs.shopware.com/en/shopware-6-en/first-steps/system-requirements
ADD https://github.com/mlocati/docker-php-extension-installer/releases/download/1.5.11/install-php-extensions /usr/local/bin/
RUN chmod +x /usr/local/bin/install-php-extensions
RUN install-php-extensions gd pdo_mysql zip opcache apcu intl
RUN rm -rf /usr/local/bin/install-php-extensions

# configure php for production
COPY ./php.ini "$PHP_INI_DIR/php.ini"

WORKDIR /var/www/html
USER shopware

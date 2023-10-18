FROM php:8.2-fpm

WORKDIR /var/www/html

COPY ./app .

# Dependencies for composer
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libpq-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_pgsql

# Install composer globaly.
RUN php -r "readfile('https://getcomposer.org/installer');" | php -- --install-dir=/usr/local/bin --filename=composer

# Install project dependencies using Composer
RUN composer install

# Expose port 9000 for FastCGI
EXPOSE 9000

CMD ["php-fpm"]

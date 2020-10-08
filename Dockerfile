FROM composer:1.10.13 as build
WORKDIR /app
COPY . /app
RUN composer install

FROM php:7.4.9-apache
EXPOSE 80
COPY --from=build /app /app
COPY vhost.conf /etc/apache2/sites-available/000-default.conf
RUN chown -R www-data:www-data /app && a2enmod rewrite && service apache2 restart

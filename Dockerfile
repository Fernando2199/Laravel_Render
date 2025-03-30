# Usa una imagen oficial de PHP con Apache
FROM php:8.2-apache

# Instalar extensiones necesarias
RUN apt-get update && apt-get install -y \
    libpq-dev \
    libsqlite3-dev \
    && docker-php-ext-install pdo pdo_mysql pdo_sqlite

# Copiar los archivos del proyecto
COPY . /var/www/html/

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Instalar Composer y dependencias
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer install

# Exponer el puerto 80
EXPOSE 80

# Iniciar Laravel en Apache
CMD ["apache2-foreground"]

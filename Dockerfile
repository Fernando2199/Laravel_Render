# Usa la imagen base de PHP con Apache
FROM php:8.2-apache

# Instalar dependencias del sistema
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Instalar Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Copiar el código de la aplicación
COPY . /var/www/html/

# Establecer directorio de trabajo
WORKDIR /var/www/html

# Instalar dependencias de Laravel con Composer
RUN composer install --no-interaction --prefer-dist --optimize-autoloader

# Exponer el puerto 80 para Apache
EXPOSE ${PORT}


# Comando de inicio del contenedor
CMD ["sh", "-c", "php artisan serve --host=0.0.0.0 --port=$(expr ${PORT} + 0)"]


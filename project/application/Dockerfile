# Base image with PHP + Apache
FROM php:8.2-apache

# Enable needed PHP extensions
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Enable Apache rewrite module
RUN a2enmod rewrite

# Copy application code
COPY . /var/www/html/

# Set ownership and permissions
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 for web access
EXPOSE 80

# Start Apache server
CMD ["apache2-foreground"]


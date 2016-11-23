# Pull base image.
FROM library/ubuntu
MAINTAINER Maciel Escudero Bombonato <maciel.bombonato@gmail.com>

RUN apt-get update

RUN apt-get install -y --allow-unauthenticated software-properties-common
RUN add-apt-repository -y ppa:ondrej/php
RUN add-apt-repository -y ppa:nginx/stable

RUN apt-get update
RUN apt-get install -y --allow-unauthenticated git
RUN apt-get install -y --allow-unauthenticated nodejs
RUN apt-get install -y --allow-unauthenticated nodejs-legacy
RUN apt-get install -y --allow-unauthenticated npm
RUN npm install -g bower
RUN npm install -g gulp
RUN apt-get install -y --allow-unauthenticated curl

RUN apt-get install -y --allow-unauthenticated nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN mkdir -p /var/www/html/app/webroot
RUN chown -R www-data:www-data /var/www

RUN apt-get install -y --allow-unauthenticated php-gd
RUN apt-get install -y --allow-unauthenticated php-cli
RUN apt-get install -y --allow-unauthenticated php-fpm
RUN apt-get install -y --allow-unauthenticated php-curl
RUN apt-get install -y --allow-unauthenticated php-intl
RUN apt-get install -y --allow-unauthenticated php-geoip
RUN apt-get install -y --allow-unauthenticated php-mysql
RUN apt-get install -y --allow-unauthenticated php-pgsql
RUN apt-get install -y --allow-unauthenticated php-mcrypt
RUN apt-get install -y --allow-unauthenticated php-redis
RUN apt-get install -y --allow-unauthenticated php-xdebug
RUN apt-get install -y --allow-unauthenticated php-mbstring

RUN sed -i "s/;daemonize\s*=\s*yes/daemonize = no/" /etc/php/7.0/fpm/php-fpm.conf
RUN sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo = 0/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/memory_limit\s*=\s*128M/memory_limit = 256M/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/max_execution_time\s*=\s*30/max_execution_time = 300/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/;request_terminate_timeout\s*=\s*0/request_terminate_timeout = 300/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/error_reporting\s*=\s*E_ALL\s*&\s*~E_DEPRECATED\s*&\s*~E_STRICT/error_reporting = E_ALL/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/display_errors\s*=\s*Off/display_errors = On/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/display_startup_errors\s*=\s*Off/display_startup_errors = On/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/track_errors\s*=\s*Off/track_errors = On/" /etc/php/7.0/fpm/php.ini
RUN sed -i "s/session.gc_probability\s*=\s*0/session.gc_probability = 1/" /etc/php/7.0/fpm/php.ini

# Install GeoIP Cities light
RUN mkdir -pv /usr/share/GeoIP
RUN curl http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz | gunzip -c > /usr/share/GeoIP/GeoIPCity.dat

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Define working directory.
WORKDIR /var/www/html

# Configure default site
ADD conf/nginx/default /etc/nginx/sites-available/default
RUN mkdir -p /var/www/html/app/webroot
RUN echo "<?php phpinfo() ?>" > /var/www/html/app/webroot/index.php

# Configure Xdebug
RUN echo "xdebug.remote_enable=on" >> /etc/php/7.0/mods-available/xdebug.ini
RUN echo "xdebug.remote_connect_back=on" >> /etc/php/7.0/mods-available/xdebug.ini

# Expose ports.
EXPOSE 80

# Clean temp and cache
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Define default command.
CMD service php-fpm start && nginx

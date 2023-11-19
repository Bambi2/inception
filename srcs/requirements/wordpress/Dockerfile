FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
    bash \
    wget \
    php7.3 \
    php-fpm \
    php-mysql

# a command-line interface for WordPress
# to install wp_cli and place it in /usr/local/bin
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# download wp and its configs
RUN wget https://wordpress.org/wordpress-6.1.1.tar.gz -P /var/www/html
RUN cd /var/www/html \
	&& tar -xzf /var/www/html/wordpress-6.1.1.tar.gz \
	&& rm /var/www/html/wordpress-6.1.1.tar.gz

# give the web server(nginx) the permissions 
# to read and execute the files within the www-root directory
RUN chown -R www-data:www-data /var/www/*
RUN chmod -R 755 /var/www/*

# we expose port 9000
EXPOSE 9000

# copy the script, give x-permissions
COPY ./tools/wp-init.sh ./usr/local/bin
RUN chmod +x ./usr/local/bin/wp-init.sh

# copy .conf in the fpm directory
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

ENTRYPOINT ["/usr/local/bin/wp-init.sh"]
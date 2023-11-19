FROM debian:buster

# downloading php and configurating it so files are available for www-data user
RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    wget \
    php7.3 \
    php-fpm \
    php-mysql && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
    /etc/php/7.3/php-fpm.d/www.conf && \
    sed -i "s|;listen.owner = www-data|listen.owner = www-data|g" \
    /etc/php/7.3/php-fpm.d/www.conf && \
    sed -i "s|;listen.group = www-data|listen.group = www-data|g" \
    /etc/php7.3/php-fpm.d/www.conf && \
    rm -f /var/cache/apk/*

# downloading util/client for wordpress
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# downloading wordpress and put it to /var/www/html
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

ENTRYPOINT ["/usr/local/bin/wp-init.sh"]
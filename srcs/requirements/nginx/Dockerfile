FROM debian:buster

# install NGINX, vim, curl and openssl
RUN apt-get update -y 
RUN apt-get install -y nginx
RUN apt-get install -y vim
RUN apt-get install -y curl

# nginx SSL
# create a directory to store certificates and keys
RUN mkdir -p /etc/nginx/ssl

RUN apt-get install -y openssl

# generate the keys
RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/mmalphit.42.fr.crt \
    -keyout /etc/nginx/ssl/mmalphit.42.fr.key \
    -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=mmalphit.42.fr/UID=mmalphit"

RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# copy the provided config file to the container
COPY ./conf/nginx.conf /etc/nginx/nginx.conf

# port 443
EXPOSE  443

# launch nginx
# set the default command to be run when
# container is started from the Docker image
# "-g" specifies that nginx should be run 
# with configuration "daemon off" (e g in foreground)
CMD ["nginx", "-g", "daemon off;"]
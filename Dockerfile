FROM debian:buster

RUN apt-get update && apt-get install -y vim git wget

# Entrykit
ENV ENTRYKIT_VERSION 0.4.0
WORKDIR /
RUN apt-get install openssl \
  && wget https://github.com/progrium/entrykit/releases/download/v${ENTRYKIT_VERSION}/entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && tar -xvzf entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && rm entrykit_${ENTRYKIT_VERSION}_Linux_x86_64.tgz \
  && mv entrykit /bin/entrykit \
  && chmod +x /bin/entrykit \
  && entrykit --symlink

# Nginx
RUN apt-get update -y && apt-get -y install nginx
COPY ./srcs/default.tmpl /etc/nginx/sites-available/

# MariaDB
RUN apt-get install -y mariadb-server mariadb-client
COPY ./srcs/setup.sql /var/www/setup.sql

# PHP
RUN apt-get install -y php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath

# WordPress
WORKDIR /var/www/html/
COPY ./srcs/latest-ja.tar.gz .
RUN tar -xvzf latest-ja.tar.gz && rm latest-ja.tar.gz
COPY ./srcs/wp-config.php wordpress/

# phpMyAdmin
WORKDIR /var/www/html
COPY ./srcs/phpMyAdmin-4.9.1-english.tar.gz .
RUN tar -xvzf phpMyAdmin-4.9.1-english.tar.gz &&\
	mv phpMyAdmin-4.9.1-english phpmyadmin &&\
	rm -rf phpMyAdmin-4.9.1-english.tar.gz 
COPY ./srcs/config.inc.php phpmyadmin

# SSL
RUN mkdir /etc/nginx/ssl
RUN	openssl genrsa -out /etc/nginx/ssl/server.key 2048 \
	&& openssl req -new -key /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.csr -subj "/C=JP/ST=TOKYO/L=/O=/OU=/CN=localhost" \
	&& openssl x509 -days 3650 -req -signkey /etc/nginx/ssl/server.key -in /etc/nginx/ssl/server.csr -out /etc/nginx/ssl/server.crt

RUN chown -R www-data:www-data /var/www/html/*

COPY ./srcs/service_start.sh /var/www/service_start.sh
ENTRYPOINT ["render", "/etc/nginx/sites-available/default", "--", "bash", "/var/www/service_start.sh"]

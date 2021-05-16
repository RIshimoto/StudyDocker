FROM debian:buster
CMD tail -f /dev/null
MAINTAINER Ryo Ishimoto <rishimoto0824@gmail.com>

RUN apt-get update && apt-get upgrade
	apt-get install nginx mariadb-server mariadb-client php-cgi php-common php-fpm php-pear php-mbstring php-zip php-net-socket php-gd php-xml-util php-gettext php-mysql php-bcmath unzip wget git vim -y
	#vim /etc/php/7.3/fpm/php.ini
	#mkdir /usr/share/nginx/blog &&\
	#cd /usr/share/nginx/blog &&\
	#wget https://wordpress.org/latest.tar.gz &&\
	#tar xsfv latest.tar.gz &&\
	#apt-get install -y vim &&\
	#cd ../../../../etc/nginx/conf.d &&\
	#service nginx start
	#apt-get update && apt-get upgrade
	#apt install -y mariadb-server
	#service mysql start
	#apt-get install -y php-fpm
#ADD ./index.html /var/www/html
#COPY srcs/wordpress.conf /etc/nginx/conf.d/
COPY srcs/php.ini /etc/php/7.3/fpm/php.ini
CMD ["/usr", "now running..."]

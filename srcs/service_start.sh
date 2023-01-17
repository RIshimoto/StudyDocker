service mysql start
mysql < /var/www/setup.sql
service php7.3-fpm start
service nginx start
tail -f /var/log/nginx/access.log

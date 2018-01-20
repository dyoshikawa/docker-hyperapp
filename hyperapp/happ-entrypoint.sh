#!/usr/bin/sh
mv /var/www/happ-pre/* /var/www/happ/
mv /var/www/happ-pre/.??* /var/www/happ/
rmdir /var/www/happ-pre
chown -R 1000:1000 /var/www/happ
nginx -g 'daemon off;'
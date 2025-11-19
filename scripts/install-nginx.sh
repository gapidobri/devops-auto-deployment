apk add nginx

adduser -D -g 'www' www

mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

rm /etc/nginx/nginx.conf
mv /tmp/nginx.conf /etc/nginx/nginx.conf

rc-update add nginx default
rc-service nginx start
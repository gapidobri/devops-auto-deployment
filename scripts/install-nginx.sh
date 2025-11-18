apk add nginx

adduser -D -g 'www' www

mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

rm /etc/nginx/nginx.conf

cat <<'EOF' > /etc/nginx/nginx.conf
user                            www;
worker_processes                auto; 

error_log                       /var/log/nginx/error.log warn;
#pid                            /var/run/nginx/nginx.pid;

events {
    worker_connections          1024;
}

http {
    include                     /etc/nginx/mime.types;
    default_type                application/octet-stream;
    access_log                  /var/log/nginx/access.log;
    keepalive_timeout           3000;
    server {
        listen                  80;
        index                   index.html index.htm;
        location / {
            proxy_pass          http://127.0.0.1:5000;
            proxy_set_header    Host $host;
            proxy_set_header    X-Real-IP $remote_addr;
            proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header    X-Forwarded-Proto $scheme;
        }
        error_page              500 502 503 504  /50x.html;
        location = /50x.html {
              root              /var/lib/nginx/html;
        }
    }
}
EOF

rc-update add nginx default
rc-service nginx start
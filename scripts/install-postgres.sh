apk add postgresql15 postgresql15-contrib postgresql15-openrc

rc-update add postgresql

rc-service postgresql start

sudo -u postgres sh << EOF
  psql -c "CREATE USER app WITH ENCRYPTED PASSWORD 'password';"
  psql -c "CREATE DATABASE app;"
  psql -c "GRANT ALL PRIVILEGES ON DATABASE app TO app;"
EOF

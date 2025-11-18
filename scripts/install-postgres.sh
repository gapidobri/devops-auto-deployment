apk add postgresql17 postgresql17-contrib postgresql17-openrc

rc-update add postgresql

rc-service postgresql start

doas -u postgres sh << EOF
  psql -c "CREATE USER app WITH ENCRYPTED PASSWORD 'password';"
  psql -c "CREATE DATABASE app;"
  psql -c "GRANT ALL PRIVILEGES ON DATABASE app TO app;"
EOF

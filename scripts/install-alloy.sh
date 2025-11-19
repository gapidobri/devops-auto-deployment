mach=$(uname -m)

if [[ $mach == aarch64 ]]; then
  arch="arm64"
elif [[ $mach == x86_64 ]]; then
  arch="amd64"
fi

apk add gcompat

wget -O /tmp/alloy.zip "https://github.com/grafana/alloy/releases/download/v1.11.3/alloy-linux-$arch.zip"

unzip -d /tmp /tmp/alloy.zip

mv "/tmp/alloy-linux-$arch" /usr/local/bin/alloy

chmod +x /usr/local/bin/alloy

mkdir -p "/var/lib/alloy/data"
mkdir -p "/etc/alloy"

mv /tmp/config.alloy /etc/alloy/config.alloy

cat << EOF > /etc/init.d/alloy
#!/sbin/openrc-run
name="alloy"
command="/usr/local/bin/alloy"
command_args="run /etc/alloy/config.alloy --storage.path=/var/lib/alloy/data --server.http.listen-addr=0.0.0.0:12345"
command_background="yes"
pidfile="/run/alloy.pid"
output_log="/var/log/alloy.log"
error_log="/var/log/alloy.err"
EOF

chmod +x /etc/init.d/alloy

rc-update add alloy default
rc-service alloy start
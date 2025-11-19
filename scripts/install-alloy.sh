mach=$(uname -m)

if [[ $mach == aarch64 ]]; then
  arch="arm64"
elif [[ $mach == x86_64 ]]; then
  arch="amd64"
fi

wget -O /tmp/alloy.zip "https://github.com/grafana/alloy/releases/download/v1.11.3/alloy-linux-$arch.zip"

unzip -d /tmp /tmp/alloy.zip

mv "/tmp/alloy-linux-$arch" /usr/local/bin/alloy

chmod +x /usr/local/bin/alloy

adduser -H -D -s /bin/false alloy

cat << EOF > /etc/init.d/alloy
#!/sbin/openrc-run
name="alloy"
command="/usr/local/bin/alloy"
command_args="run --storage.path=/usr/local/alloy /usr/local/alloy/config.alloy"
command_background="yes"
pidfile="/run/alloy.pid"
output_log="/var/log/alloy.log"
error_log="/var/log/alloy.err"
EOF

chmod +x /etc/init.d/alloy

rc-update add alloy default
rc-service alloy start

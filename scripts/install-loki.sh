mach=$(uname -m)
if [[ $mach == aarch64 ]]; then
  arch="arm64"
elif [[ $mach == x86_64 ]]; then
  arch="amd64"
fi

wget -O /tmp/loki.zip "https://github.com/grafana/loki/releases/download/v3.6.0/loki-linux-$arch.zip"

unzip -d /tmp /tmp/loki.zip

mv "/tmp/loki-linux-$arch" /usr/local/bin/loki

chmod +x /usr/local/bin/loki

mkdir /usr/local/loki

mv /tmp/loki-config.yaml /usr/local/loki/loki-config.yaml


cat << EOF > /etc/init.d/loki
#!/sbin/openrc-run
name="loki"
command="/usr/local/bin/loki"
command_args="-config.file=/usr/local/loki/loki-config.yaml"
command_background="yes"
pidfile="/run/loki.pid"
output_log="/var/log/loki.log"
error_log="/var/log/loki.err"
EOF

chmod +x /etc/init.d/loki

rc-update add loki default
rc-service loki start
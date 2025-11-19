mach=$(uname -m)

if [[ $mach == aarch64 ]]; then
  arch="arm64"
elif [[ $mach == x86_64 ]]; then
  arch="amd64"
fi

wget -O /tmp/grafana.tar.gz "https://dl.grafana.com/grafana/release/12.2.1/grafana_12.2.1_18655849634_linux_$arch.tar.gz"

tar -zxvf /tmp/grafana.tar.gz -C /tmp

mv /tmp/grafana-12.2.1 /usr/local/grafana

rm -rf /usr/local/grafana/conf/provisioning
mv /tmp/provisioning /usr/local/grafana/conf

cat << EOF > /etc/init.d/grafana
#!/sbin/openrc-run
name="grafana"
command="/usr/local/grafana/bin/grafana"
command_args="server --config=/usr/local/grafana/conf/defaults.ini --homepath=/usr/local/grafana"
command_background="yes"
pidfile="/run/grafana.pid"
output_log="/var/log/grafana.log"
error_log="/var/log/grafana.err"
EOF

chmod +x /etc/init.d/grafana

rc-update add grafana default
rc-service grafana start

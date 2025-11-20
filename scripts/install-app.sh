apk add python3 py3-pip

mv /tmp/app /usr/local/app

cd /usr/local/app

# remove host venv
rm -rf .venv

python3 -m venv .venv
. .venv/bin/activate

pip install -r requirements.txt

cat << EOF > /etc/init.d/todoapp
#!/sbin/openrc-run
name="todoapp"
command="/usr/local/app/.venv/bin/python"
command_args="/usr/local/app/app.py"
command_background="yes"
pidfile="/run/todoapp.pid"
output_log="/var/log/todoapp.log"
error_log="/var/log/todoapp.err"
EOF

chmod +x /etc/init.d/todoapp

rc-update add todoapp default
rc-service todoapp start

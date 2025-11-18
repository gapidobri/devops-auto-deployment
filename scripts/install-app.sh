cd /home/vagrant/app

apk add python3 py3-pip

# remove host venv
rm -rf .venv

python3 -m venv .venv
. .venv/bin/activate

pip install -r requirements.txt

cat << EOF > /etc/init.d/todoapp
#!/sbin/openrc-run
name="todoapp"

command="/home/vagrant/app/.venv/bin/python"
command_args="/home/vagrant/app/app.py"

command_background="yes"
pidfile="/run/${RC_SVCNAME}.pid"
EOF

chmod +x /etc/init.d/todoapp

rc-update add todoapp default
rc-service todoapp start

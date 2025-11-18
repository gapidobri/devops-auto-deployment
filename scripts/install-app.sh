cd /home/vagrant/app

apk add python3 py3-pip

python3 -m venv .venv
. .venv/bin/activate

pip install -r requirements.txt

nohup python3 app.py >/dev/null 2>&1 &
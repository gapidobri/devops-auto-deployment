#!/bin/bash

apk add python3 py3-pip

pip install -r /home/vagrant/app/requirements.txt

python3 /home/vagrant/app/app.py
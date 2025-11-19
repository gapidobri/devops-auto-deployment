# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "generic/alpine319"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Install Postgres
  config.vm.provision "shell", path: "scripts/install-postgres.sh"

  # Install App
  config.vm.provision "file", source: "./app", destination: "/home/vagrant/app"

  config.vm.provision "shell", path: "scripts/install-app.sh"

  # Install Nginx
  config.vm.provision "file", source: "configs/nginx.conf", destination: "/tmp/nginx.conf"

  config.vm.provision "shell", path: "scripts/install-nginx.sh"

  config.vm.network "forwarded_port", guest: 5000, host: 5050

  # Install Grafana
  config.vm.provision "shell", path: "scripts/install-grafana.sh"

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  # Install Loki
  config.vm.provision "file", source: "configs/loki-config.yaml", destination: "/tmp/loki-config.yaml"

  config.vm.provision "shell", path: "scripts/install-loki.sh"
end

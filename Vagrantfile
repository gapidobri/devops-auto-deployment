# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "generic/alpine319"
  config.vm.synced_folder ".", "/vagrant", disabled: true

  # Install Postgres
  config.vm.provision "shell", name: "install-postgres", path: "scripts/install-postgres.sh"

  # Install App
  config.vm.provision "file", source: "app", destination: "/tmp/app"

  config.vm.provision "shell", name: "install-app", path: "scripts/install-app.sh"

  # Install Nginx
  config.vm.provision "file", source: "configs/nginx.conf", destination: "/tmp/nginx.conf"

  config.vm.provision "shell", name:"install-nginx", path: "scripts/install-nginx.sh"

  config.vm.network "forwarded_port", guest: 80, host: 80

  # Install Grafana
  config.vm.provision "file", source: "configs/grafana/provisioning", destination: "/tmp/provisioning"

  config.vm.provision "shell", name: "install-grafana", path: "scripts/install-grafana.sh"

  # Install Loki
  config.vm.provision "file", source: "configs/loki-config.yaml", destination: "/tmp/loki-config.yaml"

  config.vm.provision "shell", name: "install-loki", path: "scripts/install-loki.sh"

  # Install Alloy
  config.vm.provision "file", source: "configs/config.alloy", destination: "/tmp/config.alloy"

  config.vm.provision "shell", name: "install-alloy", path: "scripts/install-alloy.sh"

end

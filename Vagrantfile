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

  config.vm.network "forwarded_port", guest: 5000, host: 5050

end

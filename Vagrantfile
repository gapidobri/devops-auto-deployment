# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "cloud-image/alpine-3.22"

  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.ssh.shell = "sh"
  config.ssh.sudo_command = "doas %c"

  config.vm.provider :qemu do |qemu|
    qemu.machine = "virt,accel=hvf,highmem=off"
	qemu.cpu = "cortex-a72"
	qemu.smp = "1"
	qemu.memory = "512M"
  end


  # Install Postgres
  config.vm.provision "shell", path: "scripts/install-postgres.sh"

  # Install App
  config.vm.provision "file", source: "./app", destination: "/home/vagrant/app"

  config.vm.provision "shell", path: "scripts/install-app.sh"

  config.vm.network "forwarded_port", guest: 5000, host: 5050

end

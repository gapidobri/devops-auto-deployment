# DevOps Auto Deployment
Auto deployment scripts for Vagrant and Cloud-Init

## Deployment with Vagrant

### MacOS (Apple Silicon)

Install qemu
```bash
brew install qemu
```

Install plugin
```bash
vagrant plugin install vagrant-qemu
```

Deploy
```bash
vagrant up --provider qemu
```

### Windows

Install VirtualBox

Deploy
```bash
vagrant up
```

## Deployment with Cloud-init

TODO
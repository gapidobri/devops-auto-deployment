# DevOps Auto Deployment
Auto deployment scripts for Vagrant and Cloud-Init

## Installation

### MacOS (Apple Silicon)

Install qemu
``bash
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

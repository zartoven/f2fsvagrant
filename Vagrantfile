# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64" # 14.04

  sdb = './sdb.vdi'
  dvd_path = "DVD_PATH"

  config.vm.network "private_network", ip: "VM_IP"
  config.vm.provider "virtualbox" do |v|
    #v.gui = true
    v.name = "VM_NAME"
    v.cpus = 4
    v.memory = "8192"
    unless File.exist?(sdb)
      v.customize ['createhd', '--filename', sdb, '--size', 32 * 1024]
      v.customize ['storageattach', :id, '--storagectl', 'SATAController', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', sdb]
    end

    if File.exist?('TARGET/vbaddon.sh')
      v.customize ['storageattach', :id, '--storagectl', 'SATAController', '--port', 3, '--device', 0, '--type', 'dvddrive', '--medium', dvd_path]
    end
  end

  if File.exist?('TARGET/kernel.sh')
    config.vm.synced_folder '.', '/vagrant', disabled: false
  else
    if File.exist?('TARGET/vbaddon.sh')
      config.vm.synced_folder '.', '/vagrant', disabled: true
    else
      config.vm.synced_folder '.', '/vagrant', disabled: false
    end
  end

  if File.exist?('~/.gitconfig')
    config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  end

  config.vbguest.auto_update = false

  config.vm.provision "shell", run: "always", inline: <<-SHELL
    if [ -e /vagrant/kernel.sh ]; then
      echo VM_NAME > /etc/hostname
      mv /vagrant/vimrc .vimrc
      mv /vagrant/kernel.sh .
      mv /vagrant/setuptools.sh .
      cp /vagrant/vbaddon.sh .
      ./kernel.sh
      rm kernel.sh
    elif [ -e vbaddon.sh ]; then
      ./vbaddon.sh
      rm vbaddon.sh
    elif [ -e setuptools.sh ]; then
      ./setuptools.sh
      rm setuptools.sh
      chown -R vagrant:vagrant .
    fi
  SHELL
end

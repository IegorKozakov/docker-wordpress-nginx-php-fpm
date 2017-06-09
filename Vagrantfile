# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "opscode-centos7"
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_centos-7.0_chef-provisionerless.box"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024, "--cpus", 1]
    vb.gui = false
  end

  config.vm.define :'wordpress-vm' do |c|
    c.vm.hostname = "wordpress"
    c.vm.network :private_network, ip: "192.168.50.4"

    c.vm.synced_folder ".", "/home/vagrant/work", type: :virtualbox

    c.vm.provision :shell, path: "setup/server.sh"
  end
end

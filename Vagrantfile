# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.require_version ">= 1.4.3"

Vagrant.configure('2') do |config|
  config.vm.box = 'saucy64'
  config.vm.box_url = 'http://cloud-images.ubuntu.com/vagrant/saucy/current/saucy-server-cloudimg-amd64-vagrant-disk1.box'
  config.vm.network :forwarded_port, guest: 8080, host:9999
  config.vm.synced_folder ".", "/vagrant", :mount_options => ["uid=5678,gid=65534"]

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '1024', '--natdnsproxy1', 'on']
  end

  # provisioners
  config.vm.provision :shell, path: "provisioners/shell/jenkins.sh"
  #config.vm.provision :shell, path: "provisioners/shell/project.sh"
  #config.vm.provision :shell, path: "provisioners/shell/nodejs.sh"
  #config.vm.provision :shell, path: "provisioners/shell/appengine.sh"

  config.vbguest.auto_update = true
end



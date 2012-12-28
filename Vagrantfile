# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.define :aptcache do |aptcache|
    aptcache.vm.box = "lucid32"
    aptcache.vm.box = "http://files.vagrantup.com/lucid32.box"
    aptcache.vm.host_name = "aptcache"
    aptcache.vm.share_folder "module", "/tmp/vagrant-puppet/modules/apt-cacher-ng", ".", :create => true
    aptcache.vm.network :hostonly, "192.168.31.42"
    aptcache.vm.forward_port 3142, 3142
    aptcache.vm.forward_port 22, 2242
    aptcache.ssh.max_tries = 150
    aptcache.vm.provision :puppet do |puppet|
      puppet.manifests_path = "tests"
      puppet.manifest_file = "vagrant.pp"
      puppet.options = ["--modulepath", "/tmp/vagrant-puppet/modules"]
    end
  end
end

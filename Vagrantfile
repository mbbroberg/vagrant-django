# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "raring64"
    config.vm.box_url = "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"
    config.vm.network :forwarded_port, guest: 8080, host: 8080
    config.ssh.forward_agent = true
    config.vm.hostname = "django"
    config.vm.provider :virtualbox do |vb|
        vb.gui = false
        vb.customize ["modifyvm", :id, "--memory", "512"]
        vb.customize ["modifyvm", :id, "--vram", "8"]
    end
    # config.vm.provision :shell do |shell|
    #     shell.inline = "cd /vagrant && su -c 'scripts/bootstrap-vagrant.sh' vagrant"
    #     shell.args = ""
    # end
    config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "puppet/manifests"
        puppet.module_path = "puppet/modules"
        puppet.options = "--verbose --debug"
        puppet.manifest_file = "site.pp"
    end
end

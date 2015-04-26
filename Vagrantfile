require 'json'
require 'yaml'

VAGRANTFILE_API_VERSION = "2"
confDir = $confDir ||= File.expand_path("./")

homesteadYamlPath = confDir + "/Homestead.yaml"
provisionScriptPath = confDir + "/after-provision.sh"
bootScriptPath = confDir + "/after-boot.sh"
aliasesPath = confDir + "/aliases"

require File.expand_path(File.dirname(__FILE__) + '/.vagrant-provision/homestead.rb')

Vagrant.configure(VAGRANTFILE_API_VERSION) do |vagrant_config|
    settings = YAML::load(File.read(homesteadYamlPath))
    vagrant_config.vm.define settings["hostname"] ||= "homestead" do |config|

        # Configure The Box
        config.vm.box = settings["box"] ||= "laravel/homestead"
        config.vm.hostname = settings["hostname"] ||= "homestead"

        # Configure A Private Network IP
        config.vm.network :private_network, ip: settings["ip"] ||= "192.168.10.10"

        # Configure A Few VirtualBox Settings
        config.vm.provider "virtualbox" do |vb|
          vb.name = settings["hostname"] ||= 'homestead'
          vb.customize ["modifyvm", :id, "--memory", settings["memory"] ||= "2048"]
          vb.customize ["modifyvm", :id, "--cpus", settings["cpus"] ||= "1"]
          vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
        end

    	if File.exists? aliasesPath then
    		config.vm.provision "file", source: aliasesPath, destination: "~/.bash_aliases"
    	end

    	Homestead.configure(config, settings)

    	if File.exists? provisionScriptPath then
    		config.vm.provision "shell", path: provisionScriptPath
    	end

        if File.exists? bootScriptPath then
            config.vm.provision "shell", run: "always", path: bootScriptPath
        end
    end
end

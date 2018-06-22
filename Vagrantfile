# -*- mode: ruby -*-
# vi: set ft=ruby :

unless Vagrant.has_plugin?("vagrant-docker-compose")
  system("vagrant plugin install vagrant-docker-compose")
  puts "Depenencies installed, please  try the command agian."
  exit
end
unless Vagrant.has_plugin?("vagrant-disksize")
  system("vagrant plugin install vagrant-disksize")
  puts "Depenencies installed, please  try the command agian."
  exit
end
# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/xenial64"

  config.vm.synced_folder "pcap/", "/pcap"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = "2048"
    config.disksize.size = "20GB"
  end

  config.vm.provision "shell", inline: "mkdir -p /esdata1"
  config.vm.provision "shell", inline: "sysctl -w vm.max_map_count=262144"
  config.vm.provision :docker
  config.vm.provision :docker_compose, yml: ["/vagrant/docker-compose.yml"], run: "always"
  #config.vm.synced_folder "docker/" "/app", create: true, mount_options: ["ro"]

  # config.vm.box_check_update = false
  config.vm.network "forwarded_port", guest: 8005, host: 8005
  config.vm.network "forwarded_port", guest: 9200, host: 9200
end

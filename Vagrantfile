VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = "michel"
  config.vm.network "public_network"
  config.vm.network "forwarded_port", guest: 22, host: 2225

  config.vm.provider "virtualbox" do |vb|
    # Add another CPU
    vb.cpus = "4"
    # Customize the amount of memory on the VM
    vb.memory = "2048"
  end
  # Install docker-engine
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates
    sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
    sudo echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list
    sudo apt-get purge lxc-docker
    sudo apt-cache policy docker-engine
    sudo apt-get install -y linux-image-extra-$(uname -r)
    sudo apt-get install -y apparmor
    sudo apt-get update
    sudo apt-get install -y docker-engine
    sudo usermod -aG docker vagrant
    sudo ufw disable
    sudo echo 'DOCKER_OPTS="-H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock"' >> /etc/default/docker
    sudo service docker restart
    docker pull kourkis/miner
  SHELL

end

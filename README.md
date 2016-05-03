# DevOps Playground 3 - Hands on Docker Swarm
## Mining bitcoins using everyone's laptops with Docker Swarm

### Pre Steps 

#### How to guide: Open a firewall port

* windows 7
http://windows.microsoft.com/en-gb/windows/open-port-windows-firewall#1TC=windows-7
* windows 8, 10
http://windows.microsoft.com/en-gb/windows-8/windows-firewall-from-start-to-finish
* mac osx
https://support.apple.com/en-gb/HT201642
* ubuntu
http://www.howtogeek.com/115116/how-to-configure-ubuntus-built-in-firewall/


### Steps to follow

1. Install Docker Toolbox
https://www.docker.com/docker-toolbox
2. List any VMs in VirtualBox  
  `docker-machine ls`
3. If you don't have the default machine installed, please create it  
  `docker-machine create --driver virtualbox default`
4. If you have unnecessary VMs running stop them.    `docker-machine stop vm-name`
5. Stop the default VM in VirtualBox and change its settings so that it can use all of the processors of your laptop.
6. Start Docker Quickstart terminal.
7. Build the image  
`docker build -t kourkis/miner -f Dockerfile .`
8. Start the container  
`docker run kourkis/miner`

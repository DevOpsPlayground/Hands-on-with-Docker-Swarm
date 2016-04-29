# DevOps Playground 3 - Hands on Docker Swarm
## Mining bitcoins using everyone's laptops with Docker Swarm


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

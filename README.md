# DevOps Playground 3 - Hands on Docker Swarm
## Mining bitcoins using everyone's laptops with Docker Swarm
### Steps to follow
1. Download Vagrant and install it.   
2. Clone the git repository, or simply download the Vagrant file in step 3.   
`git clone https://github.com/ForestTechnologiesLtd/devopsplayground3-docker-swarm.git`
3. Change the hostname in the Vagrantfile, line 5, check that your hostname is unique
4. Start the vagrant machine, which is going to download and configure everything  
`vagrant up`
5. Connect to the vagrant machine through SSH  
  `vagrant ssh`
6. Create a consul server (Only on the manager)   
`docker run -d -p 8500:8500 --name=consul progrium/consul -server -bootstrap`
7. Start the swarm manager (Only on the manager)   
`docker run -d -p 4000:4000 swarm manage -H :4000 --advertise <manager-ip>:4000 consul://<manager-ip>:8500`
8. Start the swarm clients   
`docker run -d swarm join --advertise=<your-vm-ip>:2375 consul://<manager-ip>:8500`
9. On the manager   
`docker -H :4000 run -d kourkis/miner`
10. To remove all of the miners   
`docker -H :4000 ps -q | xargs docker -H :4000 rm -f`
11. To create several miners in a single command   
`for i in {1..5}; do docker -H :4000 run -d kourkis/miner; done`

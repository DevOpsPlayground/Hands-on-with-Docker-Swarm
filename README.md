# DevOps Playground 3 - Hands on Docker Swarm
## Mining bitcoins using everyone's laptops with Docker Swarm
### Steps to follow
1. Download Vagrant and install it.   
2. Open ports 2375, 4000 and 8500 or disable firewall
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


## Remote API
​
Docker Swarm uses the same API calls as Docker. Visit [the API documentation](https://docs.docker.com/engine/reference/api) to get more details.
​
### To enable the Remote Api Access to a Docker Host:
* Without security: For the purpose of the Meetup we open the socket to everyone and don't use TLS for securing the Remote API Access.
Add `-H tcp://0.0.0.0:4243` to the `DOCKER_OPTS` in `/etc/default/docker`.  
[Reference](http://www.virtuallyghetto.com/2014/07/quick-tip-how-to-enable-docker-remote-api.html)
* With security: For securing it see [this documentation.](https://coreos.com/os/docs/latest/customizing-docker.html)
​
### Using the Remote API
#### Get running containers on the Docker Swarm cluster
​
`http://<manager-ip>:<port>/containers/json`
* `<manager-ip>` - The Docker Swarm manager IP. Docker Swarm Manager IP to access containers in the cluster level.
* `<port>` - The Docker Swarm Manager listening port.
​
From the command line, we execute the following command
* command: `curl -X GET http://<manager-ip>:<port>/containers/json`
​
#### Get a specific Container information
​
`http://<manager-ip>:<port>/containers/<container-id or container-name>/json`
​
* `<manager-ip>` - The Docker Swarm manager IP. Docker Swarm Manager IP to access containers in the cluster level.
* `<port>` - The Docker Swarm Manager listening port.
​
From the command line, we execute the following command
* command: `curl -X GET http://<manager-ip>:<port>/containers/<container-id or container-name>/json`
​
#### Get logs from a specific Container ID
​
`http://<docker-node-ip>:<open-port>/containers/<container-id or container-name>/logs?stderr=1&stdout=1&`
​
* Include the `logs` keyword after the container id
* `stdout` – `1/True/true` or `0/False/false`, show `stdout` log. Default false.
* `stderr` – `1/True/true` or `0/False/false`, show `stderr` log. Default false.
​
From the command line, we execute the following command
* command: `curl -X GET http://<manager-ip>:<port>/containers/<container-id or container-name>/logs?stderr=1&stdout=1&`
​
#### Example: Running container and inspecting it
​
1. Create the hello-world container:
`curl -H "Content-Type: application/json" -X POST -d '{"Hostname": "hello-world-node", "Image": "hello-world"}' http://<manager-ip>:<port>/containers/create?name=<container-name>`
​
2. Start the hello-wold container:
`curl -X POST -H "Content-Type: application/json" -d '{}' http://<manager-ip>:<port>containers/<container-id or container-name>/start`
​
3. Query your node by name
`curl -X GET http://<manager-ip>:<port>/containers/<container-name>/json`

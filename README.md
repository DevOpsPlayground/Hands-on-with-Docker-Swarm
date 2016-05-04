# DevOps Playground 3 - Hands on Docker Swarm
## Mining bitcoins using everyone's laptops with Docker Swarm

### Pre-requisites
1. Download Vagrant and Virtualbox and install them.   
2. If you are running Windows, install Git Bash
3. Open ports 2375, 4000 and 8500 or disable firewall
4. Change the hostname in the Vagrantfile, line 4, check that your hostname is unique


### Start and configure the VM
Start the vagrant machine, which is going to download and configure everything. In the folder where your Vagrantfile is:  
`vagrant up`


### Connect to the VM and join the Docker Swarm
1. Connect to the vagrant machine through SSH  
  `vagrant ssh`
2. Start the swarm clients   
`docker run -d swarm join --advertise=<your-vm-ip>:2375 consul://<manager-ip>:8500`


## Remote API
​Most Docker API endpoints are implemented by Swarm, meaning that tools built on top of it will work out of the box, including the Docker CLI. Visit [the API documentation](https://docs.docker.com/engine/reference/api) to get more details.
​
### To enable the Remote Api Access to a Docker Host:
There is no need to do it during this meetup, as this is taken care of in the Vagrantfile. This is simply for your information.
* Without security: For the purpose of the Meetup we open the socket to everyone and don't use TLS for securing the Remote API Access.
Add `-H tcp://<ip>:<port>` to the `DOCKER_OPTS` in `/etc/default/docker`.  
[Reference](http://www.virtuallyghetto.com/2014/07/quick-tip-how-to-enable-docker-remote-api.html)
* With security: For securing it see [this documentation.](https://coreos.com/os/docs/latest/customizing-docker.html)
​

### Using the Remote API
The following GET commands can be run from your web browser.
#### Get running containers on the Docker Swarm cluster
​
`http://<manager-ip>:<port>/containers/json`
* `<manager-ip>` - The Docker Swarm manager IP. Docker Swarm Manager IP to access containers in the cluster level.
* `<port>` - The Docker Swarm Manager listening port.
​
* (Alternative) From the command line, we execute the following command  
`curl -X GET http://<manager-ip>:<port>/containers/json`
​

#### Get a specific Container information
​
`http://<manager-ip>:<port>/containers/<container-id or container-name>/json`
​
* `<manager-ip>` - The Docker Swarm manager IP. Docker Swarm Manager IP to access containers in the cluster level.
* `<port>` - The Docker Swarm Manager listening port.
​
* (Alternative) From the command line, we execute the following command  
`curl -X GET http://<manager-ip>:<port>/containers/<container-id or container-name>/json`
​

#### Get logs from a specific Container ID

`http://<docker-node-ip>:<open-port>/containers/<container-id or container-name>/logs?stderr=1&stdout=1&`
* Include the `logs` keyword after the container id/name
* `stdout` – `1/True/true` or `0/False/false`, show `stdout` log. Default false.
* `stderr` – `1/True/true` or `0/False/false`, show `stderr` log. Default false.
​
* (Alternative) From the command line, we execute the following command  
`curl -X GET http://<manager-ip>:<port>/containers/<container-id or container-name>/logs?stderr=1&stdout=1&`
​

#### Example: Running container and inspecting it
What the `docker run` command would normally do, is to create a container and then start it.
In this example you are going to create a `hello-world` container, then start it and finally check info about it (including the status, node name, etc). Ensure you replace the fields between `<` and `>` with the correct information.

1. Create the hello-world container:  
`curl -H "Content-Type: application/json" -X POST -d '{"Hostname": "hello-world-node", "Image": "hello-world"}' http://<manager-ip>:<port>/containers/create?name=<container-name>`
​
2. Start the hello-wold container by its name:  
`curl -X POST -H "Content-Type: application/json" -d '{}' http://<manager-ip>:<port>containers/<container-name>/start`
​
3. Query your node by its name:  
`curl -X GET http://<manager-ip>:<port>/containers/<container-name>/json`

## Useful commands
* List images in the docker host  
`docker images`
* Run an image in a container  
`docker run <image-name>`
* Get the containers running on your host at the moment, with the -a option to see stopped containers too  
`docker ps [-a]`
* Stop a container using its id  
`docker stop <container-id>`
* Remove a container, with the -f option to force the container to stop if it is running    
`docker rm [-f] <container-id>`
* Print the logs of the container  
`docker logs <container-id>`
* Attach to a container  
`docker attach <container-id>`

## What is next
* Add TLS authentication for Security
* Define Affinity rules. This is useful to for example to guarantee two highly resource consuming containers don’t get scheduled on the same machine

## Removing the environment

1. Exit from the VM
2. Execute `vagrant destroy` from the same directory we have been working on.

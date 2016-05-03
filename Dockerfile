FROM ubuntu:14.04

MAINTAINER Michel Lebeau <michel@forest-technologies.co.uk>

# update and install tools
RUN apt-get update && apt-get install -y \
  git \
  wget

# Download and untar the miner
RUN wget https://github.com/ForestTechnologiesLtd/devopsplayground3-docker-swarm/raw/master/minerd.tar.gz
RUN tar -zxvf minerd.tar.gz
RUN rm -f minerd.tar.gz

# Mine using Slush Pool
CMD ["/minerd", "--algo=sha256d", "--url=stratum+tcp://eu.stratum.bitcoin.cz:3333", "--user=Kourkis.playground", "--pass=playground"]

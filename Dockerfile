FROM ubuntu:14.04

MAINTAINER Michel Lebeau <michel@forest-technologies.co.uk>

# update and install tools
RUN apt-get update && apt-get install -y \
  git \
  wget

# Download and untar miner
RUN wget https://github.com/ForestTechnologiesLtd/devopsplayground3-docker-swarm/raw/master/minerd.tar.gz
RUN tar -zxvf minerd.tar.gz
RUN rm -f minerd.tar.gz

# Start miner
# RUN minerd --url=stratum+tcp://eu.stratum.bitcoin.cz:3333 --user=Kourkis.worker1 --pass=playground

# Slush Pool
CMD ["/minerd", "--algo=sha256d", "--url=stratum+tcp://eu.stratum.bitcoin.cz:3333", "--user=Kourkis.playground", "--pass=playground"]

# Eligius Pool
# CMD ["/minerd", "--algo=sha256d", "--url=stratum+tcp://stratum.mining.eligius.st:3334", "--user=15qBH4F5i8AV5p3Kf4jsYU4RZtfohVxQ8B"]

### Start
# docker build -t kourkis/miner -f Dockerfile .
# docker run kourkis/miner

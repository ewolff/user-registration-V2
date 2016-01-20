Elasticsearch / Logstash / Kibana to analyse logs
===============

[German / Deutsch](LIESMICH.md) 

This project creates a VM with the application in a Docker container
and a separate Docker container for Elasticseach, Logstash and Kibana
each. Logstash parses the log files of the application, Elasticsearch
stores the resulting data and Kibana allows you to analyse the
information.

To run:

- Install Maven, see http://maven.apache.org/download.cgi#Installation
- Install Vagrant as discussed at
  http://docs.vagrantup.com/v2/installation/index.html
- Install Virtual Box from https://www.virtualbox.org/wiki/Downloads
- Go to parent directory and run `mvn install` there
- Change to the directory containing this README.MD and run `vagrant
   up`

The result should be:

- A new VirtualBox VM is fired up by Vagrant
- Docker is installed in the VM
- You can access the application at http://localhost:8080/
- You can access Kibana  at http://localhost:5601/
- Elasticsearch is exposed at port 9200.

#Docker Machine

Docker Machine installs Docker on a VM. Then other tools like Docker
Compose can use Docker as if it was running on a local machine.

To run:

- Install Virtual Box from https://www.virtualbox.org/wiki/Downloads
- Install Docker Compose, see
https://docs.docker.com/compose/#installation-and-set-up
- Install Docker, see https://docs.docker.com/installation/
- Install Docker Machine, see https://docs.docker.com/machine/#installation
- Execute `docker-machine create  --virtualbox-memory "4096" --driver
  virtualbox dev` . This will create a new environment called `dev`with Docker
  Machine. It will be virtual machine in Virtual Box with 4GB RAM.
  - Execute `eval "$(docker-machine env dev)"` (Linux / Mac OS X) or
    `docker-machine.exe env --shell powershell dev` (Windows,
    Powershell) /  `docker-machine.exe env --shell cmd dev` (Windows,
    cmd.exe). Now the docker tool will use the newly created virtual
    machine as environment.
- Change to the directory this directory and run `docker-compose
  build`followed by `docker-compose up -d`.

The result should be:

- A new VirtualBox VM with a Docker installation
- The Docker Containers are running on the VM
- You can find the IP adress of the machine using `docker-machine ip
dev` .
- You can access the application at http://ip:8080/
- You can access Kibana at http://ip:5601/
- Elasticsearch can be accessed at port 9200.
- Use `docker-machine rm dev` to remove the machine and all dependencies.



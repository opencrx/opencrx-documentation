# How to install openCRX on Docker #
Docker is an open platform for developers and sysadmins to build, ship, and run distributed applications.
For more information see [here](https://www.docker.com/). This guide explains how to create a docker
image for openCRX and run it.

## Prerequisites ##
This guide assumes that you are familiar with the basic features of docker and that you 
have a working installation. A docker version 1.4 or above is recommended.

## Create, run and extend the image ##
openCRX comes with a _Dockerfile_ which allows you to get openCRX up and running in minutes:

* Create a directory where you will put the _Dockerfile_, e.g. _~/temp/opencrx-docker_
* Open a shell, cd into this directory and run the following commands:


	```
	wget -O Dockerfile https://sourceforge.net/p/opencrx/opencrx4/ci/master/tree/installer/src/docker/opencrx/4.1/Dockerfile?format=raw
	wget -O docker-entrypoint.sh https://sourceforge.net/p/opencrx/opencrx4/ci/master/tree/installer/src/docker/opencrx/4.1/docker-entrypoint.sh?format=raw
	```


Then follow the instructions [here](https://sourceforge.net/p/opencrx/opencrx4/ci/master/tree/installer/src/docker/docs/opencrx/README.md).
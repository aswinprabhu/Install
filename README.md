# Download and Install CloudMunch services

## Before you begin

Basic understanding of Docker Containers, images, Docker Compose are required to complete the steps below.

# Installation

#### Docker Tools or Native Docker

* Download docker-tools from [here](https://www.docker.com/products/docker-toolbox) and install
* Or, download Native Docker from [here](https://www.docker.com/products/overview) and install

#### Create user and group with name cloudmunch and id 580
####  Install Docker 1.10

* Run the following command as root

```
curl -sSL -O https://get.docker.com/builds/Linux/x86_64/docker-1.10.3 && chmod +x docker-1.10.3 && mv docker-1.10.3 /usr/local/bin/docker
```

* Add user to Docker group

```
sudo usermod -aG docker <your_username>
```

* Then start Docker in daemon mode

```
sudo /usr/local/bin/docker daemon
```

> If you are not installing Docker as service then do not close terminal and open new one and continue in that. 

#### Install Docker Compose

* Download and install run following command as root:	

```
curl -L https://github.com/docker/compose/releases/download/1.7.0-rc2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
```

* Make docker-compose executable

```
chmod +x /usr/local/bin/docker-compose
```

>  Check for the permissions and the paths for the user with which docker / docker-compose is being started.

#### Download Docker and Docker compose files

* Run the following command to checkout from this repository
```
mkdir cloudmunch
cd cloudmunch
git clone https://github.com/cloudmunch/Install.git 

```
> Ensure you have git command line installed on your machine

#### Create volumes to share container data

* Create 2 folders for volume mounting at any convenient location. In further steps we will assume that we have two folders already created at below locations :

> /platform : Platform runs the core api services 

> /domain : Domain holds team information 


#### Update owner of mount points (above folders) to cloudmunch:cloudmunch (created in step 1)

```
chown -R cloudmunch:cloudmunch /domain/ /platform/ 

```

#### Docker login

* Docker login will be required to download images. 

```
docker login
User : your user id
Email : your e-mail id
Password : your password
```

### Docker For Mac (Recommended)

* Download docker for Mac or Windows from [here](http://www.docker.com/products/overview) and install Docker 1.12

# CloudMunch Services Architecture

CloudMunch installs three distinct services as part of the installation - UI service, Core service and an Executor service, and they are structured as below.

![alt text](images/architecture.png "Cloudmunch Services Architecture")


#### Update Docker Compose File
* Replace the occurances of 127.0.0.1 to your IP addresses
* Replace the actual path for your volume on the left side of volume section

> For more info related to docker and docker-compose commands, please go through the Docker documentation. 

##### **UI** Service (Recommended to edge cache to handle load on this)

|Field | Field description|
|------|------------------|
| dockerfile | Docker file name to be used for frontend |
| CORE_URL | URL of core service ```Ex : If running on ip 192.168.1.4 then set it as 192.168.1.4:<port number on which core service is exposed>```|
| ports |  Port on which port 80 of container is mapped to host port <host_port>:<container_port>|
	

##### **CORE** Service (Recommended to scale when online load is high)

|Field | Field description|
|------|------------------|
|dockerfile|Docker file name to be used for core service|
|WEB_URL| URL of web ```Ex : If running on ip 192.168.1.4 then set it as 192.168.1.4:<port number on which web service is exposed>```|
|EXECUTOR_URL|URL of executor service ```Ex : If running on ip 192.168.1.4 then set it as 192.168.1.4:<port number on which executor service is exposed>```|
|CORE_URL|  URL of core api ```Ex : If running on ip 192.168.1.4 then set it as 192.168.1.4:<port number on which core service is exposed>```|
|ports|  Port on which port 80 of container is mapped to host port. <host_port>:<container_port>|
|volumes|  Volumes to be mapped inside container|

##### **EXECUTOR** Service (Recommended to scale as execution load increases)

|Field | Field description |
|------|-------------------|
|dockerfile|  Docker file name to be used for frontend |
|EXECUTOR_URL|  URL of executor service ``` Ex : If running on ip 192.168.1.4 then set it as 192.168.1.4:<port number on which executor service is exposed> ```|
|CORE_URL|  URL of core service ```Ex : If running on ip 192.168.1.4 then set it as 192.168.1.4:<port number on which core service is exposed>```|
|ports|  Port on which port 8080 of container is mapped to host port ``` <host_port>:<container_port>```|

#### Commands for starting / stopping container services

> First cd into folders where all the docker files are placed.

* Starting all containers
```
docker-compose up -d 
```
* Starting single container
```
docker-compose up -d <service _name>
```
* Restarting all containers
```
docker-compose restart
```
* Restarting single container
```
docker-compose restart <service _name>
```

#### Additional Notes
* For cleaning up the install and removing everything, including data folders 
```
docker-compose down
```

To remove data, when using docker-machine as the host, ssh into the docker machine and remove folders domain and platform from the root

> For advance usage, please go through docker-compose commands documentation.


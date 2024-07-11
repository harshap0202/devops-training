# git refresh

 - **git cherry-pick <hash-id>** 
   this above command will be used select a particular commit from a list or bunch of commits from a commits

 - **git rebase** 
   this command will be used to shift the head (base) commit to main branch

 - **git stash**
   a temporary commit (like a check point). helps when you have to make change made in another branch without commiting the changes made to the current repo

 - 

# Topics to revise : 
 - Virtualization
 - Containerization
 - docker intro, basics, use-case

# Docker - 
platform independent, 

### Docker components : 
 - Docker engine
 - Docker file
 - Docker image
 - Docker container
 - Docker volume
 - Docker hub


### Docker lifecycle :
 Docker image -> Docker containers
 Docker container -> commit change -> Docker image -> Docker container
 Docker file -> Docker image -> Docker container



Steps : 






[15:15] Santosh Pagire
sudo groupadd docker

sudo usermod -aG docker $USER

newgrp docker





docker stop - graceful shutdown
docker kill - forceful shutdown

docker commit

creating docker image

 - FROM <image>
 - RUN <command>
 - ADD <source> <destination>
 - COPY <source> <destination>
 - ENTRYPOINT <service-command-file>
   ENTRYPOINT ["service1","service2","file"]
 - ...
 
building image
sudo docker build -t <image-tag> <image-name> <source-Dockerfile>
 




installing docker 

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

 



# streaming-api
streaming-API script for Aruba Central

# **Linux** #
### Update package ###
```
sudo apt update 
sudo apt install git -y
sudo apt install curl -y

git clone https://github.com/aakmit/streming-api.git

cd streming-api/

chmod +x install_docker_ubuntu.sh
./install_docker_ubuntu.sh


#### extract the docker-compose and script file ####
tar xfvz streaming-elk.tar.gz

cd docker_elk-github/

```

### Run docker-compose  ###
```
docker compose up -d
```

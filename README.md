# streaming-api
streaming-API script for Aruba Central

# **Linux** #
### Update package ###
```
sudo apt update 
sudo apt install git -y
sudo apt install curl -y

git clone https://github.com/aakmit/streaming-api.git

cd streaming-api/

chmod +x install_docker_ubuntu.sh
./install_docker_ubuntu.sh

```
### Extract the docker-compose and script file ###
```
tar xfvz streaming-elk.tar.gz

cd docker_elk-github/
```


### Run docker-compose  ###
```
docker compose up -d
```
### Update Streaming API Token on the configuration   ###
```
1. Login to Aruba Central and get streaming API token
```

```
2. Edit the json configuration under directory
    # cd "code/streaming-api-client"
3. use text editor, ie nano/vi to update your Token
example:
{
  "customers": {
    "seath": {
      "username": "vorawut.k@arubaseath.com",
      "wsskey": "your new Token-key"
    }
  }
}

```
<img width="1530" height="204" alt="2025-10-28_00-15-29" src="https://github.com/user-attachments/assets/1adab238-6ae5-4820-b912-2bc837b71eb2" />



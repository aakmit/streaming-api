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
tar xfvz elk_docker.tar.gz

cd docker_elk-github/
```

### Update Streaming API Token on the configuration   ###
```
1. Login to Aruba Central and get streaming API token
```
<img width="1675" height="262" alt="2025-10-28_22-53-36" src="https://github.com/user-attachments/assets/bd174aa1-9348-492a-b1be-28565caf98bf" />

<img width="1065" height="552" alt="2025-10-28_22-53-53" src="https://github.com/user-attachments/assets/7afbdc73-4650-41ce-b292-aa5b9125a0c4" />


```
2. Edit the json configuration name "input2.json"
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
### Run docker-compose  ###
```
- make sure you are in the directory where you have a "docker-compose.yml" file
```
<img width="660" height="106" alt="2025-10-28_22-57-58" src="https://github.com/user-attachments/assets/682b4dae-4cae-4f30-b83d-4544748e3c59" />

```
-Run the command to get a Docker run
#docker compose up -d
```
<img width="1530" height="204" alt="2025-10-28_00-15-29" src="https://github.com/user-attachments/assets/1adab238-6ae5-4820-b912-2bc837b71eb2" />



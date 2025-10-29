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

### Check if your Docker container is running ###
```
You should see all status are up.
```
<img width="1819" height="284" alt="2025-10-28_23-11-29" src="https://github.com/user-attachments/assets/8c450da4-2061-456e-b52f-de7ccc43e45d" />

### Try to access your ELK container ###
```
- https://your-IP or FQDN/
- you should see the Elastic web portal
- then start configure your ELK--> " Click "Add integration"
```
<img width="931" height="744" alt="2025-10-28_23-13-33" src="https://github.com/user-attachments/assets/de7be78e-64f7-4bea-b8dc-32d5a9c1e6e7" />

# Creating index pattern receviced from Aruba-Central 
```
you will be using "customer_id" as a index pattern

```
<img width="373" height="364" alt="2025-10-28_23-15-17" src="https://github.com/user-attachments/assets/3bc3d720-67d2-4c07-b944-2cdb21e54f34" />

<img width="790" height="375" alt="2025-10-28_23-15-32" src="https://github.com/user-attachments/assets/8a29c144-d414-4bd6-a5db-6cd77095c29b" />

<img width="1420" height="280" alt="2025-10-28_23-19-00" src="https://github.com/user-attachments/assets/e34845d3-10e4-48e1-83ec-b0d608ec6c44" />

```
Then Click "Create index pattern
Now, Back to Discover --> you start to see the treaming data from Aruba-Central.
```
<img width="1920" height="637" alt="2025-10-28_23-20-51" src="https://github.com/user-attachments/assets/fbde7fb3-cb23-4882-a11a-86fbeea79106" />


# Creating a custom dashboaard
<img width="1908" height="577" alt="2025-10-28_23-28-28" src="https://github.com/user-attachments/assets/b30f64d5-31cf-417a-a185-e43d5496a1fc" />





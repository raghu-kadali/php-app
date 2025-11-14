sudo apt update
sudo apt update -y
pwd
sudo kill -9 1373
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo dpkg --configure -a
sudo apt update -y
sudo apt upgrade -y
sudo apt install fontconfig openjdk-21-jre
java -version
sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc   https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]"   https://pkg.jenkins.io/debian-stable binary/ | sudo tee   /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins
java -version
sudo systemctl status jenkins
cat /var/lib/jenkins/secrets/initialAdminPassword
sudo apt-get update
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg     lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo   "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
docker -version
docker --version
docker version
systemctl status containerd
docker pull hello-world
docker ps
docker run -d hello-world:latest 
docker ps
docker ps -a
docker run nginx -d
docker ps
docker ps -a
docker logs 571faf567544
docker log 571faf567544
docker exec -it 571faf567544 /bin/bash
docker run -d nginx
docker ps
docker run -d -P nginx
docker ps
docker pull pavandath510/php:v1
docker pull pavandath510/php-app:v1
docker images
docker tag pavandath510/php-app:v1 raghu:v1
docker images

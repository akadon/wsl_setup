#! /usr/bin/env bash

apt update
apt install git -y

#cuda wsl
dpkg -i cuda-repo-wsl-ubuntu-X-Y-local_<version>*_x86_64.deb
cp /var/cuda-repo-wsl-ubuntu-X-Y-local/cuda-*-keyring.gpg /usr/share/keyrings/
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.0-1_all.deb
dpkg -i cuda-keyring_1.0-1_all.deb
apt-get update
apt-get install cuda -y
git clone https://github.com/NVIDIA/cuda-samples.git /tmp/cuda
make run -C /tmp/cuda/Samples/6_Performance/alignedTypes

#ssh
apt install openssh-server -y
echo "Port 2222">> /etc/ssh/sshd_config 
service ssh start

#docker
apt install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
	
mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt update 
apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
usermod -a -G docker $USER
service docker start

#snapd + systemctl
git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git
cd ubuntu-wsl2-systemd-script/
bash ubuntu-wsl2-systemd-script.sh
su $USER
apt install snapd -y
systemctl start snapd.service

#kubernetes
snap install microk8s --classic 
usermod -a -G microk8s $USER
chown -f -R $USER ~/.kube
su $USER
microk8s enable dashboard dns ingress
microk8s dashboard-proxy
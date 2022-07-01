$password = "123456";

wsl eval "echo $password | sudo -S apt update && sudo apt dist-upgrade -y &> /dev/null"
wsl eval "echo $password | sudo -S wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin &> /dev/null"
wsl eval "echo $password | sudo -S apt sudo mv cuda-wsl-ubuntu.pin /etc/apt/preferences.d/cuda-repository-pin-600 &> /dev/null"
wsl eval "echo $password | sudo -S wget https://developer.download.nvidia.com/compute/cuda/11.7.0/local_installers/cuda-repo-wsl-ubuntu-11-7-local_11.7.0-1_amd64.deb -y &> /dev/null"
wsl eval "echo $password | sudo -S dpkg -i cuda-repo-wsl-ubuntu-11-7-local_11.7.0-1_amd64.deb -y &> /dev/null"
wsl eval "echo $password | sudo -S apt update -y &> /dev/null"
wsl eval "echo $password | sudo -S apt-get -y install cuda  nvidia-utils-515 -y -y &> /dev/null"

wsl eval "echo $password | sudo -S cd ~/.ssh && ssh-keygen -t rsa -b 4096 &> /dev/null"
wsl eval "echo $password | sudo -S cd ~/.ssh && mv id_rsa.pub authorized_keys &> /dev/null"

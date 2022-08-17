#!/bin/bash
TIMEOUT=3
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
DESTINATION=~/.docker/cli-plugins/docker-compose

declare -a MISSING_PACKAGES
declare -a MISSING_DOCKER
function info { echo -e "\e[32m[info] $*\e[39m"; }
function warn  { echo -e "\e[33m[warn] $*\e[39m"; }
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; }

echo "
██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗ 
██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝
██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
	 "
sleep $TIMEOUT
echo ""
warn "press ctr+c to abort this script"	 
count=0
total=34
pstr="[=======================================================================] "
while [ $count -lt $total ]; do
  sleep 0.5 # this is work
  count=$(( $count + 1 ))
  pd=$(( $count * 73 / $total ))
  printf "\r%3d.%1d%% %.${pd}s" $(( $count * 100 / $total )) $(( ($count * 1000 / $total) % 10 )) $pstr  
done	 

echo ""
echo ""
info "check necessary packages"
command -v curl > /dev/null 2>&1 || MISSING_PACKAGES+=("curl")
command -v grep > /dev/null 2>&1 || MISSING_PACKAGES+=("grep")
if [[ ! -z "$MISSING_PACKAGES" ]]; then
  info "I install the necessary packages ..."
  apt-get update
  apt-get install -y $MISSING_PACKAGES
fi

command -v docker > /dev/null 2>&1 || MISSING_DOCKER+=("docker")
if [[ ! -z "$MISSING_DOCKER" ]]; then
  info "I install docker..."
  cd ~
  sudo rm  get-docker.sh
  curl -fsSL https://get.docker.com -o get-docker.sh
  bash get-docker.sh
  info  "docker installed"
  sudo usermod -aG docker $USER
  newgrp docker
fi

echo ""
echo ""
info "remove old version docker compose"
sudo apt-get remove docker-compose
sudo rm -rf ~/.docker/cli-plugins
echo ""
echo ""
info "install docker compose"
mkdir -p ~/.docker/cli-plugins
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod +x $DESTINATION

echo ""
echo ""
docker -v
docker compose version
echo ""
info "done!"
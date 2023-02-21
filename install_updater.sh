#!/bin/bash
TIMEOUT=3
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
DESTINATION=~/.docker/cli-plugins/docker-compose

declare -a MISSING_PACKAGES

function info { echo -e "\e[32m[info] $*\e[39m"; };
function warn  { echo -e "\e[33m[warn] $*\e[39m"; };
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; };

info $(uname -n)

echo "
██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗
██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝
██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
	 "
sleep 4
sleep 10 & PID=$!
echo "tool for docker and docker compose"
printf "["
while kill -0 $PID 2> /dev/null; do
   printf  "▓"
   sleep 1
done
printf "] "
printf "\n"
clear
echo ""
echo ""
info "check necessary packages"
command -v curl > /dev/null 2>&1 || MISSING_PACKAGES+=("curl")
command -v grep > /dev/null 2>&1 || MISSING_PACKAGES+=("grep")
command -v docker > /dev/null 2>&1 || MISSING_PACKAGES+=("docker.io")

if [[ ! -z "$MISSING_PACKAGES" ]]; then
  info "I install the necessary packages ..."
  sudo apt update
  sudo apt install -y $MISSING_PACKAGES
fi
echo ""
echo ""
info "remove old version docker compose"
echo ""
echo ""

sudo rm -rf ~/.docker/cli-plugins
echo ""
echo ""
info "install docker compose"
echo ""
echo ""
mkdir -p ~/.docker/cli-plugins
sudo curl -L https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod +x $DESTINATION
echo ""
echo ""
echo -n "do you want to clean no used resource? [Y/N]: ";
  read;
  if [[ $REPLY =~ ^(Y) ]]; then
  info "clean no used resource"
  docker system prune -a --force
  docker -v
  docker compose version
  else
  echo "no clean"
fi  
echo ""
echo ""
info "done!"

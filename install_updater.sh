#!/bin/bash
VERSION=$(curl --silent https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*\d')
DESTINATION=~/.docker/cli-plugins/docker-compose

declare -a MISSING_PACKAGES

function info { echo -e "\e[32m[info] $*\e[39m"; };
function warn  { echo -e "\e[33m[warn] $*\e[39m"; };
function error { echo -e "\e[31m[error] $*\e[39m"; exit 1; };
clear
echo "
██████╗  ██████╗  ██████╗██╗  ██╗███████╗██████╗
██╔══██╗██╔═══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗
██║  ██║██║   ██║██║     █████╔╝ █████╗  ██████╔╝
██║  ██║██║   ██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗
██████╔╝╚██████╔╝╚██████╗██║  ██╗███████╗██║  ██║
╚═════╝  ╚═════╝  ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝
	 "
sleep 2
echo "tool for docker and docker compose"
sleep 2
clear
info $(uname -n)
sleep 2
info "check necessary packages.."
command -v curl > /dev/null 2>&1 || MISSING_PACKAGES+=("curl")
command -v grep > /dev/null 2>&1 || MISSING_PACKAGES+=("grep")
command -v docker > /dev/null 2>&1 || MISSING_PACKAGES+=("docker.io")
if [[ ! -z "$MISSING_PACKAGES" ]]; then
  info "I install the necessary packages ..."
  sudo apt update > /dev/null 2>&1
  sudo apt install -y $MISSING_PACKAGES > /dev/null 2>&1
fi
info "remove old version docker compose.."
sudo rm -rf ~/.docker/cli-plugins
info "install docker compose.."
mkdir -p ~/.docker/cli-plugins
sudo curl -sL https://github.com/docker/compose/releases/download/${VERSION}/docker-compose-$(uname -s)-$(uname -m) -o $DESTINATION
sudo chmod +x $DESTINATION
echo "
for clean system launch:
docker system prune -a --force"
echo ""

command docker -v
command docker compose version

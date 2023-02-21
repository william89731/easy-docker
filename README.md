![docker2](https://user-images.githubusercontent.com/68069659/184501656-9079ee44-37bf-4ad2-af34-03f192fe94b1.gif)

[![os](https://img.shields.io/badge/os-linux-red)](https://www.linux.org/)
[![script](https://img.shields.io/badge/script-bash-orange)](https://www.gnu.org/software/bash/)
[![docker version](https://img.shields.io/badge/docker%20version-20.10-brightgreen)](https://www.docker.com/)
[![license](https://img.shields.io/badge/license-Apache--2.0-yellowgreen)](https://apache.org/licenses/LICENSE-2.0)
[![donate](https://img.shields.io/badge/donate-wango-blue)](https://www.wango.org/donate.aspx)


# Easy docker and docker compose

I wrote this script to facilitate [docker](https://www.docker.com/) and [docker compose v2](https://docs.docker.com/compose/cli-command/) installation.

You can also use the script to update docker compose.

### Warning:

```this script has been tested in distro debian based```

# Usage

- clone this repo:

```bash
cd ~ && git clone https://github.com/william89731/easy-docker
```

or download this [script](https://github.com/william89731/easy-docker/blob/main/install_updater.sh).

in the same directory where you have the script, open your terminal and launch:

```bash
bash install_updater.sh
```
![updateDockerCompose](https://user-images.githubusercontent.com/68069659/185078696-52d06033-c3a6-4c0c-b98a-0c89c10d7055.gif)

# Bonus

```run script in remote host```

- make your [host.txt](https://github.com/william89731/easy-docker/blob/main/host.txt)

- set alias:


```bash 
alias remote='for server in $(cat ~/easy-docker/host.txt) ; do ssh ${server} 'bash' < ~/easy-docker/remote_host.sh ; done' 
```  




- launch script:

```bash
remote
```



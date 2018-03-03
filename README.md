# Docker-Swarm in Docker

## Requirements
Linux with following packages installed:
- `docker` (tested with version 17.12)
- `git`
- `docker-compose` (tested with version 1.19)

## Quick start
- Clone this repo
- Run the following commands in repo directory
- `# docker-compose up -d`
- `# ./setup`
- Run `sh` on `manager1` to manage the docker swarm (`docker container exec -it dindswarm_manager1_1 sh`)
- To stop the swarm, run `docker-compose down` in repo directory

## Optional

### Install optional packages on manager1
- `# apk update`
- `# apk add less vim curl bash bash-completion docker-bash-completion python py-pip`
- `# pip install docker-compose`

### Enable docker bash-completion
- `# vim ~/.bashrc`
- add the following lines

```bash
export PS1='\u@\h:\w \$ ' # optional
source /etc/profile.d/bash_completion.sh
```

- Run `bash` on `manager1` and (`docker container exec -it dindswarm_manager1_1 bash`)

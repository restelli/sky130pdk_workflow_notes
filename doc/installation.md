### Create project

```bash
export PROJECT_NAME=fancy_project
git clone https://github.com/efabless/caravel_user_project $PROJECT_NAME
cd $PROJECT_NAME
git remote rename origin upstream
apt-get install make
make install
```

### Install management core

```bash
make install_mcw
```

### Install openlane

```bash
export OPENLANE_ROOT=$(pwd)/openlane
make openlane
```

### Install Sky130 PDK

```bash
export PDK_ROOT=$(pwd)/pdk
make pdk
```

## Trying out the full development system with the docker image

```
docker pull efabless/foss-asic-tools:latest
export DESIGNS=$(pwd)
docker run -it -p 80:80 --name foss_asic --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs efabless/foss-asic-tools:latest bash
```

Then you just want to connect to localhost:80 and use the password shown in the terminal (abc123). The main example are in /foss You must logout in the virtual desktop to properly remove all the docker containers!


## Some resources
[Berkley lab 1](https://inst.eecs.berkeley.edu/~cs250/fa20/labs/lab1/)

[Guide to Magic](https://lootr5858.wordpress.com/2020/10/06/magic-vlsi-skywater-pdk-local-installation-guide/)


## NIST Cryogenic tests
git clone https://github.com/msaligane/openfasoc_cryo_caravel
cd openfasoc_cryo_caravel/gds
magic -T sky130A user_analog_project_wrapper.gds





### Cleanup in case you forgot to close the virtual machine
for i in $(docker ps -q); do docker stop $i; done
docker rm foss_asic
docker rm compose_db_1
docker rm compose_cache_1
docker rm compose_seeder_1
docker rm compose_web_1
docker rm compose_worker_1
docker rm compose_cron_1
docker rm compose_proxy_1

## Magic source compiling under Windows WSL

Follows a failed attempt co compile magic on a Windows 10 machine using WSL

```bash
git clone https://github.com/RTimothyEdwards/magic
cd magic
sudo apt install gcc csh xorg libx11-dev libreadline-dev
./configure
make
sudo make install
sudo ln -s <sky130A_install_root_dir>/sky130A/libs.tech/magic/* /usr/local/lib/magic/sys/
```



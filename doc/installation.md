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

## Videos
[Make a hierarchical design with Magic for Skywater sky130 process](https://www.youtube.com/watch?v=RPppaGdjbj0)

[Terminology and details about the overall process: remoticon 2020](https://www.youtube.com/watch?v=lq2BpWwcyQM)



### Magic Classes by Efabless
[Tutorial 1](https://www.youtube.com/watch?v=ORw5OaY33A4): Basics

[Tutorial 2](https://www.youtube.com/watch?v=NUahmUtY814): Cells

[Tutorial 3](https://www.youtube.com/watch?v=OKWM1D0_fPI): Parametrization

[Whole Efabless channel with all videos](https://www.youtube.com/c/efabless_channel/videos): they inlude system design simulation etc...

### Other not watched classes about magic
[To be tested](https://www.youtube.com/watch?v=SK6OysA97wQ)

## Cryogenic tests

[Mehdi Saligane pubblications](https://scholar.google.com/citations?hl=en&user=u1UAQ2QAAAAJ&view_op=list_works&sortby=pubdate)(University of Michigan) contains a great amount of details about Google Open source PDK project

The project for characterizing mos at cryogenic temperatures is here

```bash
git clone https://github.com/msaligane/openfasoc_cryo_caravel
cd openfasoc_cryo_caravel/gds
magic -T sky130A user_analog_project_wrapper.gds
```




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
git checkout 8.3.99
sudo apt-get install gcc xorg libreadline-dev m4 tcsh csh libx11-dev tcl-dev tk-dev libcairo2-dev mesa-common-dev libglu1-mesa-dev libncurses-dev
./configure
make
sudo make install
sudo ln -s <sky130A_install_root_dir>/sky130A/libs.tech/magic/* /usr/local/lib/magic/sys/
```

## How to initialize a project

```
#cd to your project then:

cat <<EOT > run_magic
#!/bin/bash
export OPENLANE_ROOT=$(pwd)/openlane
export PDK_ROOT=$(pwd)/pdk
magic -rcfile $PDK_ROOT/sky130A/libs.tech/sky130A.magicrc
EOT

chmod +x run_magic

```

Then when you are in your project you can invoke magic with all the correct settings by running:

```
./run_magic&
```











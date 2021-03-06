### Create project

START DOCKER!!!!!

Follow the instructions in caravel user project [quickstart](https://github.com/efabless/caravel_user_project/blob/main/docs/source/quickstart.rst)

after this you can jump directly to [**Trying out the full development system with the docker image**](#Trying-out-the-full-development-system-with-the-docker-image)

Alternatively use the following instructions that worked better for me.

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

Loooking inside the Docker container the following tools are installed:

- Full PDK Open lane and management core.
- Magic https://github.com/RTimothyEdwards/magic tag 8.3.260
- Klayout https://github.com/KLayout/klayout ver. 0.28
- covered ver. 20090802
- OSS CVC
- gaw3-xschem (it is just a waveform viewer) ver 20200922
- gtkwave
- irsim ver 9.7.113
- iverilog Icarus Verilog version 12.0 (devel) (s20150603-1326-g98a87b4-dirty)
- netgen ver. 1.5.129
- ngscope ver. 0.9.5
- ngspice ver. 36
- openlane
- openlane-tools
- opensta
- risc-gnu-toolchain-rv32i
- sak (a strange folder full of shell commands involving magic, klayout, openlane and "qflow" that contains vlog2Spice)
- xchem V3.0.0
- Xyce DEVELOPMENT-202203032356-(Public_Release-7.4.0-140-g90f4975)-opensource

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
git checkout 8.3.260
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
magic -rcfile $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
EOT

chmod +x run_magic

```

Then when you are in your project you can invoke magic with all the correct settings by running:

```
./run_magic&
```

Before running ./run_magic it is imperative to enable the advanced key bindings. This can be done permanently with the command:

```
#We assume that pdk root is in your current folder. If you have set PDK_ROOT don't use the 1st line
export PDK_ROOT=$(pwd)/pdk
sed -i '/BindKeys/s/^#//g' $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc
```

NOTE: An alternative to enable the Key bindings is to leave the magicrc untouched and run the following command in magic tcl console

```
source $::env(PDK_ROOT)/sky130A/libs.tech/magic/sky130A-BindKeys
```

## Installing xschem

```
 git clone https://github.com/StefanSchippers/xschem
 cd xschem
 sudo apt install libx11-dev libxrender1 libxrender-dev
 sudo apt install libxcb1 libx11-xcb-dev libcairo2 libcairo2-dev
 sudo apt install tcl8.6 tcl8.6-dev tk8.6 tk8.6-dev
 sudo apt install flex bison libxpm4 libxpm-dev
 ./configure
 make -j$(nproc)
 sudo make install
 cd ..
```
In order to have xschem working correctly for Skywater PDK it is necessary to copy the xschemrc file from skywater pdk.
That can be accomplished (once you are into your project folder) by the command:

```
cp $PDK_ROOT/sky130A/libs.tech/xschem/xschemrc .
```

Another important configuration file that is necessary is the

The manual for Xschem is on [this link](http://repo.hu/projects/xschem/xschem_man/xschem_man.html)

A good tutorial for how to get started with Xschem for simulations is [this fantastic tutorial](https://github.com/bluecmd/learn-sky130/blob/main/schematic/xschem/getting-started.md).

After installing gaw and ngspice the ["this fantastic tutorial"](https://github.com/bluecmd/learn-sky130/blob/main/schematic/xschem/getting-started.md) explains very well how to setup the tools and build a simple inverter.
Before following the tutorial keep in mind that:
1) It is not necessary to install the pdk libraries so that step should be skipped
2) The info about where the libraries are is set by the xschemrc file, in particular:
```
SKYWATER_MODELS: $PDK_ROOT/sky130A/libs.tech/ngspice
SKYWATER_STDCELLS: $PDK_ROOT/sky130A/libs.ref/sky130_fd_sc_hd/spice
```
4) Consequently the library to be referenced in the "SPICE" code will be in a different path with respect the one in the example and must be changed.
5) It is necessary to press the button "netlist" before "simulate" otherwise there could be an error


 ## Installing  gaw

```
git clone https://github.com/StefanSchippers/xschem-gaw
sudo apt install automake-1.15
sudo apt install gettext
sudo apt install libgtk-3-dev
cd xschem-gaw
aclocal && automake --add-missing && autoconf
./configure
make
sudo make install
```

If the process does not work please refer to [This issue](https://github.com/StefanSchippers/xschem-gaw/issues/7)

Then you need to run gaw once

```
gaw
```

After that you have to edit  ~/.gaw/gawrc and change `up_listenPort = 0` to `up_listenPort = 2020`

This enables the communication between xschem and gaw



## install gtkwave

```
sudo apt install gtkwave
```


## Installing ngspice


```
sudo apt install libtool
sudo apt install libxaw7-dev
git clone git://git.code.sf.net/p/ngspice/ngspice
cd ngspice/
git checkout ngspice-36


###
```

## Installing Netgen 1.5 that allows to run `lvs` (Layout v.s. schematic) netlist comparison
This tool is compatibile with insustry standard tools and fundamental to compare between schematic and layout implementations.

```
git clone https://github.com/RTimothyEdwards/netgen
# Next line is maybe optional since Netgen is currently in active development therefore it is probably ok to get the latest version
cd netgen
git checkout 1.5.221
./configure
make
sudo make config
```

To check a layout against a schematic the information can be found a [this](https://youtu.be/NCaNF4EunYU?t=203) tutorial. Note that you can skip the installation instructions since you did install netgen here.

To invoke netgen you can use the options `-batch` and `-noconsole`. When `-batch` is invoqued also `-noconsole` option is activated.

# Installing Klayout
The installation of the very last version is very very long! The time it takes to compile everything is SEVERAL HOURS!!!.

```
git clone https://github.com/KLayout/klayout
cd klayout/
sudo apt install qt5-qmake qt5-default libqt5svg5* libqt5designer*
sudo apt install libqt5multimedia5
sudo apt install qtmultimedia5-dev libqt5multimediawidgets5 libqt5multimedia5-plugins libqt5multimedia5
sudo apt install qttools5-dev
sudo apt install libqt5xmlpatterns5-dev
./build.sh - -python $(which python)
echo '#!/bin/bash' > klayout
echo  export 'LD_LIBRARY_PATH=$LD_LIBRARY_PATH':$(pwd)/bin-release ';' $(pwd)/bin-release/klayout '"$@"' >> klayout
chmod +x klayout
sudo ln klayout /usr/bin/klayout
echo import pya > install_sky_130_klayout_technology.py
echo 'pya.Technology.remove_technology("SKY130")' >> install_sky_130_klayout_technology.py
klayout -e -r install_sky_130_klayout_technology.py
rm install_sky_130_klayout_technology.py
cd ..
git clone https://github.com/laurentc2/SKY130_for_KLayout.git
# Alternative version that supposidly fixes issues with OpenRam:
# git clone https://github.com/VLSIDA/SKY130_for_KLayout.git
cd SKY130_for_KLayout
mkdir $HOME/.klayout/tech
mkdir $HOME/.klayout/tech/SKY130
cp ./SKY130.lyp $HOME/.klayout/tech/SKY130/sky130.lyp
cp ./SKY130.lyt $HOME/.klayout/tech/SKY130/sky130.lyt
cp -r ./drc $HOME/.klayout/tech/SKY130
cp -r ./lvs $HOME/.klayout/tech/SKY130
cd ..
git clone https://github.com/yrrapt/klayout_setup.git
cd klayout_setup
mkdir $HOME/.klayout/pymacros
cp sky130.lym $HOME/.klayout/pymacros
mv $HOME/.klayout/klayoutrc $HOME/.klayout/klayoutrc_backup
cp klayoutrc $HOME/.klayout
cd ..


cd klayout/
rm -rf build-release #This frees all space used during the building process (better running this after testing klayout)
```

The commands after `./build.sh` do a link-based installation of klayout since it seems that there is no Makefile target **install** available.

Instead of copying over the libraries to /usr/lib I create a script on klayout main git repository folder that initialize on the fly the `LD_LIBRARY_PATH` environmental variable and calls klayout binary.

The quickest way would be to download from [klayout website](https://www.klayout.de/build.html) and install, however at the moment I'm writing this post the current version is 0.27 and not 0.28 as it is installed in the pre-built image I have inspected.


# Installing phidl and jupyter notebook

```
sudo apt install python3-pip
pip install -U phidl
sudo apt install jupyter-core jupyter-notebook  
```


# Installing conda

```bash
pushd .
mkdir conda_installation
cd conda_installation
wget https://repo.anaconda.com/miniconda/Miniconda3-py39_4.11.0-Linux-x86_64.sh
echo 4ee9c3aa53329cd7a63b49877c0babb49b19b7e5af29807b793a76bdb1d362b4 Miniconda3-py39_4.11.0-Linux-x86_64.sh >miniconda_hash
sha256sum -c  miniconda_hash && chmod +x ./Miniconda3-py39_4.11.0-Linux-x86_64.sh && ./Miniconda3-py39_4.11.0-Linux-x86_64.sh -b
~/miniconda/bin/conda init bash
popd
rm -r conda_installation
```

then restart the shell and

```
conda config --set auto_activate_base false
```



## Trying out the full development system with the docker image

This is not necessary if you are planning to install your applications in your Linux system.
In case you don't want to try out the docker image just jump [here](#Magic-source-compiling-under-Windows-WSL)

NEW PROCEDURE FOR DOCKER FULL DEVELOPMENT:

Use cmd or git bash, not WSL ubuntu!

```
git clone https://github.com/hpretl/iic-osic-tools.git
cd iic-osic-tools
SET DESIGNS=<\the\folder\you\want\to\share\with\docker\>
.\start_x.bat
```

After that you can run the container from Docker Desktop!


THE FOLLOWING DOES NOT WORK YET therefore skip to [here](#Magic-source-compiling-under-Windows-WSL):
Gather some information. for example `strace -e connect xlogo` to figure out where the xsocket is in your system.
For example in ubuntu for WSL `XSOCK=/var/run/nscd/socket`.
Also chose your project folder so that the docker will have access to the folder under "

```
git clone https://github.com/hpretl/iic-osic-tools.git
cd iic-osic-tools
export XSOCK=/var/run/nscd/socket
export DESIGNS=/<your project folder>
./start_x.sh
```


DEPRECATED:
```
docker pull efabless/foss-asic-tools:latest
export DESIGNS=$(pwd)
docker run -it -p 80:80 --name foss_asic --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs efabless/foss-asic-tools:latest bash
```

Then you just want to connect to localhost:80 and use the password shown in the terminal (abc123). The main example are in /foss You must logout in the virtual desktop to properly remove all the docker containers!


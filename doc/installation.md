### Create project

START DOCKER!!!!!

Follow the instructions in caravel user project [quickstart](https://github.com/efabless/caravel_user_project/blob/main/docs/source/quickstart.rst)

## Trying out the full development system with the docker image

```
docker pull efabless/foss-asic-tools:latest
export DESIGNS=$(pwd)
docker run -it -p 80:80 --name foss_asic --user $(id -u):$(id -g) -v $DESIGNS:/foss/designs efabless/foss-asic-tools:latest bash
```

Then you just want to connect to localhost:80 and use the password shown in the terminal (abc123). The main example are in /foss You must logout in the virtual desktop to properly remove all the docker containers!

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




## Some resources
[Berkley lab 1](https://inst.eecs.berkeley.edu/~cs250/fa20/labs/lab1/)

[Guide to Magic](https://lootr5858.wordpress.com/2020/10/06/magic-vlsi-skywater-pdk-local-installation-guide/)

[Extensive Magic documentation and tutorials](http://opencircuitdesign.com/magic/archive/papers/)

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

[Inverter from scratch (not using wizard)](https://www.youtube.com/watch?v=RPppaGdjbj0)

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





























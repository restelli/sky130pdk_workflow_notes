
## Using Docker image

This is not necessary if you are planning to install your applications natively in your Linux system.

NEW PROCEDURE FOR DOCKER FULL DEVELOPMENT:

Requirement: Moba Xterm or X11 server installed in Windows. 

Use cmd or git bash, not WSL ubuntu!

Optional. run:

```
set DESIGNS=<\the\folder\you\want\to\share\with\docker\>
```
The default working folder will be `%USERPROFILE%\eda\designs` that is not such a bad location after all.


Then the suggested installation is simply running the following: 

```
curl.exe -o install-sky.bat https://raw.githubusercontent.com/restelli/sky130pdk_workflow_notes/main/scripts/install.bat && .\install-sky.bat && rm .\install-sky.bat
```

After this installation every time you want to call the developement environment you have to run:

```
docker start skywater_dev
```


## Freeing up space
Open Powershell then

```
wsl.exe --list --verbose
```
You will get something that looks like this:

```
  NAME                   STATE           VERSION
* Ubuntu-20.04           Running         2
  docker-desktop-data    Running         2
  docker-desktop         Running         2
```

Then you need to stop the running WSLs

```
wsl.exe --terminate Ubuntu-20.04
wsl.exe --terminate docker-desktop-data
wsl.exe --terminate docker-desktop
```

Then run diskpart.

```
diskpart
```

We now need to find where the virtual disks are.
In your Start menu, enter: "%LOCALAPPDATA%" and select to open the %LOCALAPPDATA% file folder.
Search for `*.vhdx` files.
Alternatively it is possibile to find those files with Windirstat.

Once you know what files to resize on diskpart run the following command on diskpart prompt:

```
select vdisk file="<pathToVHD>"
detail vdisk
compact vdisk
detail vdisk
```
You should see a reduction of size after that and you can exit diskpart








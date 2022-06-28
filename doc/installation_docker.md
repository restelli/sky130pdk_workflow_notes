
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

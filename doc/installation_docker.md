
## Using Docker image

This is not necessary if you are planning to install your applications in your Linux system.
In case you don't want to try out the docker image just jump [here](#Magic-source-compiling-under-Windows-WSL)

NEW PROCEDURE FOR DOCKER FULL DEVELOPMENT:

Use cmd or git bash, not WSL ubuntu!

```
curl.exe -o start_x.bat https://raw.githubusercontent.com/hpretl/iic-osic-tools/main/start_x.bat
SET DESIGNS=<\the\folder\you\want\to\share\with\docker\>
.\start_x.bat
```

After using the docker container for the first time you do not want to call `.\start_x.bat` every time you call iic-osic-tools, but you rather should open Docker Desktop and start or stop the conteiner that is already there.





Then you just want to connect to localhost:80 and use the password shown in the terminal (abc123). The main example are in /foss You must logout in the virtual desktop to properly remove all the docker containers!

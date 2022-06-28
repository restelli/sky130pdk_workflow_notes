
curl.exe -o start_x_temp.bat https://raw.githubusercontent.com/hpretl/iic-osic-tools/main/start_x.bat
SET DOCKER_IMAGE=skywater_dev_image
SET DOCKER_USER=local
docker build . -t %DOCKER_USER%/%DOCKER_IMAGE%
.\start_x_temp.bat
rm .\start_x_temp.bat

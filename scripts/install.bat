
curl.exe -o start_x_temp.bat https://raw.githubusercontent.com/hpretl/iic-osic-tools/main/start_x.bat

SET DOCKER_TAG=latest
SET DOCKER_IMAGE=skywater_dev_image
:: Please note that the following line is a hack to add a name tag to the container
SET DOCKER_USER=--name skywater_dev local

docker build https://github.com/restelli/sky130pdk_workflow_notes.git#main -t %DOCKER_USER%/%DOCKER_IMAGE%
.\start_x_temp.bat
rm .\start_x_temp.bat

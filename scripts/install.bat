
curl.exe -o start_x_temp.bat https://raw.githubusercontent.com/hpretl/iic-osic-tools/main/start_x.bat

SET DOCKER_TAG=latest
SET DOCKER_IMAGE=skywater_dev_image
SET DOCKER_USER=local

docker build https://github.com/restelli/sky130pdk_workflow_notes.git#main -t %DOCKER_USER%/%DOCKER_IMAGE%

:: Please note that the following line is a hack to add a name tag to the container
SET DOCKER_USER=--name skywater_dev local
.\start_x_temp.bat
:: Undouing the hack to avoid side effects
SET DOCKER_USER=local

rm .\start_x_temp.bat
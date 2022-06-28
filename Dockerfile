FROM hpretl/iic-osic-tools:latest

# Going back to root mode
USER root


# Add modifications and customizations go here:
 
RUN sed -i '/BindKeys/s/^#//g' $PDK_ROOT/sky130A/libs.tech/magic/sky130A.magicrc && \
    python3 -m pip install --upgrade pip && \
    python3 -m pip install --upgrade Pillow && \
    python3 -m pip install --upgrade phidl



# Setting up the user interface and moving to user mode
WORKDIR $DESIGNS

USER 1000

ENTRYPOINT ["/dockerstartup/scripts/ui_startup.sh"]

CMD ["--wait"]
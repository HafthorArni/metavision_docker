# OpenEB Docker Setup

User needs to be in docker group

## Build

```bash
docker build -f Dockerfile.OpenEB -t openeb:ubuntu-22.04 .
```
## Run

This runs the recording program

```bash
docker run --privileged -v /dev/bus/usb:/dev/bus/usb --rm --net=host openeb:ubuntu-22.04  
```

## Service

To run automatically on startup of machine place service file in `/etc/systemd/system/`

```bash
sudo systemctl enable openeb-docker.service
sudo systemctl start openeb-docker.service

# see status
sudo systemctl status openeb-docker.service

# see if run on startup
sudo reboot
```

#RAGNHEIÐUR NOTES
#Dockerinn á að starta upon boot og restarta automatically alltaf þegar hann failar eða er búinn

#Nota þetta til að tékka hvort hann sé active
sudo docker ps -a

#Nota þetta til að runna og geyma dockerinn án þess að opna bash ef hann er ekki nú þegar running
sudo docker run --privileged --restart=always -v /dev/bus/usb:/dev/bus/usb -v /dev/sda:/dev/sda -e DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ --name evk4 --net=host openeb:ubuntu-22.04

#Nota þetta ef þú vilt opna bash inní dockernum þegar hann er running(ath virkar ekki ef hann er að restarta)
sudo docker exec -it evk4

#Nota þetta til að sjá af hverju dockerinn er alltaf að restarta
sudo docker logs -f evk4

#Þetta er það sem lætur dockerinn pulla og starta py scriptunni(úr DockerFile.OpenEB)
# Add a custom startup script
COPY startup.sh /opt/underwater_evk_recording/startup.sh
RUN chmod +x /opt/underwater_evk_recording/startup.sh

# Start the custom startup script
CMD ["/opt/underwater_evk_recording/startup.sh"]

#Ef þið breytið startup.sh (inní metavision_docker foldernum) þá þurfiði að builda aftur

#Ég er nokkuð viss um að þetta er bara eitthvað vesen með að beina python filenum á réttann stað

#06.08.2024 RGG
#Ég komst aðeins áfram með því að breyta þessum línum inní Dockerfilenum:

Frá:
# Update environment variables
RUN echo 'export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH' >> /etc/bash.bashrc \
    && echo 'export HDF5_PLUGIN_PATH=/usr/local/hdf5/lib/plugin:$HDF5_PLUGIN_PATH' >> /etc/bash.bashrc \
    && echo 'export PYTHONPATH=/usr/local/local/lib/python3.10/dist-packages:/openeb/sdk/modules/core/python/pypkg:$PYTHONPATH' >> /etc/bash.bashrc
# Source the updated environment variables
RUN /bin/bash -c "source /etc/bash.bashrc"

Yfir í:
# Set environment variables
ENV LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
ENV HDF5_PLUGIN_PATH=/usr/local/hdf5/lib/plugin:$HDF5_PLUGIN_PATH
ENV PYTHONPATH=/usr/local/lib/python3.10/dist-packages:/openeb/sdk/modules/core/python/pypkg:$PYTHONPATH

#En ég fæ alltaf núna nýjan error, hann fer samt eitthvað lengra en áður:
Traceback (most recent call last):
  File "/opt/underwater_evk_recording/recordFromEVK4.py", line 7, in <module>
    from metavision_core.event_io.raw_reader import initiate_device
  File "/openeb/sdk/modules/core/python/pypkg/metavision_core/event_io/__init__.py", line 12, in <module>
    from .raw_reader import RawReader
  File "/openeb/sdk/modules/core/python/pypkg/metavision_core/event_io/raw_reader.py", line 22, in <module>
    from metavision_hal import DeviceDiscovery, RawFileConfig
ModuleNotFoundError: No module named 'metavision_hal'
#Mig grunar að það þurfi að laga þessa línu eitthvað meira:
ENV PYTHONPATH=/usr/local/lib/python3.10/dist-packages:/openeb/sdk/modules/core/python/pypkg:$PYTHONPATH
#Kannski virkar þessi, er ekki búin að prufa:
ENV PYTHONPATH=/usr/local/lib/python3.10/dist-packages:/openeb/sdk/modules/core/python/pypkg:$PYTHONPATH




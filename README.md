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

# OpenEB Docker Setup

User needs to be in docker group

## Build

```bash
docker build -f Dockerfile.OpenEB -t openeb:ubuntu-22.04 .
```
## Run

This runs the recording program

```bash
docker run --privileged -v /dev/bus/usb:/dev/bus/usb -v /dev/shm:/dev/shm -v /home/opti:/home/opti --shm-size=6g --rm --net=host openeb:ubuntu-22.04
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

# Convert raw to avi

```bash
docker build -f Dockerfile.convert_raw_to_avi -t openeb:ubuntu-22.04 .
```

Given your .raw files are in your local directory
```bash
docker run --privileged -v .:/mnt/sandisk/recordings --rm --net=host openeb:ubuntu-22.04
```

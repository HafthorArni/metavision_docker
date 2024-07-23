# OpenEB Docker Setup

## Build

```bash
sudo docker build --build-arg UBUNTU_VERSION=22.04 -f Dockerfile.OpenEB -t openeb:ubuntu-22.04 .
```
## Run

```bash
sudo docker run -ti --privileged -v /dev/bus/usb:/dev/bus/usb -e DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix/ --rm --net=host openeb:ubuntu-22.04 /bin/bash
```

## inside container run

```bash
python3 recordFromEVK4.py -b custom_biases/unnar_settings.bias
```

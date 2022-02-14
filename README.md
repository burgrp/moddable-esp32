# moddable-esp32
Docker image for Moddable SDK for ESP32

```
podman build . -t burgrp/moddable-sdk
podman run -it --rm --name=moddable-sdk -v /home:/home -v /dev:/dev -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e USER --network=host --userns=host burgrp/moddable-sdk start <where-to-place-executables>
```
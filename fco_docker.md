# Open container 

on say port http://localhost:2222.
You can change USER and PASSWORD.

```
docker run --rm -v $(pwd):/home/rstudio/fco/ -p 2222:8787 -e USER=guest -e PASSWORD=secret chumbleycode/fco_docker:latest
```


# How the image was built

Build from within the project directory, and tag image with the name "chumbleycode/fco_docker"

```
docker build -t chumbleycode/fco_docker .
```

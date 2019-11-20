# 0. Install docker (if you don't yet have it)

Open an account at https://hub.docker.com/. Then follow installation instructions.

# 1. Get docker image 

```
docker push chumbleycode/fco:latest
```

For more information see: https://hub.docker.com/repository/docker/chumbleycode/fco

# 2. Open container 


You can change USER and PASSWORD.

```
docker run --rm -v $(pwd):/home/rstudio/fco/ -p 2222:8787 -e USER=guest -e PASSWORD=secret chumbleycode/fco:latest
```

# 3. On your browser, go to http://localhost:2222.

USER=guest
PASSWORD=secret

# 4. Run analysis

A simple example script is in fco/R/example_analysis.R


# To reproduce the image...

Build from within the project directory, and tag image with the name "chumbleycode/fco_docker"

```
docker build -t chumbleycode/fco .
```

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

# 3a. To use rstudio in your browser

Go to http://localhost:2222.

USER=guest
PASSWORD=secret

# 3b. Alternatively, to use R in the terminal

```
docker run --rm -it -v $(pwd):/home/rstudio/fco/ chumbleycode/fco:latest R
````

# 4. Play with the example analysis script

A simple example script is in fco/R/example_analysis.R


# To reproduce the image...

Build from within the project directory, and tag image with the name "chumbleycode/fco_docker"

```
docker build -t chumbleycode/fco .
```

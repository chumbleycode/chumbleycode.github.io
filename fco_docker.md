---
layout: frontpage
title: Justin Chumbley
description: Statistician
keywords: functional imaging and genomics
---

# Justin Chumbley Ph.D

[[bio](index.md)]
[[projects](more_figures.md)]
[[cv](http://chumbleycode.github.io/chumbleycode.github.io/docs/cv.pdf)]
[[publications](https://scholar.google.com/citations?hl=en&user=YbbXlwIAAAAJ)]
[[github](https://github.com/chumbleycode/)] 
[[linkedin](https://www.linkedin.com/in/chumbleycode)] 

<table class="fixed">
    <col width="200px" />
    <col width="350px" /> 
    <tr>
        <td><img src="images/JRCsquare.jpg" alt="drawing" width="200">  </td>
        <td> I am an applied statistician with a broad background in behavioral and biological sciences: <br/><br/>
            &#8594; Check out my CV <a href="http://chumbleycode.github.io/chumbleycode.github.io/docs/cv.pdf"> here</a>. <br/><br/>
             I develop experiments and the statistical tools to analyze them. I help my collaborators clarify, simplify and solve challenging interdisciplinary problems: <br/><br/>
            &#8594; Learn more about my current projects <a href="index.html"> back.</a>
            </td>
    </tr>
</table>

# 0. Install docker (if you don't yet have it)

Open an account at [docker hub](https://hub.docker.com/). Then follow installation instructions.

# 1. Get docker image 

```
docker pull chumbleycode/fco:latest
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

## Build the docker container
- Download cplex_studio128.linux-x86-64.bin from IBM website.
`docker build -t cplex .`

## Start the container
`docker run -it --rm -p 8888:8888 cplex`
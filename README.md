# ERAN on Docker

Launch Gurobi token server with the floating license on host machine.

From Docker hub.
```
$ docker run -it --rm --net="host" rnbguy/eran
```

From Github.
```
$ git clone git@github.com:rnbguy/eran-docker
$ docker build -t eran-local .
...
$ docker run -it --rm --net="host" eran-local
```

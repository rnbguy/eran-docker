# ERAN on Docker

Launch Gurobi token server with the floating license on host machine.

```
$ docker build -t eran .
...
$ docker run -it --rm --net="host" eran bash
[root] $ bash gen_lic.sh
...
[root] $ # ready. to verify:
[root] $ gurobi_cl --tokens
```
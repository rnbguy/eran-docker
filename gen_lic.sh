#!/bin/bash

mkdir -p /opt/gurobi
echo TOKENSERVER=$(ip addr show docker0 | grep 'inet ' | cut -d' ' -f 6 | cut -d'/' -f1) > /opt/gurobi/gurobi.lic
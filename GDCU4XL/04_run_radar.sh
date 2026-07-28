#!/bin/bash

cd ./integration-carkit88c0-gmsl/src/demo_app/boards/carkit_88c0/example
make clean
make
sudo ./bin/carkit88c0_gmsl_example  

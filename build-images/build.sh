#!/bin/bash

DIST=${1:-buster}

docker build -f Dockerfile.${DIST} -t mysocietyorg/${DIST}-builder:latest .

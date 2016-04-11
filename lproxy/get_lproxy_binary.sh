#!/bin/bash
#########################################################################
# File Name:    create_lproxy_container.sh
# Author:       D_L
# mail:         deel@d-l.top
# Created Time: 2016/4/9 9:20:10
#########################################################################

# get bin's so's

set -x
set -e

LPROXY_DEV_IMAGE=daocloud.io/deel/lproxy-dev:docker-dev-5cadd70

sudo docker run -d --name lproxy_dev_temp -i $LPROXY_DEV_IMAGE
sudo docker exec -i lproxy_dev_temp make init
sudo docker exec -i lproxy_dev_temp make lss GDB= CXXFLAGS=-O2
sudo docker exec -i lproxy_dev_temp make install
sudo docker exec -i lproxy_dev_temp tar cvf bin.tar bin/

sudo docker cp lproxy_dev_temp:/opt/lproxy/bin.tar ./bin.tar

mkdir -p ./lib64 ./usr/lib/x86_64-linux-gnu/ ./lib/x86_64-linux-gnu/

sudo docker cp lproxy_dev_temp:/lib/x86_64-linux-gnu/libpthread-2.19.so      ./lib/x86_64-linux-gnu/libpthread.so.0
sudo docker cp lproxy_dev_temp:/lib/x86_64-linux-gnu/librt-2.19.so           ./lib/x86_64-linux-gnu/librt.so.1
sudo docker cp lproxy_dev_temp:/usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.21 ./usr/lib/x86_64-linux-gnu/libstdc++.so.6
sudo docker cp lproxy_dev_temp:/lib/x86_64-linux-gnu/libm-2.19.so            ./lib/x86_64-linux-gnu/libm.so.6
sudo docker cp lproxy_dev_temp:/lib/x86_64-linux-gnu/libgcc_s.so.1           ./lib/x86_64-linux-gnu/libgcc_s.so.1
sudo docker cp lproxy_dev_temp:/lib/x86_64-linux-gnu/libc-2.19.so            ./lib/x86_64-linux-gnu/libc.so.6
sudo docker cp lproxy_dev_temp:/lib/x86_64-linux-gnu/ld-2.19.so              ./lib64/ld-linux-x86-64.so.2

sudo docker stop lproxy_dev_temp
sudo docker rm -f lproxy_dev_temp

set +x

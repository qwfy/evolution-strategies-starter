#!/usr/bin/env bash

exit 1

set -x
set -e

# docker build -t openai-es -f Dockerfile.bionic git://github.com/lambdal/lambda-stack-dockerfiles.git

# run the following in the above container

# Mujoco
mkdir /opt/mujoco
cp mujoco/mjkey.txt /opt/mujoco/
cp -r mujoco/mjpro150 /opt/mujoco/
echo 'export MUJOCO_PY_MJKEY_PATH=/opt/mujoco/mjkey.txt' >> ~/.bashrc
echo 'export MUJOCO_PY_MJPRO_PATH=/opt/mujoco/mjpro150' >> ~/.bashrc
echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/mujoco/mjpro150/bin' >> ~/.bashrc
export MUJOCO_PY_MJKEY_PATH=/opt/mujoco/mjkey.txt
export MUJOCO_PY_MJPRO_PATH=/opt/mujoco/mjpro150
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/mujoco/mjpro150/bin

apt-get update

# Locales setup
apt-get install -y locales
locale-gen en_US.UTF-8
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# Basic tools
apt-get install -y python3-dev patchelf build-essential cmake git wget htop tmux vim procps

# Project dependencies
apt-get install -y libosmesa6-dev libgl1-mesa-glx libglfw3
ln -s /usr/lib/x86_64-linux-gnu/libGL.so.1 /usr/lib/x86_64-linux-gnu/libGL.so
pip3 install pyopengl cython cffi lockfile PyYAML redis click
pip3 install 'gym[classic_control,mujoco]'

set +x
set +e
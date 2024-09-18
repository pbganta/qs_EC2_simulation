#!/bin/bash
sudo apt-get update -qq

sudo apt-get install -y -qq --no-install-recommends g++ gcc gfortran openssh-client openssh-server python3-pip bzip2 ca-certificates git unzip wget python3 python3-venv

sudo apt-get upgrade

sudo mkdir /home/ubuntu/.local/

sudo python3 -m venv /home/ubuntu/.local/.venv/

sudo /home/ubuntu/.local/.venv/bin/pip3 install ase mdanalysis scikit-learn numpy nglview

echo "export PATH=$PATH:/home/ubuntu/.local/.venv/bin/" >> ~/.bashrc

echo "alias python3='/home/ubuntu/.local/.venv/bin/python3'" >> ~/.bash_aliases

source ~/.local/.venv/bin/activate

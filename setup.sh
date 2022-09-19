#!/bin/bash

# Install system dependencies
sudo apt update
sudo apt install git unzip python3-venv

#Install nvim
sudo snap install nvim --edge --classic

# Install the config
 git clone git@github.com:cpp-playground/nvim_config.git ~/.config/nvim
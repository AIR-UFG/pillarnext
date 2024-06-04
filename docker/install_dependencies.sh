#!/bin/bash

# Install specific versions of torch and torchvision with CUDA 11.6 support
pip install torch==1.13.1+cu116 torchvision==0.14.1+cu116 --extra-index-url https://download.pytorch.org/whl/cu116

# Install torch-scatter with support for torch 1.13.0 and CUDA 11.6
pip install torch-scatter -f https://data.pyg.org/whl/torch-1.13.0+cu116.html

# Install additional packages
#pip install hydra-core numba spconv-cu116 opencv-python nuscenes-devkit protobuf==3.20.*

# Install a specific version of TensorFlow without using cache
#pip install --no-cache-dir tensorflow==2.6.0

# Install the Waymo Open Dataset for TensorFlow 2.6.0
#pip install waymo-open-dataset-tf-2-6-0

# Install PillarNeXt in editable mode
pip install -e .
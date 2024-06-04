#!/usr/bin/env bash

##### Credits to: https://github.com/osrf/icra2023_ros2_gz_tutorial/blob/main/docker/run.bash

#
# Copyright (C) 2023 Open Source Robotics Foundation
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#

if [ $# -lt 1 ]
then
    echo "Usage: $0 <docker image> [--rm] [--nvidia] [--shm-size SIZE]"
    exit 1
fi

# Default to no NVIDIA and default shared memory size
DOCKER_OPTS=""
SHM_SIZE=""

# Parse and remove args
PARAMS=""
REMOVE_CONTAINER=""
while (( "$#" )); do
  case "$1" in
    --rm)
      REMOVE_CONTAINER="--rm"
      shift
      ;;
    --nvidia)
      if [[ -x "$(command -v dpkg)" ]] && dpkg --compare-versions "$(docker version --format '{{.Server.Version}}')" gt "19.3"; then
        DOCKER_OPTS="--gpus=all"
      else
        DOCKER_OPTS="--runtime=nvidia"
      fi
      shift
      ;;
    --shm-size)
      SHM_SIZE="--shm-size $2"
      shift 2
      ;;
    -*|--*=) # unsupported flags
      echo "Error: Unsupported flag $1" >&2
      exit 1
      ;;
    *) # preserve positional arguments
      PARAMS="$PARAMS $1"
      shift
      ;;
  esac
done
# set positional arguments in their proper place
eval set -- "$PARAMS"

IMG="$1"

CURRENT_DIR="$(pwd)"
SHARED_DIR="${CURRENT_DIR}/shared-folder"

if [ ! -d "${SHARED_DIR}" ]; then
    mkdir "${SHARED_DIR}"
fi

echo "Running docker image: $IMG" with shared folder: $SHARED_DIR and options: $DOCKER_OPTS $SHM_SIZE

docker run -it \
  $REMOVE_CONTAINER \
  -v $SHARED_DIR:/root/shared-folder \
  $DOCKER_OPTS \
  $SHM_SIZE \
  $IMG
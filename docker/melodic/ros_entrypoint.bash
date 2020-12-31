#!/bin/bash
set -e
source "/opt/ros/melodic/setup.bash"
source "/preinstall/devel/setup.bash"
exec "$@"

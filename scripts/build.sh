#!/bin/bash

#!/bin/bash

BUILD_PATH="_site"

if [ -d ".git" ]; then
  rm -rf build
  rsync -av --progress . build --exclude build --exclude '.git' --exclude '.project' --exclude '.settings' --exclude '.buildpath' --exclude scripts --exclude conf --exclude releases
else
  echo "You must be in the root git folder to execute the build script."
fi
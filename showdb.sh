#!/bin/bash
dir="$(pwd)/Databases"
if [ -d "$dir" ] && [ "$(ls -A $dir)" ]; then
   echo "Databases Available : "
   ls $dir
else
   echo "There is no available databases to show"
fi

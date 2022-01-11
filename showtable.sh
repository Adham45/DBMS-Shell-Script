#!/bin/bash
dir="$(pwd)/Databases/$currdb/data"
if [ -d "$dir" ] && [ "$(ls -A $dir)" ]; then
   echo "Tables Available"
   ls $dir
else
   echo "There is no availabale tables"
fi

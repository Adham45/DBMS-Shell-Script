#!/bin/bash

echo "Enter Table Name"
read table
if [ -f "Databases/$currdb/data/$table" ] && [ -f "Databases/$currdb/metaData/$table.metadata" ]; then
   rm -r Databases/$currdb/data/$table
   rm -r Databases/$currdb/metaData/$table.metadata
   echo "$table has been deleted successfully"
else
   echo "There is no such table with that name"
fi

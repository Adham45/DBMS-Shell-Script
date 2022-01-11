#!/bin/bash

echo "Enter Database Name"
read db
if [ -d "Databases/$db" ]; then
   rm -r Databases/$db
   echo "$db has been deleted successfully"
else
   echo "There is no database with such name to delete"
fi

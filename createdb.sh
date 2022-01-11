#!/bin/bash
echo "Enter The Name Of Database: "
read db;
if mkdir Databases/$db 2>> errors; then
   mkdir Databases/$db/data;
   mkdir Databases/$db/metaData;
   echo "$db created successfully."
else
   echo "$db can not be created. Go to errors for more details";
fi

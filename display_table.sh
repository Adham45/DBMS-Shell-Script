#!/bin/bash

echo "Enter Table Name: "
read tableName
if [ -f "Databases/$currdb/data/$tableName" ] && [ -f "Databases/$currdb/metaData/$tableName.metadata" ]; then

    awk -F: 'BEGIN { ORS=":" }; { echo $1 }' Databases/$currdb/metaData/$tableName.metadata
    printf "\n"
    cat Databases/$currdb/data/$tableName
else
    echo "There is no such table with that name"
fi

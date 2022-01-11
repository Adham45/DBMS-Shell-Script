#!/bin/bash

read -p "Enter Column Name :" colName;

colNames=($(awk -F: '{print $1}' Databases/$currdb/metaData/$tableName.metadata))
colFlag=1;

for i in "${!colNames[@]}"
do
    if [[ $colName == "${colNames[$i]}" ]]; then
           colFlag=0;
           colNum=$(($i+1));
    fi
done

if [[ $colFlag == 0 ]]; then


    cut -d':' --complement -f$colNum Databases/$currdb/data/$tableName > Databases/$currdb/data/$tableName.tmp
    mv Databases/$currdb/data/$tableName.tmp Databases/$currdb/data/$tableName


    sed -i "$colNum"d Databases/$currdb/metaData/$tableName.metadata
else
    echo "ERROR: Not Valid Column Name";
fi

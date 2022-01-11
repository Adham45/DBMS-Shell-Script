#!/bin/bash

echo "db:$currdb, table:$tableName"

read -p "Enter Column Name: " colName;


colNames=($(awk -F: '{print $1}' Databases/$currdb/metaData/$tableName.metadata))

colFLag=1

for i in "${!colNames[@]}"
do
    if [[ $colName == "${colNames[$i]}" ]]; then
        colFlag=0
        colNum=$(($i+1));
    fi
done

if [[ $colFlag == 0 ]]; then

   read -p "Enter Value to delete record: " value;


   echo "colNum = $colNum"
   recordNum=($(awk -v varCol="$colNum" -v varValue="$value" -F: '{if ($varCol == varValue) {print FNR}}' "Databases/$currdb/data/$tableName"))

   counter = 0

   for i in "${!recordNum[@]}"
   do
       index=${recordNum[$i]}
       index=$(($index-$counter))
       echo "index:$index"
       sed -i "$index"d Databases/$currdb/data/$tableName

       counter=$(($counter+1))
   done
   echo $recordNum
else
   echo "Not Valid Coulmn Name";
fi

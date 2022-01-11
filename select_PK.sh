#!/bin/bash

echo "Enter Table Name :";
read TableName;

if [ -f "Databases/$currdb/data/$TableName" ] && [ -f "Databases/$currdb/metaData/$TableName.metadata" ]; then

echo "Enter PK Column Name :"
read ColumnPK
if grep -q $ColumnPK "Databases/$currdb/metaData/$TableName.metadata"
then
Res=$(grep $ColumnPK "Databases/$currdb/metaData/$TableName.metadata" | awk -F: '{ if($3 == "yes") {print "1"} else {print "0"}}')
ColumnNumMetaData=$(grep -n $ColumnPK "Databases/$currdb/metaData/$TableName.metadata" | awk -F: '{print $1}' )

if [ $Res == "1" ];
then
echo "Enter PK Value"
read Vpk

grep $Vpk Databases/$currdb/data/$TableName >> adham.temp
ColumnNumData=$(awk -v rk="$Vpk" -F: '{ for (i=0; i<=NF; i++){if ($i==rk){print i}}}' $(pwd)/adham.temp) 
rm -f adham.temp

if [ $ColumnNumMetaData == $ColumnNumData ];
then
varOne=$(grep -ow $Vpk Databases/$currdb/data/$TableName)
grep -w $Vpk Databases/$currdb/data/$TableName | awk -F: '{print $0}'
else
echo "No such value in PK Column"
fi

else
echo "Not PK"
fi


else
echo "$ColumnPK does not exist"
fi


else
echo "No Such Table"
fi


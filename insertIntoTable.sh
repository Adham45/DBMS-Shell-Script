#!/bin/bash

function validateTableName(){
    legal=0
    IFS=' ' read -r -a array <<< $1;
    if (( ${#array[@]} > 1 )); then 
        echo "ERROR: Table Name can not containt whitespaces" >> errors;
        legal=1;
    fi

    if (( ${#array[@]} == 0 )); then 
        echo "ERROR: Table Name can not be empty" >> errors;
        legal=1;
    fi

    echo $legal;
}

function tableExists(){
    tableName=$1;
    legal=0  

    if [[ -f Databases/$currdb/data/$tableName ]]; then
        echo "Table exists" >> errors;
    else
        echo "$tableName no such table." >> errors;
        legal=1;    
    fi

    echo $legal;
}

function insertRow()
{
IFS=$'\n' read -d '' -r -a lines < "Databases/$currdb/metaData/$tableName.metadata"

newRecord="";
errFlag=0;

for k in "${!lines[@]}"
do
    IFS=':' read -r -a column <<< "${lines[k]}";
    colName=${column[0]};
    colDataType=${column[1]};
    colPK=${column[2]};


    dataTypeFlag=0;
    pkFlag=0;


    read -p "Enter $colName: " newColValue;
    numRegex='^[0-9]+$'


    if [[ $colDataType == "number" ]]; then
        if [[ $newColValue =~ numRegex ]]; then
          dataTypeFlag=1;
          errFlag=1;
          echo "ERROR: Value must be a number";
        fi
    fi

    if [[ $colPK == "yes" ]]; then
        IFS=$'\n' read -d '' -r -a dataLines < "Databases/$currdb/data/$tableName"

        for j in "${!dataLines[@]}";
        do
            IFS=':' read -r -a record <<< "${dataLines[$j]}";
            if [[ ${record[k]} == $newColValue ]]; then
                pkFlag=1;
                errFlag=1;
                echo "ERROR: Primary key must be unique";
            fi
        done
     fi


     if [[ dataTypeFlag==0 && pkFlag==0 ]]; then
         if [[ $k == 0 ]]; then
             newRecord=$newColValue;
         else
             newRecord="$newRecord:$newColValue";
         fi
     else
         echo "Not Valid Record";
     fi
done

if ! [[ $newRecord == "" ]]; then
    if [[ $errFlag == 0 ]]; then
        if echo $newRecord >> "Databases/$currdb/data/$tableName"; then
            echo "Record stored succesfully";
        else
            echo "ERROR: Can not store Record";
        fi
    else
        echo "ERROR: Can not store Record";
    fi
else
    echo "ERROR: Can not store an empty Record";
fi
}

read -p "Enter Table Name : " tableName;

tableNameFlag=$(validateTableName "$tableName");
tableExistsFlag=$(tableExists "$tableName");


if [ $tableNameFlag == 0 ] && [ $tableExistsFlag == 0 ]; then
    insertRow
else
    echo "Not Valid Table Name. Go to errors for details";
fi

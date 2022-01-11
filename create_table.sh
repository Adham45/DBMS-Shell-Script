#!/bin/bash

function validateTableName()
{
 legal=0
 IFS=' ' read -r -a array <<< $1;
 if (( ${#array[@]} > 1 )); then
     echo "ERROR: Table Name can not containt whitespaces" >> errors;
     legal=1;
 fi
 
 if [[ "$1" =~ [A-Za-z] ]]; then
     echo "Correct table name" >> errors;
 else
     echo "ERROR: Table name must contain at least one character" >> errors;
     legal=1
 fi
 
 if (( ${#array[@]} == 0 )); then
    echo "ERROR: Table Name can not be empty" >> errors;
    legal=1;
 fi

 first="${array[0]:0:1}"
 if [[ $first =~ [0-9] ]]; then
    echo "ERROR: Table Name can not begin with number" >> errors;
    legal=1;
 fi


 echo $legal;

}

function tableExists()
{
currdb=$1;
tableName=$2;

legal=0

 if [[ -f Databases/$currdb/data/$tableName ]]; then
     echo "ERROR: Table exists before" >> errors;
     legal=1;
 fi

 echo $legal;

}

function validateColumnName()
{
 legal=0
 IFS=' ' read -r -a array <<< $1;
 if (( ${#array[@]} > 1 )); then
     echo "ERROR: Column Name can not containt whitespaces" >> errors;
     legal=1;
 fi
 
 if [[ "$1" =~ [A-Za-z] ]]; then
     echo "Correct table name" >> errors;
 else
     echo "ERROR: Column name must contain at least one character" >> errors;
     legal=1
 fi
 
 if (( ${#array[@]} == 0 )); then
    echo "ERROR: Column Name can not be empty" >> errors;
    legal=1;
 fi

 first="${array[0]:0:1}"
 if [[ $first =~ [0-9] ]]; then
    echo "ERROR: Column Name can not begin with number" >> errors;
    legal=1;
 fi


 echo $legal;
}

function createColumns()
{
 read -p "Enter Number of columns : " colsNum;

 for (( k=0; k<$colsNum; k++ ))
 do
     colMetaData="";
     read -p "Enter Column Name : " colName;
     colNameFlag=$(validateColumnName "$colName");
     if [[ $colNameFlag == 0 ]]; then
         colMetaData="$colName";
         read -p "Please choose the column data type String(s) Number(n): (s/n)" colDataType;
         if [[ $colDataType == "s" || $colDataType == "S" ]]; then
            colMetaData="$colMetaData:string";
         elif [[ $colMetaData == "n" || $colMetaData == "N" ]]; then
            colMetaData="$colMetaData:number";
         fi

         read -p "Is That column a primary key ? (PK): (y/n)" pk;
         if [[ $pk == "y" || $pk == "Y" ]]; then
            colMetaData="$colMetaData:yes";
         elif [[ $pk == "n" || $pk == "N" ]]; then
            colMetaData="$colMetaData:no";
         fi


         echo $colMetaData >> "Databases/$currdb/metaData/$tableName.metadata";
     else
         echo "Not Valid Column Name";
     fi
 done
}

read -p "Enter Table Name : " tableName;

tableNameFlag=$(validateTableName "$tableName");
tableExistsFlag=$(tableExists "$currdb" "$tableName");

if [ $tableNameFlag == 0 ] && [ $tableExistsFlag == 0 ]; then
    if touch "Databases/$currdb/data/$tableName" 2> errors; then
        echo "Empty table created sucessfully" >> errors;

        if touch "Databases/$currdb/metaData/$tableName.metadata" 2> errors; then
            echo "Metadata file has been created sucessfully" >> errors;
        else
            echo "ERROR: Can not create metadata file. Go to errors for details ";
        fi

        if createColumns; then
            echo "Table $tableName has been created sucessfully";
            cat "Databases/$currdb/metaData/$tableName.metadata";
        else
            echo "ERROR: Can not create $tableName"
        fi
    else
        echo "ERROR: Can not create table. Go to errors for details";
    fi

else
    echo "ERROR: Can not create table. Go to errors for details";
fi 

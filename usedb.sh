#!/bin/bash

usedb_menu(){
   options=("Show Tables" "Create New Table" "Insert into Table" "Delete Table" "Update Table" "Use Table" "Back to main menu");
   while [[ "$option" != "Back to main menu" ]]
    do
    select option in "${options[@]}"
    do
       case $option in
               "Show Tables") . ./showtable.sh;break ;;
               "Create New Table") . ./create_table.sh;break ;;
               "Insert into Table") . ./insertIntoTable.sh;break ;;
               "Delete Table") . ./deletetable.sh;break ;;
               "Update Table") . ./updatetable.sh;break ;;
               "Use Table") . ./usetable.sh;break ;;
               "Back to main menu") . ./mainmenu.sh; exit $? ;;
               *) echo "Not Valid option $REPLY";;
        esac
     done
     done
}

echo "Enter Database Name :"
read currdb;

if [[ -d Databases/$currdb ]]
then
    export currdb=$currdb;
    echo "$currdb is selected.";
    usedb_menu;
else
    echo "The selected database does not exist.";
    . ./mainmenu.sh
fi

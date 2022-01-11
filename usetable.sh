#!/bin/bash

Use_Table(){
options=("displayTable" "Select By PK" "Back To main menu");
while [[ "$option" != "Back To main menu" ]]
do
select option in "${options[@]}" 
do 
       case $option in 
       "displayTable") . ./display_table.sh; break ;;
       "Select By PK") . ./select_PK.sh; break;;
       "Back To main menu") . ./mainmenu.sh; exit $? ;;
        *) echo "Invalid option $REPLY";;

         esac
    done
    done
}

Use_Table;

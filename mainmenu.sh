#!/bin/bash

options=("Show Databases" "Create New Database" "Use Database" "Delete Database" "Quit")
while [[ "$option" != "Quit" ]]
do
      select option in "${options[@]}"
      do 
           case $option in
                  "Show Databases") . ./showdb.sh; break ;;
                  "Create New Database") . ./createdb.sh; break ;;
                  "Use Database") . ./usedb.sh; break;;
                  "Delete Database") . ./deletedb.sh; break;;
                  "Quit") break; exit $?;;
                  *) echo "Not Valid option $REPLY";;
           esac
      done
done

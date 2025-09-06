#!/bin/bash
bool=1
count=0
while [ $bool -eq 1 ]; do
    count=$((count + 1))
    echo "combien font 1 + 1"
    read oui
    if [ $oui = 2 ]; then
        bool=0
    fi
done 

if [ $count -le 5 ]; then
    echo "tu as reussi en $count essaie gg"
else 
    echo "tu pus la merde en $count essaie srx"
fi





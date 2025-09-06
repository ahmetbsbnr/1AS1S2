#!/bin/bash

if [ $# -eq 1 ];then
    if [ -d $1 ];then
        repsav=$1sav$(date +%y%m%d)
        if [ -d $repsav ];then
            echo "tu fais chier il existe deja"
        else 
            mkdir $repsav
        fi
        echo "sauvegarde du $(date +%y%m%d) du repertoire $1>>liste"
        for fichier in $(ls $1);do
            cp $1/$fichier $repsav
            echo "fichier $fichier copié correctement tmtc">>liste
        done
    else 
        echo "le parametre n'est pas un dossier"
    fi
else 
    echo "vous devez donner un parametre"
fi  
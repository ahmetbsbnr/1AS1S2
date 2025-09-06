#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Erreur : Aucun argument fourni. Veuillez spécifier un fichier."
    exit 1
fi

if [ -f "$1" ]; then
    echo "Le fichier $1 existe."
else
    echo "Le fichier $1 n'existe pas."
fi


#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Erreur : Il manque 2 valeurs."
    exit 1
fi

repertoire="$1"
fichier="$2"

if [ ! -d "$repertoire" ]; then
    echo "Erreur : Le répertoire n'existe pas."
    exit 1
fi

local="$repertoire/$fichier"
if [ ! -f "$local" ]; then
    echo "Erreur : Le fichier n'existe pas dans le répertoire."
    exit 1
fi
    
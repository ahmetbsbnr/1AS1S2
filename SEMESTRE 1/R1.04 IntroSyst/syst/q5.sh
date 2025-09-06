#!/bin/bash

if [ "$#" -ne 5 ]; then
    echo "Erreur : Le nombre de paramètres est incorrect. Vous devez fournir exactement 5 paramètres."
    exit 1
fi

Som=0

for i in "$@"; do
    Som=$((Som + i))
done

echo "La somme des 5 paramètres est : $Som"

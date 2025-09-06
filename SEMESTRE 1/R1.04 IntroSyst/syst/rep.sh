#!/bin/bash

# Récupérer la date au format JJ-MM-AAAA
repertoire="TP-$(date '+%d-%m-%Y')"

# Vérifier et créer le répertoire
if [ ! -d "$repertoire" ]; then
    mkdir "$repertoire"
    echo "Répertoire $repertoire créé."
else
    echo "Le répertoire $repertoire existe déjà."
fi


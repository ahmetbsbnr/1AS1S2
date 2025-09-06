#!/bin/bash

# Vérifier et créer le répertoire
if [ ! -d "TP2" ]; then
    mkdir TP2
    echo "Le répertoire TP2 a été créé."
else
    echo "Le répertoire TP2 existe déjà."
fi

# Vérifier et créer le fichier
if [ ! -f "TP2/Rapport_TP2.txt" ]; then
    touch TP2/Rapport_TP2.txt
    echo "Le fichier Rapport_TP2.txt a été créé."
else
    echo "Le fichier Rapport_TP2.txt existe déjà."
fi


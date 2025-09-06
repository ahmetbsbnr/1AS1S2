#!/bin/bash
if [ ! -d "TP2" ]; then
    mkdir TP2
    echo "Le répertoire TP2 a été créé."
else
    echo "Le répertoire TP2 existe déjà."
fi
if [ ! -f "TP2/Rapport_TP2.txt" ];then
    touch TP2/Rapport_TP2.txt
    echo "c'est good"
else
    echo "il existe deja"
fi

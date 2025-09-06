#!/bin/bash

# Vérification des paramètres
if [ "$#" -lt 3 ]; then
    echo "L'usage correcte: $0 <utilisateur> <jour semaine> <jour> <mois> <année>"
    echo "Un exemple = $0 e26350u mercredi 01 janvier 2025"
    exit 1
fi

# Paramètres
USERNAME=$1
DAY_OF_WEEK=$2
DAY=$3
MONTH=$4
YEAR=$5
LOG_FILE="connexion.log"

# Construction de la date pour correspondre au format des logs
DATE="$DAY_OF_WEEK $DAY $MONTH $YEAR"

# Filtrage des logs
FILTERED_LOG=$(grep ";${USERNAME};" "$LOG_FILE" | grep "$DATE")

# Vérification si des logs existent
if [ -z "$FILTERED_LOG" ]; then
    echo "Aucun log trouvé pour l'utilisateur $USERNAME à la date $DATE."
    exit 1
fi

# Fonction 1 : Connexions par heure
Connexions_par_heure() {
    echo "--------------------------------------------"
    echo "Connexions par heure pour $USERNAME le $DATE :"
    echo "--------------------------------------------"
    echo "$FILTERED_LOG" | awk -F';' '{print $4}' | cut -d' ' -f5 | cut -d':' -f1 | sort | uniq -c
}

# Fonction 2 : Machines différentes utilisées
Machines_differentes() {
    echo "--------------------------------------------"
    echo "Machines utilisées par $USERNAME le $DATE :"
    echo "--------------------------------------------"
    echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq
    echo "Nombre total de machines : $(echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq | wc -l)"
}

# Fonction 3 : Adresses IP différentes
IP_differentes() {
    echo "--------------------------------------------"
    echo "Adresses IP utilisées par $USERNAME le $DATE :"
    echo "--------------------------------------------"
    echo "$FILTERED_LOG" | awk -F';' '{print $1}' | sort | uniq
    echo "Nombre total d'adresses IP : $(echo "$FILTERED_LOG" | awk -F';' '{print $1}' | sort | uniq | wc -l)"
}

# Menu interactif
while true; do
    echo "============================================"
    echo "=== Statistiques pour $USERNAME le $DATE ==="
    echo "============================================"
    echo "1. Connexions par heure"
    echo "2. Machines différentes utilisées"
    echo "3. Adresses IP différentes utilisées"
    echo "4. Quitter"
    echo "============================================"
    echo -n "Choisir une option (1-4) : "
    read CHOIX

    case $CHOIX in
        1) Connexions_par_heure ;;
        2) Machines_differentes ;;
        3) IP_differentes ;;
        4) echo "Fin du programme."; break ;;
        *) echo "Option invalide. Réessayez." ;;
    esac
done
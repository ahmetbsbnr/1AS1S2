#!/bin/bash

if [ "$#" -lt 2 ] || [ "$#" -gt 3 ]; then
    echo "Usage: $0 <utilisateur> <date (YYYY-MM-DD)> [fichier]"
    exit 1
fi


USER=$1
DATE=$2
OUTPUT_FILE=${3:-/dev/stdout}
LOG_FILE="connexion.log"

FILTERED_LOG=$(grep "$USER" "$LOG_FILE" | grep "$DATE")

connections_per_hour() {
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Connexions par heure pour $USER le $DATE :" >> "$OUTPUT_FILE"
    echo "--------------------------------------------" >> "$OUTPUT_FILE"
    echo "$FILTERED_LOG" | awk -F';' '{print $4}' | cut -d' ' -f2 | cut -d':' -f1 | sort | uniq -c >> "$OUTPUT_FILE"
}

unique_machines() {
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Machines utilisées par $USER le $DATE :" >> "$OUTPUT_FILE"
    echo "--------------------------------------------" >> "$OUTPUT_FILE"
    echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq >> "$OUTPUT_FILE"
    echo "Nombre total de machines : $(echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq | wc -l)" >> "$OUTPUT_FILE"
}

unique_ips() {
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Adresses IP utilisées par $USER le $DATE :" >> "$OUTPUT_FILE"
    echo "--------------------------------------------" >> "$OUTPUT_FILE"
    echo "$FILTERED_LOG" | awk -F';' '{print $1}' | sort | uniq >> "$OUTPUT_FILE"
    echo "Nombre total d'adresses IP : $(echo "$FILTERED_LOG" | awk -F';' '{print $1}' | sort | uniq | wc -l)" >> "$OUTPUT_FILE"
}

while true; do
    echo "============================================"
    echo "=== Statistiques pour $USER le $DATE ==="
    echo "============================================"
    echo "1. Connexions par heure"
    echo "2. Machines différentes utilisées"
    echo "3. Adresses IP différentes utilisées"
    echo "4. Quitter"
    echo "============================================"

    read -p "Choisir une option (1-4) : " choice
    case $choice in
        1) connections_per_hour ;;
        2) unique_machines ;;
        3) unique_ips ;;
        4) echo "Fin du programme."; break ;;
        *) echo "Option invalide. Réessayez." ;;
    esac
    cat "$OUTPUT_FILE"
done

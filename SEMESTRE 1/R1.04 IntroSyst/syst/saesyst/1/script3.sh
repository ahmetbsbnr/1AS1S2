#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <utilisateur> <mois (MM)> <0 (écran) | 1 (fichier)>"
    exit 1
fi

USER=$1
MONTH=$2
OUTPUT_MODE=$3
YEAR=$(date +"%Y")
LOG_FILE="connexion.log"
OUTPUT_FILE="/dev/stdout"

if [ "$OUTPUT_MODE" -eq 1 ]; then
    mkdir -p "$YEAR"
    OUTPUT_FILE="${YEAR}/${USER}_${MONTH}.log"
fi

FILTERED_LOG=$(grep "$USER" "$LOG_FILE" | grep -Ei " $(date -d "2024-$MONTH-01" '+%b|%B')")

total_connections() {
    TOTAL=$(echo "$FILTERED_LOG" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Nombre total de connexions pour $USER durant le mois $MONTH/$YEAR : $TOTAL" >> "$OUTPUT_FILE"
}

connections_per_day() {
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Connexions par jour pour $USER durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$FILTERED_LOG" | awk -F';' '{print $4}' | awk '{print $2}' | sort | uniq -c >> "$OUTPUT_FILE"
}

unique_machines() {
    MACHINES=$(echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq)
    TOTAL=$(echo "$MACHINES" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Machines utilisées durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$MACHINES" >> "$OUTPUT_FILE"
    echo "Nombre total de machines : $TOTAL" >> "$OUTPUT_FILE"
}

unique_ips() {
    IPS=$(echo "$FILTERED_LOG" | awk -F';' '{print $1}' | sort | uniq)
    TOTAL=$(echo "$IPS" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Adresses IP utilisées durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$IPS" >> "$OUTPUT_FILE"
    echo "Nombre total d'adresses IP : $TOTAL" >> "$OUTPUT_FILE"
}


while true; do
    echo "============================================"
    echo "=== Statistiques pour $USER - Mois : $MONTH/$YEAR ==="
    echo "============================================"
    echo "1. Nombre total de connexions"
    echo "2. Connexions par jour"
    echo "3. Machines différentes utilisées"
    echo "4. Adresses IP différentes utilisées"
    echo "5. Quitter"
    echo "============================================"

    read -p "Choisir une option (1-5) : " choice
    case $choice in
        1) total_connections ;;
        2) connections_per_day ;;
        3) unique_machines ;;
        4) unique_ips ;;
        5) echo "Fin du programme."; break ;;
        *) echo "Option invalide. Réessayez." ;;
    esac
    cat "$OUTPUT_FILE"
    echo "--------------------------------------------"
done

#!/bin/bash

# Vérification des paramètres
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <mois (MM)> <0 (écran) | 1 (fichier)>"
    exit 1
fi

# Paramètres
MONTH=$1
OUTPUT_MODE=$2
YEAR=$(date +"%Y")
LOG_FILE="connexion.log"
OUTPUT_FILE="/dev/stdout"

# Création du fichier de sortie si OUTPUT_MODE=1
if [ "$OUTPUT_MODE" -eq 1 ]; then
    mkdir -p "$YEAR"
    OUTPUT_FILE="${YEAR}/${MONTH}.log"
fi

# Filtrage des logs pour le mois donné
FILTERED_LOG=$(grep -Ei " $(date -d "2024-$MONTH-01" '+%b|%B')" "$LOG_FILE")

# Fonction 1 : Nombre total de connexions
total_connections() {
    TOTAL=$(echo "$FILTERED_LOG" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Nombre total de connexions durant le mois $MONTH/$YEAR : $TOTAL" >> "$OUTPUT_FILE"
}

# Fonction 2 : Nombre de connexions par utilisateur
connections_per_user() {
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Connexions par utilisateur durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$FILTERED_LOG" | awk -F';' '{print $2}' | sort | uniq -c | sort -nr >> "$OUTPUT_FILE"
}

# Fonction 3 : Connexions par jour
connections_per_day() {
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Connexions par jour durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$FILTERED_LOG" | awk -F';' '{print $4}' | awk '{print $2}' | sort | uniq -c >> "$OUTPUT_FILE"
}

# Fonction 4 : Machines différentes utilisées
unique_machines() {
    MACHINES=$(echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq)
    TOTAL=$(echo "$MACHINES" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Machines utilisées durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$MACHINES" >> "$OUTPUT_FILE"
    echo "Nombre total de machines : $TOTAL" >> "$OUTPUT_FILE"
}

# Menu interactif
while true; do
    echo "============================================"
    echo "=== Statistiques pour le mois $MONTH/$YEAR ==="
    echo "============================================"
    echo "1. Nombre total de connexions"
    echo "2. Connexions par utilisateur"
    echo "3. Connexions par jour"
    echo "4. Machines différentes utilisées"
    echo "5. Quitter"
    echo "============================================"

    read -p "Choisir une option (1-5) : " choice
    case $choice in
        1) total_connections ;;
        2) connections_per_user ;;
        3) connections_per_day ;;
        4) unique_machines ;;
        5) echo "Fin du programme."; break ;;
        *) echo "Option invalide. Réessayez." ;;
    esac
    cat "$OUTPUT_FILE"
    echo "--------------------------------------------"
done

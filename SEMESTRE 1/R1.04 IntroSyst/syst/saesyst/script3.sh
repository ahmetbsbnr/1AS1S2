##############################################################################################
## Script 3 : Statistiques sur le fichier connexion.log sur le mois et par utilisateur      ##
##############################################################################################
## Auteur   : Ahmet BASBUNAR                                                                ##
##############################################################################################
## SAE 1.03 - 2024-2025                                                                     ##
##############################################################################################
## l'Usage  : ./script3.sh <utilisateur> <mois (MM)> <0 (écran) | 1 (fichier)>              ##
## Exemple  : ./script3.sh e26350u 01 0                                                     ##
##############################################################################################

#!/bin/bash

# Vérification si le nombre de paramètres saisis est correct 
if [ "$#" -ne 3 ]; then
    echo "Voici l'Usage du script : $0 <utilisateur> <mois (MM)> <0 (écran) | 1 (fichier)>"
    echo "Exemple : $0 utilisateur1 01 0"
    exit 1
fi

# Paramètres
USERNAME=$1
MONTH=$2
YEAR=$(date +"%Y")
OUTPUT_MODE=$3
LOG_FILE="connexion.log"
OUTPUT_FILE="/dev/stdout"

# Création du fichier de sortie si OUTPUT_MODE=1
if [ "$OUTPUT_MODE" -eq 1 ]; then
    mkdir -p "$YEAR"
    OUTPUT_FILE="${YEAR}/${USERNAME}_${MONTH}.log"
fi

# Filtrage des logs pour l'utilisateur et le mois donné
FILTERED_LOG=$(grep "$USERNAME" "$LOG_FILE" | grep -Ei " $(date -d "2024-$MONTH-01" '+%b|%B')")

# Fonction 1 : Le Nombre total de connexions par utilisateur
total_connexions() {
    TOTAL=$(echo "$FILTERED_LOG" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Nombre total de connexions pour $USERNAME durant le mois $MONTH/$YEAR : $TOTAL" >> "$OUTPUT_FILE"
    echo "--------------------------------------------" > "$OUTPUT_FILE"
}

# Fonction 2 : Le Nombre de connexions par jour par utilisateur
connexions_par_jour() {
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Connexions par jour pour $USERNAME durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$FILTERED_LOG" | awk -F';' '{print $4}' | awk '{print $2}' | sort | uniq -c >> "$OUTPUT_FILE"
    echo "--------------------------------------------" > "$OUTPUT_FILE"
}

# Fonction 3 : Le Nombre de Machines différentes utilisées par utilisateur
Machines_differentes() {
    MACHINES=$(echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq)
    TOTAL=$(echo "$MACHINES" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Machines utilisées durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$MACHINES" >> "$OUTPUT_FILE"
    echo "Nombre total de machines : $TOTAL" >> "$OUTPUT_FILE"
    echo "--------------------------------------------" > "$OUTPUT_FILE"
}

# Fonction 4 : Les Adresses IP différentes utilisées par utilisateur
AdresseIP() {
    IPS=$(echo "$FILTERED_LOG" | awk -F';' '{print $1}' | sort | uniq)
    TOTAL=$(echo "$IPS" | wc -l)
    echo "--------------------------------------------" > "$OUTPUT_FILE"
    echo "Adresses IP utilisées durant le mois $MONTH/$YEAR :" >> "$OUTPUT_FILE"
    echo "$IPS" >> "$OUTPUT_FILE"
    echo "Nombre total d'adresses IP : $TOTAL" >> "$OUTPUT_FILE"
    echo "--------------------------------------------" > "$OUTPUT_FILE"
}

# Le Menu interactif du script
while true; do
    echo "============================================"
    echo "=== Statistiques pour $USERNAME - Mois : $MONTH/$YEAR ==="
    echo "============================================"
    echo "1. Nombre total de connexions"
    echo "2. Connexions par jour"
    echo "3. Machines différentes utilisées"
    echo "4. Adresses IP différentes utilisées"
    echo "5. Quitter"
    echo "============================================"

    read -p "Choisir une option (1-5) : " choice
    case $choice in
        1) total_connexions ;;
        2) connections_par_jour ;;
        3) Machines_differentes ;;
        4) AdresseIP ;;
        5) echo "Fin du programme."; break ;;
        *) echo "Option invalide. Réessayez." ;;
    esac
    cat "$OUTPUT_FILE"
    echo "============================================"
done

##############################################################################################
## Script 2 : statistiques sur le fichier connexion.log par journée et par utilisateur      ##
##############################################################################################
## Auteur   : Ahmet BASBUNAR                                                                ##
##############################################################################################
## SAE 1.03 - 2024-2025                                                                     ##
##############################################################################################
## l'Usage  : ./script2.sh <utilisateur> <YYYY-MM-DD> [fichier]                             ##
## Exemple  : ./script2.sh e26350u 2025-01-01                                               ##
##############################################################################################

#!/bin/bash

# 1. Vérification du nombre de paramètres
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Voici l'Usage du script: $0  saisissez l'utilisateur <utilisateur> la date sous la forme AAAA-MM-JJ <date(YYYY-MM-DD)> [fichier]"
    exit 1
fi

# 2. Récupération des paramètres
USERNAME=$1
DATE=$2
OUTPUT_FILE=${3:-/dev/stdout}   # Soit un fichier, soit la sortie standard
LOG_FILE="connexion.log"

# 3. Définition des fonctions

Connexions_par_heure() {
    # On découpe le 4e champ (date "YYYY-MM-DD HH:MM:SS") => on prend l'heure "HH" 
    {
        echo "--------------------------------------------"
        echo "Connexions par heure pour $USERNAME le $DATE :"
        echo "--------------------------------------------"
        echo "$FILTERED_LOG" \
          | awk -F';' '{print $4}' \
          | cut -d' ' -f2  \
          | cut -d':' -f1  \
          | sort \
          | uniq -c
    } >> "$OUTPUT_FILE"
    cat "$OUTPUT_FILE"

Machines_differentes() {
    {
        echo "--------------------------------------------"
        echo "Machines utilisées par $USERNAME le $DATE :"
        echo "--------------------------------------------"
        echo "$FILTERED_LOG" \
          | awk -F';' '{print $3}' \
          | sort \
          | uniq
        echo "Nombre total de machines : $(echo "$FILTERED_LOG" | awk -F';' '{print $3}' | sort | uniq | wc -l)"
    } >> "$OUTPUT_FILE"
    cat "$OUTPUT_FILE"
}

IPs_differentes() {
    {
        echo "--------------------------------------------"
        echo "Adresses IP utilisées par $USERNAME le $DATE :"
        echo "--------------------------------------------"
        echo "$FILTERED_LOG" \
          | awk -F';' '{print $1}' \
          | sort \
          | uniq
        echo "Nombre total d'adresses IP : $(echo "$FILTERED_LOG" | awk -F';' '{print $1}' | sort | uniq | wc -l)"
    } >> "$OUTPUT_FILE" 
    cat "$OUTPUT_FILE"
}

# 4. Filtrer les logs
# On cherche les lignes où le 2e champ = USERNAME, puis on grep la date YYYY-MM-DD
FILTERED_LOG=$(grep ";${USERNAME};" "$LOG_FILE" | grep "$DATE")




# 5. Menu du script 
while true; do
    echo "============================================"
    echo "=== Statistiques pour $USERNAME le $DATE ==="
    echo "============================================"
    echo "1. Connexions par heure"
    echo "2. Machines différentes utilisées"
    echo "3. Adresses IP différentes utilisées"
    echo "4. Quitter"
    echo "============================================"
    read -p "Choisir une option (1-4) : " CHOIX

    case $CHOIX in
        1) Connexions_par_heure ;;
        2) Machines_differentes ;;
        3) IPs_differentes ;;
        4) echo "Fin du programme."; break ;;
        *) echo "Option invalide. Réessayez." ;;

    esac

done

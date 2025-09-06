#!/bin/bash

###############################################################################
# Script 4 : Statistiques sur le fichier connexion.log sur le mois (tous users)
# Usage : ./script4.sh <mois> <0|1>
#
# Paramètres :
#   - <mois>      : "MM" (ex : 01, 02, 11, etc.)
#   - <0|1>       : 0 => affichage à l'écran, 1 => écriture dans un fichier
#
# Ce script propose un menu permettant de calculer :
#   1) Nombre total de connexions au cours du mois
#   2) Nombre de connexions par utilisateur
#   3) Nombre de connexions par jour
#   4) Nombre de machines différentes (avec la liste + total)
#
# Si <0|1> = 1, on crée un répertoire YEAR/ et on écrit dans MONTH.log (ex: 2024/11.log)
###############################################################################

# 1) Vérification du nombre de paramètres
if [ $# -ne 2 ]; then
  echo "Usage: $0 <mois> <0|1>"
  exit 1
fi

MOIS="$1"       # ex: "11" pour novembre
MODE="$2"       # 0 ou 1
LOG_FILE="connexion.log"

# 2) Filtrage du log pour le mois
#    On suppose que le 4e champ du log contient la date au format "YYYY-MM-DD ..."
#    => on cherche "[0-9]{4}-<MOIS>-"
LIGNES_FILTREES=$(grep "[0-9]\{4\}-${MOIS}-" "$LOG_FILE")

# 3) Définir une fonction output() pour gérer écran ou fichier
output() {
  if [ "$MODE" -eq 0 ]; then
    # Affichage à l'écran
    echo "$1"
  else
    # Écriture dans un fichier YEAR/MOIS.log
    # -> extraire l'année depuis la première ligne filtrée
    ANNEE=$(echo "$LIGNES_FILTREES" | head -n 1 | cut -d ";" -f4 | cut -d "-" -f1)
    if [ -z "$ANNEE" ]; then
      ANNEE="unknown_year"
    fi

    mkdir -p "$ANNEE"
    FICHIER_SORTIE="${ANNEE}/${MOIS}.log"
    echo "$1" >> "$FICHIER_SORTIE"
  fi
}

# 4) Fonctions de statistiques

# 4.1 Nombre total de connexions
total_connections() {
  NB_CONNEXIONS=$(echo "$LIGNES_FILTREES" | wc -l)
  output "Nombre total de connexions sur le mois $MOIS : $NB_CONNEXIONS"
}

# 4.2 Nombre de connexions par utilisateur
connections_by_user() {
  # Le champ 2 est l'utilisateur
  RES_PAR_USER=$(echo "$LIGNES_FILTREES" | cut -d ";" -f2 | sort | uniq -c)
  output "Nombre de connexions par utilisateur (mois=$MOIS) :"
  output "$RES_PAR_USER"
}

# 4.3 Nombre de connexions par jour
connections_by_day() {
  # On extrait la date "YYYY-MM-DD" : 4e champ, puis on prend la partie avant l'espace
  RES_PAR_DAY=$(echo "$LIGNES_FILTREES" \
    | cut -d ";" -f4 \
    | cut -d " " -f1 \
    | sort \
    | uniq -c)
  output "Nombre de connexions par jour (mois=$MOIS) :"
  output "$RES_PAR_DAY"
}


# 4.4 Nombre de machines différentes
machines_diff() {
  # Le champ 3 contient le nom de la machine
  LISTE_MACHINES=$(echo "$LIGNES_FILTREES" | cut -d ";" -f3 | sort | uniq)
  NB_MACHINES=$(echo "$LISTE_MACHINES" | wc -l)
  output "Machines utilisées au cours du mois $MOIS :"
  output "$LISTE_MACHINES"
  output "Nombre total de machines différentes : $NB_MACHINES"
}

# 5) Menu interactif
while true; do
  echo "============================================"
  echo "=== Statistiques pour le mois $MOIS (tous utilisateurs) ==="
  echo "=== (Mode = $MODE) ==="
  echo "============================================"
  echo "1) Nombre total de connexions"
  echo "2) Nombre de connexions par utilisateur"
  echo "3) Nombre de connexions par jour"
  echo "4) Machines différentes (+ total)"
  echo "5) Quitter"
  echo "============================================"
  echo -n "Choix (1-5) : "
  read CHOIX

  case "$CHOIX" in
    1) total_connections ;;
    2) connections_by_user ;;
    3) connections_by_day ;;
    4) machines_diff ;;
    5)
       echo "Fin du script."
       exit 0
       ;;
    *)
       echo "Choix invalide."
       ;;
  esac
done

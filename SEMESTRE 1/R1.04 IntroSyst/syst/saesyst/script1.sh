##############################################################################################
## Script 1 : Ajout d'une ligne au fichier de log "connexion.log"                       ##
##############################################################################################
## Auteur   : Ahmet BASBUNAR                                                                ##
##############################################################################################
## SAE 1.03 - 2024-2025                                                                     ##
##############################################################################################
## l'Usage  : ./script1.sh <utilisateur> <YYYY-MM-DD>                                       ##
## Exemple  : ./script1.sh e26350u 2025-01-01                                               ##
##############################################################################################

#!/bin/bash

LOG_FILE="connexion.log"                                        #Definition du fichier de log "connexion.log"

#Recuperation des infos de connexion : 
IP=$(hostname -I | awk '{print $1}')                                     #Recuperation de l'adresse IP
USER_NAME=$(whoami)                                                     #Recuperation du nom d'utilisateur
HOST_NAME=$(hostname)                                                  #Recuperation du nom de l'ordinateur 
DATE_CONNEXION=$(date +"%A %d %B %Y %H:%M:%S %Z")                   #Recuperation de la date de connexion

echo "$IP;$USER_NAME;$HOST_NAME;$DATE_CONNEXION" >> "$LOG_FILE"     #Ajout des infos de connexion dans le fichier de log "connexion.log" 

echo "Voici les lignes ajouté dans $LOG_FILE."                              #Affichage d'un message de confirmation
echo "Adresse IP : $IP;"
echo "Nom d'utilisateur : $USER_NAME"
echo "Nom de la machine : $HOST_NAME"
echo "Date de Connexion = $DATE_CONNEXION"
echo "Merci"
#!/bin/bash
LOG_FILE="connexion.log"

IP=$(hostname -I | awk '{print $1}')
USER_NAME=$(whoami)
HOST_NAME=$(hostname)
DATE_CONNEXION=$(date +"%a. %d %b. %Y %H:%M:%S %Z")

echo "$IP;$USER_NAME;$HOST_NAME;$DATE_CONNEXION" >> "$LOG_FILE"

echo "Ligne ajoutée dans $LOG_FILE."


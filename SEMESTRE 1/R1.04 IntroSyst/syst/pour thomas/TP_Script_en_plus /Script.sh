#!/bin/bash

# Vérification de la présence d'un argument
if [ "$#" -ne 1 ]; then
    echo "Erreur : Vous devez fournir un fichier en argument."
    exit 1
fi

# Vérification que l'argument est un fichier
if [ ! -f "$1" ]; then
    echo "Erreur : L'argument fourni n'est pas un fichier valide."
    exit 1
fi

# Fichier donné en argument
fichier="$1"

# Affichage du menu
menu() {
    echo ""
    echo "Que voulez-vous faire ?"
    echo "1) Voir les droits de l'utilisateur sur le fichier"
    echo "2) Ajouter le droit d'exécution pour le propriétaire"
    echo "3) Supprimer le fichier avec sauvegarde dans un répertoire poubelle"
    echo "4) Déplacer le fichier vers un autre répertoire"
    echo "5) Copier le fichier vers un autre répertoire"
    echo "6) Créer une copie avec horodatage"
    echo "7) Quitter"
}

# Fonction pour afficher les droits de l'utilisateur
voir_droits() {
    echo ""
    echo "Droits pour l'utilisateur :"
    [ -r "$fichier" ] && echo "Lecture : Oui" || echo "Lecture : Non"
    [ -w "$fichier" ] && echo "Écriture : Oui" || echo "Écriture : Non"
    [ -x "$fichier" ] && echo "Exécution : Oui" || echo "Exécution : Non"
}

# Fonction pour ajouter le droit d'exécution
ajouter_execution() {
    chmod u+x "$fichier"
    echo "Droit d'exécution ajouté pour le propriétaire."
}

# Fonction pour déplacer le fichier dans un répertoire poubelle
mettre_poubelle() {
    poubelle="$HOME/poubelle"
    if [ ! -d "$poubelle" ]; then
        mkdir "$poubelle"
        echo "Répertoire poubelle créé."
    fi
    mv "$fichier" "$poubelle"
    echo "Fichier déplacé dans le répertoire poubelle : $poubelle"
}

# Fonction pour déplacer le fichier
deplacer_fichier() {
    echo "Entrez le chemin du répertoire cible :"
    read repertoire
    if [ -d "$repertoire" ]; then
        mv "$fichier" "$repertoire"
        echo "Fichier déplacé dans : $repertoire"
    else
        echo "Erreur : Le répertoire n'existe pas."
    fi
}

# Fonction pour copier le fichier
copier_fichier() {
    echo "Entrez le chemin du répertoire cible :"
    read repertoire
    if [ -d "$repertoire" ]; then
        cp "$fichier" "$repertoire"
        echo "Fichier copié dans : $repertoire"
    else
        echo "Erreur : Le répertoire n'existe pas."
    fi
}

# Fonction pour créer une copie avec horodatage
copie_horodatage() {
    date=$(date +%Y%m%d_%H%M)
    copie="${date}_$(basename "$fichier")"
    cp "$fichier" "$copie"
    echo "Copie créée : $copie"
}

# Boucle principale
tant_que=true
while $tant_que; do
    menu
    echo "Choisissez une option :"
    read choix

    case $choix in
        1)
            voir_droits
            ;;
        2)
            ajouter_execution
            ;;
        3)
            mettre_poubelle
            ;;
        4)
            deplacer_fichier
            ;;
        5)
            copier_fichier
            ;;
        6)
            copie_horodatage
            ;;
        7)
            echo "Au revoir !"
            tant_que=false
            ;;
        *)
            echo "Option invalide. Veuillez réessayer."
            ;;
    esac
done

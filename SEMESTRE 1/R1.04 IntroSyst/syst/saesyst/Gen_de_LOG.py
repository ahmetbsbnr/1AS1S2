#!/usr/bin/env python3
import datetime
import random
import os

##############################################################################
# Configuration
##############################################################################

USER = "e26350u"  # Utilisateur fixe

# Lecture des salles depuis un fichier de références "salles.txt"
rooms = {}
try:
    with open("salles.txt", "r", encoding="utf-8") as f:
        for line in f:
            parts = line.strip().split(',')
            if len(parts) == 2:
                room, count = parts
                try:
                    rooms[room] = int(count)
                except ValueError:
                    pass
except FileNotFoundError:
    print("Erreur : le fichier salles.txt est introuvable.")
    exit(1)

if not rooms:
    print("Erreur : aucune salle n'a été chargée depuis salles.txt.")
    exit(1)

# Intervalle de dates : du 1er septembre 2024 au 31 janvier 2025
start_date = datetime.date(2024, 9, 1)
end_date   = datetime.date(2025, 1, 31)

##############################################################################
# Construction de la liste complète des machines
##############################################################################
all_machines = []
for room, count in rooms.items():
    for i in range(1, count + 1):
        machine_name = f"iutm-inf-{room}-{i}"
        all_machines.append(machine_name)

##############################################################################
# Fonctions auxiliaires
##############################################################################

def generate_random_ip():
    """Génère une IP aléatoire dans la plage 100.64.x.x."""
    octet3 = random.randint(0, 255)
    octet4 = random.randint(0, 255)
    return f"100.64.{octet3}.{octet4}"

def format_date_in_french(dt):
    """
    Transforme un datetime Python en chaîne du style 
    "mercredi 01 septembre 2025 14:31:58 CET" sans accents.
    """
    days_fr = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]
    months_fr = [
        "janvier", "fevrier", "mars", "avril", "mai", "juin",
        "juillet", "aout", "septembre", "octobre", "novembre", "decembre"
    ]
    day_of_week_fr = days_fr[dt.weekday()]
    month_fr = months_fr[dt.month - 1]
    return f"{day_of_week_fr} {dt.day:02d} {month_fr} {dt.year} {dt.hour:02d}:{dt.minute:02d}:{dt.second:02d} CET"

##############################################################################
# Génération d'un log par jour, par machine
##############################################################################

def main():
    # Créer un répertoire pour stocker le fichier log, si nécessaire
    output_dir = "logs_by_month"
    os.makedirs(output_dir, exist_ok=True)
    log_filename = os.path.join(output_dir, "connexion.log")
    
    with open(log_filename, "w", encoding="utf-8") as f:
        current_date = start_date
        total_lines = 0

        while current_date <= end_date:
            for machine in all_machines:
                ip = generate_random_ip()
                hour = random.randint(0, 23)
                minute = random.randint(0, 59)
                second = random.randint(0, 59)

                dt = datetime.datetime(
                    current_date.year,
                    current_date.month,
                    current_date.day,
                    hour, minute, second
                )

                date_str = format_date_in_french(dt)
                line = f"{ip};{USER};{machine};{date_str}\n"
                f.write(line)
                total_lines += 1

            current_date += datetime.timedelta(days=1)

    print(f"Fichier {log_filename} généré avec {total_lines} lignes.")

if __name__ == "__main__":
    main()
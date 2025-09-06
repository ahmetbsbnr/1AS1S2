import queue # importation du module FIFO

# représentation par listes d'adjacence
# --> utilisation d'un dictionnaire (table associative, map)
G = {
	'a': ['b', 'c', 'd'], # liste contenant les successeurs de 'a'
	'b': ['a'],           # liste contenant les successeurs de 'b'
	'c': ['d', 'e'],      # etc.
	'd': ['b'],
	'e': [],
	'f': ['c', 'g'],
	'g': ['e', 'f']
}

# initialisations
r = 'a'                 # r est le sommet de départ
A = {s : s for s in G}  # A est la table des pères de l'arbo des descendants de r
A[r] = None             # r est la racine de l'arbo
F = queue.Queue()       # F est une file (FIFO),
F.put(r)                # pour mémoriser les sommets à traiter
D = [r]                 # liste des descendants de r

# itérations
while not F.empty():
    s = F.get()         # extraction du sommet en tête de file (defiler)
    for x in G[s]:
        if A[x] == x:   # si x n'est pas dans l'arbo des descendants de r
            A[x] = s    # s est le père de x
            D.append(x) # ajout de x à la liste des descedants de r
            F.put(x)    # ajout du sommet s en queue de file (enfiler)

# affichage des résultats
print('\narborescence des descendants de', r, ':\n', A, '\n')
print('\nles descendants de', r, ':\n', D, '\n')

# REMARQUE
# Ce programme réalise une exploration "en largeur d'abord" d'un graphe.
# Étant donné un sommet r, on "visite" les successeurs de r, puis
# les successeurs non visités des successeurs de r, etc.



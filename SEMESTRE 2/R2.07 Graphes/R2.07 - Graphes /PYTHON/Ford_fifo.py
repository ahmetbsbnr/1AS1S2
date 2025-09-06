import math  # module contenant la constance math.inf (+ infini)
import queue # module python pour FIFO

# représentation par liste d'adjacence
G = {
	'a' : [('b', 5), ('d', 3)],
	'b' : [('c', -1), ('f', 2)],
	'c' : [('a', 4), ('b', 2)],
	'd' : [('e', 4), ('f', 2), ],
	'e' : [],
	'f' : [('a', -3), ('e', 3)]
}

# initialisations
n  = len(G)
r  = 'c'
Pi = {s:math.inf for s in G}
A  = {s:s for s in G}
Pi[r] = 0
A[r]  = None

# initialisations : suite
F = queue.Queue()          # F : FIFO
F.put((r, 0))              # éléments de la file : (s, poids du chemin de r à s)
passage = {s:0 for s in G} # nombre de passages de chaque sommet dans la file
passage[r] = 1
arret = False
count = 0

# itérations
print("\nAméliorations successives :")
while not F.empty() and not arret and Pi[r] == 0:
    # print("FIFO :", list(F.queue))
    (s, pot_s) = F.get()   # pot_s = potentiel de s au moment de l'ajout de s dans F
    if pot_s <= Pi[s]:     # seule la dernière occurence de s dans F est prise en compte
        # relâchement des arcs d'origine s
        for (x, p) in G[s]:
            count += 1
            if Pi[x] > pot_s + p:
                Pi[x] = pot_s + p
                A[x] = s
                print(f'({s}, {x}) améliorant : pi[{x}] = {Pi[x]} et A[{x}] = {s}')
                F.put((x, Pi[x])) # x peut déjà être dans F avec un potentiel plus grand
                passage[x] += 1
                if passage[x] > n:
                    arret = True
                    break  # sortie de la boucle for

# affichage des résultats
print('\nRésultats : ')
if F.empty():
	for x in G:
	    print(x, ":", Pi[x], ',', A[x])
	print(f'\nnombre de relâchements : {count}')
else:
	print ('le graphe contient des circuits absorbants')
print()

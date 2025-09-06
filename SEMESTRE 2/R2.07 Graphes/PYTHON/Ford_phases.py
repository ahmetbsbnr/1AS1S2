import math  # module contenant la constance math.inf (+ infini)

# représentation par liste d'adjacence
g = {
	'a' : [('b', 5), ('d', 3)],
	'b' : [('c', -1), ('f', 2)],
	'c' : [('a', 4), ('b', 2)],
	'd' : [('e', 4), ('f', 2), ],
	'e' : [],
	'f' : [('a', -3), ('e', 3)]
}

exo2 = {
	'a' : [('c', 1)],
	'b' : [('a', -2), ('c', 3), ('d', -1)],
	'c' : [('b', 2), ('d', 2), ('e', 2) ],
	'd' : [('b', 2), ('c', 1)],
	'e' : [('d', -2)]
}

exo4 = {
	'a' : [('b', 1), ('c', 2)],
	'b' : [('c', -2), ('e', 2)],
	'c' : [('a', 3), ('d', 2)],
	'd' : [('e', 3), ('f', 2)],
	'e' : [('b', 1), ('f', -1)],
	'f' : [('e', 3), ('g', -1)],
	'g' : [('e', 3), ('d', 3)]
}

# initialisations
G = exo4
n  = len(G)
r  = 'a'
Pi = {s:math.inf for s in G}
A  = {s:s for s in G}
Pi[r] = 0
A[r]  = None
count = 0

# répétition de n phases au plus
for phase in range(0, n):
	ameliorant = False
	print(f'\nPhase {phase+1}')
	# pour chaque sommet s du graphe
	for s in G:
		# on relâche tous les arcs d'origine s
		for (x, p) in G[s]:
			count += 1
			if Pi[x] > Pi[s] + p:
				Pi[x] = Pi[s] + p
				A[x] = s
				ameliorant = True
				print(f'({s}, {x}) améliorant : pi[{x}] = {Pi[x]} et A[{x}] = {s}')
	if not ameliorant or Pi[r] < 0:
		break

# affichage des résultats
print('\nRésultats : ')
if not ameliorant:
	for x in G:
	    print(x, ":", Pi[x], ',', A[x])
	print(f'\nnombre de relâchements : {count}')
else:
	print ('le graphe contient des circuits absorbants')
print()

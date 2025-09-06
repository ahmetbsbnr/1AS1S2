import queue
import math
import sys

G1 = {
	'a' : [('b', 1), ('c', 3)],
	'b' : [('c', 1), ('d', 1), ('e', 4)],
	'c' : [('f', 1)],
	'd' : [('e', 2), ('f', 3), ('g', 2)],
	'e' : [('f', 1)],
	'f' : [('g', 3)],
	'g' : []
}

G2 = {
	'a' : [('e', 2), ('f', 4), ('g', 2)],
	'b' : [('a', 1), ('g', 4)],
	'c' : [('d', 4), ('f', 1), ('h', 2)],
	'd' : [],
	'e' : [('f', 1), ('h', 3)],
	'f' : [('h', 3)],
	'g' : [('f', 3)],
	'h' : [('d', 1)]
}

def tri_topo(G):
    # calcul des degrés intérieurs
    marque = {x:0 for x in G}
    for (x, succ) in G.items():
        for (s, p) in succ:
            marque[s] = marque[s] + 1

    # initialisations de la file des candidats
    C = queue.Queue() 
    for s in G:
        if marque[s] == 0:
            C.put(s)

    # itérations
    topo = []  # liste des sommets rangés dans un ordre topologique
    while not C.empty():
        s = C.get()
        topo.append(s)
        for (x, p) in G[s]:
            marque[x] = marque[x] - 1
            if marque[x] == 0:
                C.put(x)

	# résultats
    return len(topo) != len(G), topo

G = G2

# tri topologique
circuit, topo = tri_topo(G)
if circuit:
	sys.exit('\nle graphe contient des cirucits\n')

# initialisations
r  = 'a'
Pi = {s:math.inf for s in G}
A  = {s:s for s in G}
Pi[r] = 0
A[r]  = None

# itérations
for s in topo:
	if Pi[s] < math.inf:
		for (x, p) in G[s]:
			if Pi[x] > Pi[s] + p:
				Pi[x] = Pi[s] + p
				A[x]  = s
	
print ('Résultats :\n')
for x in topo:
	print(x, ":", Pi[x], ',', A[x])
print()
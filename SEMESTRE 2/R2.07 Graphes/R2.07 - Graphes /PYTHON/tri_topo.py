import queue

G1 = {
	'a' : ['b', 'c'],
	'b' : ['c', 'e'],
	'c' : ['g'],
	'd' : [],
	'e' : ['d', 'g'],
	'f' : ['e', 'g'],
	'g' : ['d']
}

G2 = {
	'a' : ['b', 'f'],
	'b' : ['d', 'f', 'g'],
	'c' : [],
	'd' : ['c', 'e'],
	'e' : ['c'],
	'f' : ['e', 'g'],
	'g' : ['d', 'e']
}

def tri_topo(G):
    # calcul des marques (degrés intérieurs)
    marque = {x:0 for x in G}
    for (x, succ) in G.items():
        for s in succ:
            marque[s] = marque[s] + 1

    # initialisation de la file des candidats
    C = queue.Queue() 
    for s in G:
        if marque[s] == 0:
            C.put(s)

    # itérations
    topo = []  # liste des sommets rangés dans un ordre topologique
    while not C.empty():
        s = C.get()
        topo.append(s)
        for x in G[s]:
            marque[x] = marque[x] - 1
            if marque[x] == 0:
                C.put(x)
    return len(topo)!=len(G), topo

circuit, topo = tri_topo(G1)
print()
if circuit:
    print('Le graphe contients des circuits')
else:
    print('Ordre topologique :', tri_topo(G2))
print()







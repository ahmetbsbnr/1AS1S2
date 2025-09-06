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

def dfs(G, s, Din, Dout):
    Din.append(s)
    for (x, p) in G[s]:
        if x not in Din:
            dfs(G, x, Din, Dout)
    Dout.append(s)

def tri_topo(G):
	Din  = []
	Dout = []
	for s in G:
		if s not in Din:
			dfs(G, s, Din, Dout)
	Dout.reverse()
	return len(Din) != len(G), Dout

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
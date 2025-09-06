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

def dfs(G, s, Din, Dout):
    Din.append(s)
    for x in G[s]:
        if x not in Din:
            dfs(G, x, Din, Dout)
    Dout.append(s)

G = G1

# exploration en profondeur du graphe
Din  = []
Dout = []
for s in G:
    if s not in Din:
        dfs(G, s, Din, Dout)

# résultat
if len(Din) != len(G):
    print('Le graphe contients des circuits')
else:
    print('\nliste des entrées :', Din)
    print('\nliste des sortie  :', Dout)
    Dout.reverse()
    print('\nordre topologique :', Dout)
    print()

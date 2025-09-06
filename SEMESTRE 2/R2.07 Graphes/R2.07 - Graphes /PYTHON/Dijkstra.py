import math
import heapq

G = {
	'a' : [('b', 5), ('c', 1)],
	'b' : [('d', 1)],
	'c' : [('a', 1), ('b', 2), ('d', 4), ('e', 1)],
	'd' : [('e', 1)],
	'e' : [('c', 2), ('d', 3)]
}

# initialisations
r  = 'a'
Pi = {s:math.inf for s in G}
A  = {s:s for s in G}
Pi[r] = 0
A[r]  = None
count = 0
B = [(0, r)] # bordure représentée par une file de priorité d'éléments (potentiel, sommet)
             # plus le potentiel est petit, plus la priorité est grande
print()
while B: # tant que B n'est pas vide
    # print ('\nBordure    :', heapq.nsmallest(len(B),B))
    (poids, s) = heapq.heappop(B)
    if poids > Pi[s]: # si vrai c'est que s est déjà passé par B avec un potentiel inférieur
        continue
    for (x, p) in G[s]:
        count+=1
        if Pi[x] > Pi[s] + p:
            Pi[x] = Pi[s] + p
            A[x] = s
            heapq.heappush(B, (Pi[x], x))
    #print ('Examiner',s, ':', {x:(Pi[x], A[x]) for x in G})

print ('Résultats :')
for x in G:
	print(x, ":", Pi[x], ',', A[x])
print(f'\nnombre de relâchements : {count}\n')
		
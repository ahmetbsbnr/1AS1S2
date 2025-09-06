import numpy as np

# les sommets sont identifiés par les entiers 0, 1, 2, etc
# matrice d'adjacence booléenne
M = np.array([[0, 1, 0, 0], [1, 0, 1, 0], [0, 0, 0, 1], [0, 0, 0, 0]], dtype=bool)
(n, p) = np.shape(M) # n est le nombre de lignes, p est le nombre de colonnes (ici n = p = 4)


F = M.copy() # F est la matrice d'adjacence de la fermeture transitive
print(f"\nF[init] = \n{1*F}\n")

for s in range(n):
    for x in range(n):
        for y in range(n):
            F[x,y] = F[x,y] or F[x,s] and F[s,y]
    print(f"F[{s}] = \n{1*F}\n")
print(f"F = \n{1*F}\n")

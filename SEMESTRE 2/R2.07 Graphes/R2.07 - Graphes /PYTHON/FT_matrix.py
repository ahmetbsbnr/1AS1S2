import numpy as np

# les sommets sont identifiés par les entiers 0, 1, 2, etc
# matrice d'adjacence booléenne
M = np.array([[0, 1, 0, 0], [1, 0, 1, 0], [0, 0, 0, 1], [0, 0, 0, 0]], dtype=bool)
(n, p) = np.shape(M) # n est le nombre de lignes, p est le nombre de colonnes (ici n = p = 4)

# calculs matriciels
P = np.identity(n, dtype=bool)  # matrice de travail pour calculer les puissances de M
F = np.zeros((n,n), dtype=bool) # matrice d'adjacence de la fermeture transitive
for k in range(1, n+1):
    P = np.dot(P, M) # produit matriciel "P <- P * M", ici P contient M**k
    # print(f"M**{k} = \n{P}") # affiche les booléens True/False
    # la multiplication 1*P transforme P en une matrice d'entiers => affiche 1/0 au lieu de True/False
    print(f"\nM**{k} = \n{1*P}")
    F = F + P
print(f"\nF = \n{1*F}\n")
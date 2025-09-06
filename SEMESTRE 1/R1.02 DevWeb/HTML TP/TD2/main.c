#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/random.h>

// SMILEY
#define SOURIRE "\U0001F642"
#define MEDAILLE "\U0001F947"
// Booleen
#define VRAI 1
#define FAUX 0

// creation de la grille
void Creationtab(int nbl, int nbc,
                 int grille[7][7]) { // définition (création) de la grille 7/7
  int i, j;
  for (i = 0; i < nbl; i++)
    for (j = 0; j < nbc; j++)
      grille[i][j] = 0;
}

// Affichage de la table en couleur
void affichetabcouleur(int nbl, int nbc, int grille[7][7]) {
  int i, j;
  for (i = 0; i < nbl; i++) {
    printf("\n+---++---++---++---++---++---++---+\n");
    for (j = 0; j < nbc; j++) {
      printf("|");
      if (grille[i][j] <= -1)
        printf("\e[0;31m %d \e[0m", abs(grille[i][j]));
      else if (grille[i][j] >= 1)
        printf("\e[0;34m %d \e[0m", grille[i][j]);
      else if (grille[i][j] == 0)
        printf(" %d ", grille[i][j]);
      printf("|");
    }
  }
  printf("\n+---++---++---++---++---++---++---+\n");
}

int main() {
  // Déclaration de toutes les variable
  char nom_a[20], nom_b[20];
  int verificationlc;
  char rep;
  int grille[7][7];
  int j, i, b;
  int c, l, nbc, nbl, verifsaisie;
  int sa, sb, posj, posi;
  int nbjetons;
  char details;
  int rejouer = 1;
  int score_a = 0;
  int score_b = 0;

  // Initialisation de la partie
  printf("\n\e[0;36m===================================\e[0m\n");
  printf("\e[0;36m(Re)bonjour bienvenue sur le jeu X \a\e[0m\n");
  printf("\e[0;36m===================================\e[0m\n");
  // règles
  printf("Rappel des Règles :\nLe joueur qui gagnera la partie sera le joueur "
         "qui aura la plus petite somme autour de la case qui restera "
         "vide.\nLe Joueur qui aura la couleur bleu sera celui qui aura mis "
         "son nom en premier et donc jouera en premier. Et le rouge donc sera "
         "le joueur B\nLes joueurs positionnent chacun leurs jetons tour à "
         "tour jusqu'à \nleur épuisement.\nBon Jeu !!!!!\n\n" SOURIRE);
  // Initialisation des noms des deux joueurs
  printf("\nSaisir le nom du joueur A\n");
  scanf("%s", nom_a);
  printf("Saisir le nom du joueur B\n");
  scanf("%s", nom_b);
  printf("\e[0;36mNom du joueur A :\e[0m\n %s", &nom_a);
  printf("\e[0;36m \nNom du joueur B :\e[0m\n %s", &nom_b);

  do { /* Verification de saisie et affichage des détails du jeu */
    printf("\n\nDesirer vous avoir plus de détails? (o/n) %s %s %s %s", nom_a,
           "ou", nom_b, "?\n");
    while ((getchar()) != '\n')
      ;
    details = getchar();
    if (details == 'o') {

      printf("\n\nTout d'abord le jeu se déroule dans un tableau avec "
             "possibilité \nde l'avoir en 3/5/7 seulement et nul autre "
             "dimensions. Les joueurs jouent chacun leur tour. Le but du jeu "
             "est d'avoir la plus petite somme autour du zero, ATTENTION le "
             "zero n'est pas définie dès le début, c'est à vous de faire "
             "attention au fur à mesure la ou vous remplissez la derniere case "
             "est automatiquement pas remplissable\n donc elle sera considère "
             "comme la case vide. \nLa somme des point correspont aux jetons "
             "qui ont été mis à côté de la case vide.\n\n");
    } else if (details != 'o' && details != 'n') {
      printf("Saisie invalide. Veuillez faire un choix entre 'o' pour afficher "
             "les règles et 'n' pour ne pas les afficher.\n");
    }
  } while (details != 'o' && details != 'n');

  while (rejouer == 1) {

    // initialisation de la taille du tableau de jeu
    do {
      verificationlc = VRAI;
      printf("\e[0;36m\nSaisir dans cette ordre le nombre de lignes et de "
             "colonnes \n(choix possible 3/5/7):\e[0m\n");
      scanf("%d", &nbl);
      scanf("%d", &nbc);
      printf("\nNombre de lignes :\n %d", nbl);
      printf("\nNombre du colonnes :\n %d\n", nbc);
      // test pour savoir si les valeurs sont correctes
      if ((nbl == 3 || nbl == 5 || nbl == 7) &&
          (nbc == 3 || nbc == 5 || nbc == 7))
        verificationlc = VRAI;
      else {
        verificationlc = FAUX;
        printf("\n\e[0;33mValeurs incorrectes\n");
      }
      if (verificationlc == VRAI)
        printf("\n\e[0;33mLes Valeurs sont correctes\n\e[0m");
      else {
        printf("\e[0;33mUne autre saisie (rep O ou N) ? \n\e[0m");
        getchar();
        scanf("%c", &rep);
        getchar();
      }
      // fin de la verification
    } while (verificationlc == FAUX);

    Creationtab(nbl, nbc, grille);
    affichetabcouleur(nbl, nbc, grille);

    nbjetons = (nbl * nbc - 1) / 2; // Calcul du nombre de Jetons
    printf("\e[0;36mChaque joueur aura %d jetons et donc il y aura %d tours  "
           "\n\e[0m",
           nbjetons, nbjetons); //     Affichage du nombre de jetons

    // Remplir tableau

    l = i;
    c = j;
    for (b = 1; b <= nbjetons; b++) // nombre de tours du jeu
    {
      // Affichage au debut de chaque tour
      printf("\n\e[0;32m============================\e[0m");
      printf("\n\e[0;32m\tC'est le tour n° %d\n\e[0m", b);
      printf("\e[0;32m============================\e[0m\n");
      printf("\e[0;34mLe joueur %s doit jouer\e[0m\n", nom_a);

      do {
        // Saisie des coordonnées du jetons a poser
        printf("\n\e[0;36mVeuillez donner le numero de la ligne allant de 1 à "
               "%d :\e[0m\n",
               nbl);
        scanf("%d", &l);
        printf("\n\e[0;36mVeuillez donner le numero de la colonne allant de à "
               "1 %d :\e[0m\n",
               nbc);
        scanf("%d", &c);
        l = l - 1;
        c = c - 1;

        // verification de la saisie des coordonnées du placement de jetons
        if (l < nbl && c < nbc) {
          verifsaisie = VRAI;
        } else {
          verifsaisie = FAUX;
          printf("\n\e[0;33mValeur au dela du tableau\e[0m\n");
        }

        if (grille[l][c] != 0) {
          verifsaisie = FAUX;
          printf("\n\e[0;33mValeur incorrecte case déja remplie\e[0m\n");
        } else {
          verifsaisie = VRAI;
        }
      } while (verifsaisie == FAUX);
      // Fin de la verification

      grille[l][c] = b;
      affichetabcouleur(nbl, nbc, grille);
      printf("\n\e[0;31m Le joueur %s doit jouer\e[0m\n", nom_b);

      do {
        // Saisie des coordonnées du jetons a poser
        printf("\n\e[0;36mVeuillez donner le numero de la ligne allant de 1 à "
               "%d :\e[0m\n",
               nbl);
        scanf("%d", &l);
        printf("\n\e[0;36mVeuillez donner le numero de la colonne allant de 1 "
               "à %d :\e[0m\n",
               nbc);
        scanf("%d", &c);
        l = l - 1;
        c = c - 1;

        // verification de la saisie des coordonnées du placement de jetons
        if (l <= nbl - 1 && c <= nbc - 1) {
          verifsaisie = VRAI;
        } else {
          verifsaisie = FAUX;
          printf("\e[0;33m Valeur au dela du tableau\e[0m\n");
        }

        if (grille[l][c] != 0) {
          verifsaisie = FAUX;
          printf("\n\e[0;33m Valeur incorrecte case deja remplie\a\e[0m\n");
        } else {
          verifsaisie = VRAI;
        }
      } while (verifsaisie == FAUX);
      // Fin de la verification

      grille[l][c] = -b;
      affichetabcouleur(nbl, nbc, grille);
    }

    // Test pour connaitre la position de la case vide ici 0
    for (i = 0; i < nbl; i++) {
      for (j = 0; j < nbc; j++) {
        if (grille[i][j] == 0) {
          posi = i; // stockage de la position dans deux variables
          posj = j;
        }
      }
    }
    // Fin test

    /* Test pour savoir si le tableau est plein:*/

    for (i = 0; i < nbl; i++)
      for (j = 0; j < nbc; j++)
        if (grille[i][j] == 0)
          printf("\nLe tableau est plein\n");
    // Fin test

    // Somme des valeurs autour de la case vide avec les 9 cas possibles
    sa = 0;
    sb = 0;
    if (posi == 0) {
      if (posj == 0) // cas haut gauche
      {
        for (i = 0; i <= 1; i++) {
          for (j = 0; j <= 1; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      } else if (posj == nbc - 1) // cas haut droite
      {
        for (i = 0; i <= 1; i++) {
          for (j = posj - 1; j <= posj; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      } else // cas pour haut centre
      {
        for (i = 0; i <= 1; i++) {
          for (j = posj - 1; j <= posj + 1; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      }
    } else if (posi == nbl - 1) // cas bas gauche
    {
      if (posj == 0) {
        for (i = posi - 1; i <= posi; i++) {
          for (j = 0; j <= 1; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      } else if (posj == nbc - 1) // cas bas droite
      {
        for (i = posi - 1; i <= posi; i++) {
          for (j = posj - 1; j <= posj; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      } else // cas bas centre
      {
        for (i = posi - 1; i <= posi; i++) {
          for (j = posj - 1; j <= posj + 1; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      }
    } else {
      if (posj == 0) // cas pour centre droite
      {
        for (i = posi - 1; i <= posi + 1; i++) {
          for (j = posj; j <= posj + 1; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      } else if (posj == nbc - 1) // cas pour centre gauche
      {
        for (i = posi - 1; i <= posi + 1; i++) {
          for (j = posj - 1; j <= posj; j++) {
            if (grille[i][j] < 0)
              sb = sb + grille[i][j];
            else
              sa = sa + grille[i][j];
          }
        }
      } else // cas pour le centre
      {
        for (i = posi - 1; i <= posi + 1; i++) {
          for (j = (posj - 1); j <= (posj + 1); j++) {
            if (grille[i][j] >= 1)
              sa = sa + grille[i][j];
            else if (grille[i][j] <= -1)
              sb = sb + grille[i][j];
          }
        }
      }
    }
    // Fin du calcul des sommes
    sb = sb * -1; // Passage de la somme en valeur positive pour le joueur B
    // affichage de la somme
    printf("\nLa somme de a est %d\n", sa);
    printf("\nLa somme de b est %d\n", sb);

    // Gagnant
    if (sa > sb) {
      printf("\n\nLe joueur %s a gagné", nom_b);
      score_b = score_b + 1;
    } else if (sb > sa) {
      printf("\n\nLe joueur %s a gagné", nom_a);
      score_a = score_a + 1;
    } else {
      printf("\nEgalité !!!");
    }

    printf("%s %s\n\n", SOURIRE, MEDAILLE);

    printf("\n\nVotre score de %d est : %s", score_a, nom_a);
    printf("\n\nVotre score de %d est : %s", score_b, nom_b);

    /* Verification de saisie et de si les joueurs veulent rejouer */
    do {
      printf("\n\nDesirer vous rejouer? (o/n) %s %s %s %s", nom_a, "ou", nom_b,
             "?\n");
      while ((getchar()) != '\n')
        ;
      details = getchar();
      rejouer = 0; // arret le jeu
      if (details == 'o' || details == 'O') {
        printf("\nLet's go pour une autre partie !\n"); // suite du jeu
        rejouer = 1;
      } else if (details != 'o' && details != 'n') {
        printf("\nSaisie invalide. Veuillez faire un choix entre 'o' pour "
               "afficher les règles et 'n' pour ne pas les afficher.\n");
      }
    } while ((details != 'o' || details == 'O') && (details != 'n'));
  }
}

#include <stdio.h>

typedef struct {
    int numerateur;
    int denominateur;
} Fraction;

Fraction Creer_Frac(int a, int b) {
    if (b == 0) {
        printf("Erreur : le dénominateur ne peut pas être zéro.\n");
        Fraction frac = {a, 1};
        return frac;
    }
    Fraction frac = {a, b};
    return frac;
}
int main() {
    Fraction f = Creer_Frac(3, 4);
    printf("Fraction créée : %d/%d\n", f.numerateur, f.denominateur);
    return 0;
}
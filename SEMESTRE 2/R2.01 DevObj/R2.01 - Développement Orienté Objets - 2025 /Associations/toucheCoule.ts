import { Bateau } from "./Bateau.ts";
import { Cellule } from "./Cellule.ts";
import { Mer } from "./Mer.ts";
import { Position } from "./Position.ts";
import assert from 'node:assert';

function main() {
    console.log("=== Test de la classe Cellule ===");

    // Test Cellule vide
    let cellule = new Cellule();
    assert.equal(cellule.toucher() , "Dans l'eau", "Erreur : Une cellule vide doit renvoyer 'Dans l'eau'");

    // Test Cellule avec Bateau
    const bateauTest = new Bateau(2);
    cellule = new Cellule();
    cellule.bateau = bateauTest;
    assert.equal(cellule.toucher(), "Touché", "Erreur : Un bateau touché doit renvoyer 'Touché'");

    console.log("✅ Tests de Cellule passés avec succès !");

    console.log("=== Test de la classe Mer ===");

    const mer = new Mer([10, 10]);
    const bateau1 = new Bateau(3);
    const bateau2 = new Bateau(2);

    try {
        mer.ajouterBateau(bateau1, new Position(2, 3));
        mer.ajouterBateau(bateau2, new Position(5, 5));
    } catch (error) {
        console.error("Erreur lors de l'ajout du bateau :", error);
    }

    //Tests positionnement
    const c1 = mer.carte[2][3];
    const c2 = mer.carte[3][3];
    const c3 = mer.carte[4][3];
    assert.equal(c1.bateau, bateau1, "Erreur : le bateau 1 doit etre dans c1.");
    assert.equal(c2.bateau, bateau1, "Erreur : le bateau 1 doit etre dans c2.");
    assert.equal(c3.bateau, bateau1, "Erreur : le bateau 1 doit etre dans c3.");
    // Tests de tirs
    assert.equal(bateau1.pointDeVie, 3, "Erreur le bateau doit avoir 3 points de vie");
    assert.equal(mer.tirer(new Position(2, 3)), "Touché", "Erreur : tir sur un bateau doit être 'Touché'");
    assert.equal(bateau1.pointDeVie, 2, "Erreur quand on touche un bateau il doit perdre un point de vie");
    assert.equal(mer.tirer(new Position(5, 5)), "Touché", "Erreur : tir sur un bateau doit être 'Touché'");
    assert.equal(mer.tirer(new Position(0, 0)), "Dans l'eau", "Erreur : tir dans l'eau doit renvoyer 'Dans l'eau'");

    // Test de coulée
    mer.tirer(new Position(3,3)); // Touché
    assert.equal(bateau1.pointDeVie, 1, "Erreur quand on retouche un bateau il doit perdre un nouveau point de vie");
    assert.equal(mer.tirer(new Position(4, 3)), "Coulé", "Erreur le bateau devrait etre coulé"); // Touché
    assert.equal(bateau1.estCoulé(), true, "Erreur : Le bateau devrait être coulé après 3 tirs");

    console.log("✅ Tests de Mer passés avec succès !");
}

main();

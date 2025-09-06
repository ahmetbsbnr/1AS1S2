import {Point} from "./Point.ts"
import {Cercle} from "./Cercle.ts"
import {Rectangle} from "./Rectangle.ts"
import {Temps} from "./Temps.ts"
import * as TD1 from "./TD1.ts"


function testFonctions() {
    console.log("--- Début des tests ---");

    // Test Cercle et Point
    const centre = new Point();
    centre.x = 150;
    centre.y = 100;
    const cercle = new Cercle();
    cercle.centre = centre;
    cercle.rayon = 75;

    const p1 = new Point();
    p1.x = 150;
    p1.y = 100;
    console.assert(TD1.pointDansCercle(cercle, p1) === true, "Erreur: p1 devrait être dans le cercle");

    const p2 = new Point();
    p2.x = 250;
    p2.y = 100;
    console.assert(TD1.pointDansCercle(cercle, p2) === false, "Erreur: p2 ne devrait pas être dans le cercle");

    // Test Rectangle
    const coin = new Point();
    coin.x = 140;
    coin.y = 110;
    const rectangle = new Rectangle();//20, 20,coin);
    rectangle.coin = coin;
    rectangle.longueur = 20;
    rectangle.largeur = 20;
    console.assert(TD1.rectangleDansCercle(cercle, rectangle) === true, "Erreur: le rectangle devrait être dans le cercle");

    const coin2 = new Point();
    coin2.x = 300;
    coin2.y = 150;
    const rectangle2 = new Rectangle();
    rectangle2.coin = coin2;
    rectangle2.longueur = 50
    rectangle2.largeur = 50;

    console.assert(TD1.rectangleDansCercle(cercle, rectangle2) === false, "Erreur: le rectangle ne devrait pas être dans le cercle");

    console.assert(TD1.chevauchement(cercle, rectangle) === true, "Erreur: chevauchement devrait être vrai");
    console.assert(TD1.chevauchement(cercle, rectangle2) === false, "Erreur: chevauchement devrait être faux");

    // Test Temps
    const temps = new Temps();
    temps.heure = 1;
    temps.minute = 30;
    temps.second = 15;

    console.assert(TD1.temps2Number(temps) === 5415, "Erreur: conversion temps en secondes incorrecte");

    const tConverted = TD1.number2Temps(5415);
    console.assert(tConverted.heure === 1 && tConverted.minute === 30 && tConverted.second === 15, "Erreur: conversion secondes en temps incorrecte");

    const tMultiplied = TD1.multiplieTemps(temps, 2);
    console.assert(tMultiplied.heure === 3 && tMultiplied.minute === 0 && tMultiplied.second === 30, "Erreur: multiplication temps incorrecte");

    TD1.multiplie(temps, 2);
    console.assert(temps.heure === 3 && temps.minute === 0 && temps.second === 30, "Erreur: multiplication temps par référence incorrecte");

    console.log("--- Fin des tests ---");
}

testFonctions();
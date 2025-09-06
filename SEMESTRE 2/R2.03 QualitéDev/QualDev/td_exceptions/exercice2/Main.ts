import { Etudiant } from "./Etudiant.ts";
import { lireChaine } from "./Utils.ts";

const e = new Etudiant("123456789AA", "Darwin", "Charles");

console.log("cas qui marchent");
e.setINE("123456789AA");
e.setINE("1234567890A");

console.log("cas qui lèvent une exception");
try {
  console.log("chaine vide");
  e.setINE("");
} catch (error) {
  console.log(error.message);
}

try {
  console.log("10 caractères");
  e.setINE("1234567890");
} catch (error) {
  console.log(error.message);
}

try {
  console.log("12 caractères");
  e.setINE("123456789012");
} catch (error) {
  console.log(error.message);
}

try {
  console.log("11 caractères mais que des chiffres");
  e.setINE("12345678999");
} catch (error) {
  console.log(error.message);
}

try {
  console.log("11 caractères mais un chiffre final");
  e.setINE("123456789A9");
} catch (error) {
  console.log(error.message);
}

try {
  console.log("11 caractères mais une lettre dans les 9 premiers");
  e.setINE("12A456789AA");
} catch (error) {
  console.log(error.message);
}

try {
  console.log("11 caractères mais termine par un caractère ni chiffre ni lettre");
  e.setINE("123456789A:");
} catch (error) {
  console.log(error.message);
}

// Saisie tant que INE incorrect
let e2: Etudiant;
let probleme: boolean;
do {
  probleme = false;
  try {
    let ine = lireChaine("Donnez l'INE de l'étudiant : ");
    e2 = new Etudiant(ine, "Darwin", "Charles");
  } catch (e) {
    console.log(e.message);
    probleme = true;
  }
} while (probleme);

import { isDigit } from "./Utils.ts";
import { DateInvalideError } from "./exceptions/DateInvalideError.ts";
import { DateUSError } from "./exceptions/DateUSError.ts";

function extraitDate(date: string): Array<number> {
  // La date est-elle au format US ?
  let us = false;

  // Séparation en trois partie jj,mm,aaaa ou mm,jj,aaaa
  let tab = date.split("/");

  if (tab.length !== 3) {
    tab = date.split("-");
    if (tab.length === 3) {
      us = true;
    } else {
      throw new DateInvalideError("La date doit être au format jj/mm/aaaa");
    }
  }

  // Conversion en entiers
  // Il faut tester caractère par caractère,
  // car Number.parseInt("20x4") donne 20
  const iTab = new Array<number>();
  for (const s of tab) {
    for (const car of s) {
      if (!isDigit(car)) {
        throw new DateInvalideError("La date doit être au format jj/mm/aaaa");
      }
    }
    iTab.push(Number.parseInt(s));
  }

  // Création de variable pour tester les jours et les mois
  // Selon le format de la date (EU ou US)
  let iJour = 0;
  let iMois = 1;
  if (us) {
    iJour = 1;
    iMois = 0;
  }
  if (iTab[iJour] < 1 || iTab[iJour] > 31) {
    throw new DateInvalideError("les jours sont entre 1 et 31");
  }
  if (iTab[iMois] < 1 || iTab[iMois] > 12) {
    throw new DateInvalideError("les mois sont entre 1 et 12");
  }

  if (us) {
    throw new DateUSError();
  }
  return iTab;
}

// Fonction pour tester les dates et attraper les erreurs
// pour que le programme ne s'arrête pas
function testeDate(date: string): void {
  console.log("Date testée : " + date);

  try {
    console.log(extraitDate(date));
  } catch (e) {
    console.log(e.message);
  }
}

console.log("\nTests qui marchent");
testeDate("01/03/2024");
testeDate("1/03/2024");
testeDate("01/3/2024");
testeDate("01/03/24");
testeDate("1/3/24");

console.log("\nTests qui lèvent des exceptions");
testeDate("");
testeDate("xxx");
testeDate("x1/12/2024");
testeDate("1x/12/2024");
testeDate("01/x2/2024");
testeDate("01/12/20x2");
testeDate("01/03/2024/");
testeDate("01/03/2024/2024");
testeDate("01/13/2024");
testeDate("33/11/2024");
testeDate("-1/11/2024");
testeDate("31/-1/2024");

console.log("\nTests qui lèvent des exceptions sur une date presqu'US");
testeDate("13-11-2024");
testeDate("x-x-x");

console.log("\nTest qui lève une exception DateUSError");
testeDate("11-13-2024");

console.log("\nEt ça, ça doir marcher ?");
testeDate("11/12/-2024");

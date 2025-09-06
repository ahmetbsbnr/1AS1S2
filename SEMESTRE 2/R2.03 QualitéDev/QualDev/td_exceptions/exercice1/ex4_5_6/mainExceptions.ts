import { NomEtPrenomVideError } from "./exceptions/NomEtPrenomVideError.ts";
import { NomVideError } from "./exceptions/NomVideError.ts";
import { PrenomVideError } from "./exceptions/PrenomVide.ts";

function creeInitiales(nom: string, prenom: string): string {
  
  // On supprime les espaces en début et en fin de chaîne, pour 
  // interdire "   " comme ""
  nom = nom.trim();
  prenom = prenom.trim();
  if (nom==="" && prenom==="") {
    throw new NomEtPrenomVideError("Le nom et le prénom doivent être renseignés");
  }
  if (prenom==="") {
    throw new PrenomVideError("Le prénom doit être renseigné");
  }
  if (nom==="") {
    throw new NomVideError("Le nom doit être renseigné");
  }

  return nom[0].toUpperCase() + prenom[0].toUpperCase();
}

let ini = creeInitiales("Darwin", "Charles");
console.log(ini);

try {
  ini = creeInitiales("", "Charles");
  console.log(ini);
} catch (e) {
    if (e instanceof NomEtPrenomVideError) {
        console.log(e.message);
    } else if (e instanceof PrenomVideError) {
        console.log(e.message);
    } else if (e instanceof NomVideError) {
        console.log(e.message);
    }
}


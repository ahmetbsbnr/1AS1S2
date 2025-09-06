import { IdentiteError } from "./IdentiteError.ts";

function creeInitiales(nom: string, prenom: string): string {
  
  // On supprime les espaces en début et en fin de chaîne, pour 
  // interdire "   " comme ""
  nom = nom.trim();
  prenom = prenom.trim();
  if (nom==="" && prenom==="") {
    throw new IdentiteError("Le nom et le prénom doivent être renseignés");
  }
  if (prenom==="") {
    throw new IdentiteError("Le prénom doit être renseigné");
  }
  if (nom==="") {
    throw new IdentiteError("Le nom doit être renseigné");
  }

  return nom[0].toUpperCase() + prenom[0].toUpperCase();
}

let ini = creeInitiales("Darwin", "Charles");
console.log(ini);

try {
  ini = creeInitiales("", "Charles");
  console.log(ini);
} catch (e) {
    if (e instanceof IdentiteError) {
        console.log(e.message);
    } else {
      console.log("Erreur innatendue : " + e.message);
    }
}


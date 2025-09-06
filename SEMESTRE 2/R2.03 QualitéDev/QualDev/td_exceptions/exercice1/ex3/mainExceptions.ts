function creeInitiales(nom: string, prenom: string): string {
  
  // On supprime les espaces en début et en fin de chaîne, pour 
  // interdire "   " comme ""
  nom = nom.trim();
  prenom = prenom.trim();
  if (nom==="" || prenom==="") {
    throw new Error("Le prénom et le nom doivent être renseignés");
  }
  return nom[0].toUpperCase() + prenom[0].toUpperCase();
}

let ini = creeInitiales("Darwin", "Charles");
console.log(ini);

ini = creeInitiales("   ", "");
console.log(ini);



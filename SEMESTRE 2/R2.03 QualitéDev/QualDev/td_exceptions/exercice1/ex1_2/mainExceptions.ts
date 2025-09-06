function creeInitiales(nom: string, prenom: string): string {
  return nom[0].toUpperCase() + prenom[0].toUpperCase();
}

let ini = creeInitiales("Darwin", "Charles");
console.log(ini);

ini = creeInitiales("", "");
console.log(ini);

// On obtient une exception de type : TypeError
// Le message est : Cannot read properties of undefined (reading 'toUpperCase')


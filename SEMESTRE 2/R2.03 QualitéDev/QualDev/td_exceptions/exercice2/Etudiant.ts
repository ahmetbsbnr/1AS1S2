import { INEError } from "./INEError.ts";
import { isLetter } from "./Utils.ts";

export class Etudiant {
  private _ine!: string;
  private _nom: string;
  private _prenom: string;

  public constructor(ine: string, nom: string, prenom: string) {
    this.setINE(ine);
    this._nom = nom;
    this._prenom = prenom;
  }

  public setINE(ine: string): void {
    if (ine.length !== 11) {
      throw new INEError("L'INE doit contenir 11 caractères");
    }

    for (let i = 0; i < 9; i++) {
      if (Number.isNaN(Number.parseInt(ine[i]))) {
        throw new INEError("Les 9 premiers caractères doivent être des chiffres");
      }
    }
    const cas1 = isLetter(ine[9]) && isLetter(ine[10]);
    if (!cas1) {
      const cas2 = Number.isInteger(Number.parseInt(ine[9])) && isLetter(ine[10]);
      if (!cas2) {
        throw new INEError("INE : 9 chiffres + 2 lettres OU 10 chiffres + 1 lettre");
      }
    }
    this._ine = ine;
  }
}

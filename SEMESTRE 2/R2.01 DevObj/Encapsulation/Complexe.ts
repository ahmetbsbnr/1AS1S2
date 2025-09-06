class Complexe {
    private _partieReelle!: number;
    private _partieImaginaire!: number;
    private static compteurInstances: number = 0;

    constructor(partieReelle: number = 0, partieImaginaire: number = 0) {
        this.partieReelle = partieReelle;
        this.partieImaginaire = partieImaginaire;
        Complexe.compteurInstances++;
    }

    get partieReelle(): number {
        return this._partieReelle;
    }

    set partieReelle(val: number) {
        this._partieReelle = val;
    }

    get partieImaginaire(): number {
        return this._partieImaginaire;
    }

    set partieImaginaire(val: number) {
        this._partieImaginaire = val;
    }

    module(): number {
        return Math.sqrt(this.partieReelle ** 2 + this.partieImaginaire ** 2);
    }

    afficher(): void {
        console.log(this.partieReelle +", "+this.partieImaginaire+ "i");
    }

    static getCompteurInstances(): number {
        return Complexe.compteurInstances;
    }
}

// Test des fonctionnalités
const c1 = new Complexe();
c1.afficher();
console.log("Module:", c1.module());

const c2 = new Complexe(3, 4);
c2.afficher();
console.log("Module:", c2.module());

console.log("Nombre d'instances créées:", Complexe.getCompteurInstances());

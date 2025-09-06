import * as readline from "readline-sync";

function estADN(seq: string): boolean {
  for (let c of seq) {
    if (c !== "A" && c !== "C" && c !== "G" && c !== "T") {
      return false;
    }
  }

  return true;
}

function transcrit(seqADN: string): string {
  let seqARN = "";

  for (let c of seqADN) {
    if (c === "T") seqARN += "U";
    else seqARN += c;
  }

  return seqARN;
}

function baseComplémentaire(base: string): string {
  if (base === "A") return "T";
  else if (base === "T") return "A";
  else if (base === "C") return "G";
  else if (base === "G") return "C";
  else return "";
}

function séquenceComplémentaireInversée(seq: string): string {
  let seqInv = "";

  for (let c of seq) {
    seqInv = baseComplémentaire(c) + seqInv;
  }

  return seqInv;
}

function estCodon(codon: string, seq: string, indice: number): boolean {
  return seq[indice] === codon[0] && seq[indice + 1] === codon[1] && seq[indice + 2] === codon[2];
}

function nombreOccurencesCodon(codon: string, seq: string): number {
  let nbOcc = 0;

  for (let i = 0; i < seq.length; i += 3) {
    if (estCodon(codon, seq, i)) nbOcc++;
  }

  return nbOcc;
}

function main(): void {
  let seqADN = readline.question("Entrez une séquence d'ADN: ");

  if (estADN(seqADN)) {
    let codon = readline.question("Entrez un codon: ");

    console.log("Séquence complémentaire inversée: " + séquenceComplémentaireInversée(seqADN));
    let seqARN = transcrit(seqADN);
    console.log("Séquence ARN: " + seqARN);
    console.log(
      `Le codon ${codon} apparaît ${nombreOccurencesCodon(
        codon,
        seqARN
      )} fois dans la séquence ARN.`
    );
  } else {
    console.log("Séquence ADN erronée !!!");
  }
}

main();

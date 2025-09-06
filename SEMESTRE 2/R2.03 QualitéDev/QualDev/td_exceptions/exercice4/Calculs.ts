import { ArithmeticError } from "./exceptions/ArithmeticError.ts";
import { OperatorError } from "./exceptions/OperatorError.ts";

function calcule(
  tableau: Array<number>,
  indice: number,
  operateur: string,
  operande: number
): number {
  if (indice < 0 || indice >= tableau.length) {
    throw new RangeError("Indice invalide");
  }

  switch (operateur) {
    case "+":
      return tableau[indice] + operande;
    case "-":
      return tableau[indice] - operande;
    case "*":
      return tableau[indice] * operande;
    case "/":
      if (operande === 0) {
        throw new ArithmeticError("Division par zéro");
      }
      return tableau[indice] / operande;
    default:
      throw new OperatorError("Opérateur inconnu");
  }
}

try {
  console.log(calcule([1, 2, 3], 1, "+", 4));
  console.log(calcule([1, 2, 3], 2, "/", 0));
} catch (e) {
  console.log(e.message);
}

try {
  console.log(calcule([1, 2, 3], 8, "-", 5));
} catch (e) {
  console.log(e.message);
}

try {
  console.log(calcule([1, 2, 3], 2, "addition", 10));
} catch (e) {
  console.log(e.message);
}

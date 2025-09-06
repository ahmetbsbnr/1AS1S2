export function isLetter(c: string): boolean {
  c = c.toUpperCase();
  return c >= "A" && c <= "Z";
}

export function lireChaine(message = "Saisir une chaîne : "): string {
  let s: string | null;
  do {
    s = prompt(message);
  } while (s == null);
  return s;
}

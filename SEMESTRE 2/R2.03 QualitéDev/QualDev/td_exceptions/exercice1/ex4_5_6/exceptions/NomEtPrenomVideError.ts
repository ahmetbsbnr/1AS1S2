export class NomEtPrenomVideError extends Error {
  constructor(message : string) {
    super(message);
    this.name = "NomEtPrenomVideError";
  }
}
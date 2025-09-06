export class NomVideError extends Error {
  constructor(message : string) {
    super(message);
    this.name = "NomVideError";
  }
}
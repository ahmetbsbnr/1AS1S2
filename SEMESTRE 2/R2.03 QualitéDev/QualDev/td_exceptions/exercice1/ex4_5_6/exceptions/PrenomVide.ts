export class PrenomVideError extends Error {
  constructor(message : string) {
    super(message);
    this.name = "PrenomVideError";
  }
}
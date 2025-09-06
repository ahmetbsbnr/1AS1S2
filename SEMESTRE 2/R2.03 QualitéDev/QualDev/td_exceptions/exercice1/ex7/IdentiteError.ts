export class IdentiteError extends Error {
  constructor(message : string) {
    super(message);
    this.name = "IdentiteError";
  }
}
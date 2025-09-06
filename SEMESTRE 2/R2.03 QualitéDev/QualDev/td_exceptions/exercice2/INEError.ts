export class INEError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "INEError";
  }
}

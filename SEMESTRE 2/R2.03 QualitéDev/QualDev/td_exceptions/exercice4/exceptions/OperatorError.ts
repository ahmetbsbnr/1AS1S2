export class OperatorError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "OperatorError";
  }
}

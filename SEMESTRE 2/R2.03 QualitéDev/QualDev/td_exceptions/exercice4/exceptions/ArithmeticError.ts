export class ArithmeticError extends Error {
  constructor(message: string) {
    super(message);
    this.name = "ArithmeticError";
  }
}

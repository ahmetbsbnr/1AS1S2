export class DateInvalideError extends Error {
  constructor(message = "La date n'est pas au bon format") {
    super(message);
    this.name = "DateInvalideError";
  }
}

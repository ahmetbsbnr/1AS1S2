export class DateUSError extends Error {
  constructor(message = "La date est au format US") {
    super(message);
    this.name = "DateUSError";
  }
}

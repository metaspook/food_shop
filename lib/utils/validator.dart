class Validator {
  static isEmpty(String? value) {
    value == null || value.isEmpty ? "This field can't be empty" : null;
  }
}

class Validations {
  static bool upperCase(String value) {
    String pattern = r'^(?=.*?[A-Z])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  static bool lowerCase(String value) {
    String pattern = r'^(?=.*?[a-z])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  static bool hasNumber(String value) {
    String pattern = r'^(?=.*?[0-9])';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
}

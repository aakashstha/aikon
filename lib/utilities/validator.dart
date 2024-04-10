class Validator {
  static String? validateEmpty(String value, String title) {
    return value.isEmpty ? "$title is required" : null;
  }

  static String? validateUsername(String value) {
    if (value.isEmpty) return "Username is required";
    if (!RegExp(r"^[a-zA-Z]+(\.[a-zA-Z]+)?$").hasMatch(value)) {
      return "Username should only be characters and dot(.)";
    }
    return null;
  }
}

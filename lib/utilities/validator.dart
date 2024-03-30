class Validator {
  static String? validateEmpty(String value, String title) {
    return value.isEmpty ? "$title is required" : null;
  }

  static String? validateEmail(String value, String title) {
    if (value.isEmpty) return "$title is required";
    if (!RegExp(r"^[\w%\+\-]+(\.[\w%\+\-]+)*@[\w%\+\-]+(\.[\w%\+\-]+)+$")
        .hasMatch(value)) return "Enter a valid email address";
    return null;
  }
}

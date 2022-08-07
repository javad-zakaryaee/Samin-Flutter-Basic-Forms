String? emailValidator(String? value) {
  if (value == null ||
      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
    return 'Enter a valid email';
  } else {
    return null;
  }
}

String? passworValidator(String? value) {
  if (value == null || value.length < 8) {
    return 'Password cant be less than 8 characters';
  } else {
    return null;
  }
}

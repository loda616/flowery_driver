class Validators {
  static String? validateName(String? value) {
    if (_isEmpty(value)) {
      return ("Name is required");
    }
    return null;
  }

  static String? validateNotEmpty({String? title, String? value}) {
    if (_isEmpty(value)) {
      return ("$title is required");
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (_isEmpty(value)) {
      return ("Email is required");
    }
    var regex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

    if (!regex.hasMatch(value!)) {
      return 'Invalid email address';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (_isEmpty(value)) {
      return 'Password is required';
    }

    var regex = RegExp(
        r"(?=^.{8,}$)(?=.*[!@#$%^&*]+)(?![.\\n])(?=.*[A-Z])(?=.*[a-z])(?=.*\d).*$");

    if (!regex.hasMatch(value!)) {
      return 'Must contains A-Z, a-z, @-#-&.. , 1-9';
    }

    return null;
  }

  static String? validatePasswordConfirmation({
    String? password,
    String? confirmPassword,
  }) {
    if (_isEmpty(confirmPassword)) {
      return ("Confirm Password is required");
    }

    if (password != confirmPassword) {
      return 'Passwords does not match';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if (_isEmpty(value)) {
      return 'Phone Number is required';
    }
    value = value!.replaceAll(RegExp(r'[^\d+]'), '');
    var regex = RegExp(
      r"^\+201[0125]\d{8}$",
    );
    if (!regex.hasMatch(value)) {
      return "Must be 11 digits starting with (+20)";
    }
    return null;
  }
  static bool _isEmpty(String? value) {
    return value == null || value.trim().isEmpty;
  }

  static String? validateNationalId(String? value) {
    if (_isEmpty(value)) {
      return 'National ID is required';
    }
    var regex = RegExp(r'^\d{14}$');

    if (!regex.hasMatch(value!)) {
      return "National ID must be 14 digits";
    }
    String firstTwoDigits = value.substring(0, 2);
    if (int.parse(firstTwoDigits) < 01 || int.parse(firstTwoDigits) > 31) {
      return "Invalid birth date in ID";
    }

    return null;
  }
}

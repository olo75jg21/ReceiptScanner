import 'package:mobile/core/constant/app_text.dart';

class Validator {
  static String? email(String? value) {
    if (value == null || value.isEmpty) return AppText.notEmptyField;
    if (RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$')
        .hasMatch(value)) return null;
    return AppText.invalidEmail;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) return AppText.notEmptyField;
    if (RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$&*]).{8,32}$')
        .hasMatch(value)) return null;
    return AppText.invalidPassword;
  }

  static String? passwordConfirm(String? value1, String? value2) {
    if (value1 == null || value1.isEmpty) return AppText.notEmptyField;
    if (value1 == value2) return null;
    return AppText.invalidConfirmPassword;
  }
}

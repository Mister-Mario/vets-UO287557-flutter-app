import 'base_validator.dart';

class UserValidator {
  static String? validateEmail(String? value) {
    final emptyCheck = BaseValidator.isNotEmpty(value, 'email');
    if (emptyCheck != null) return emptyCheck;

    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(value!)) {
      return 'Introduce un formato de email válido';
    }
    return null;
  }

  static String? validatePhone(String? value) {
    final emptyCheck = BaseValidator.isNotEmpty(value, 'telefono');
    if (emptyCheck != null) return emptyCheck;

    final phoneRegExp = RegExp(r'^\d{3}-\d{3}-\d{3}-\d{3}$');
    if (!phoneRegExp.hasMatch(value!)) {
      return 'El formato debe ser 999-999-999-999';
    }
    return null;
  }

  static String? validateName(String? value) {
    final emptyError = BaseValidator.isNotEmpty(value, 'nombre');
    if (emptyError != null) return emptyError;

    final lettersError = BaseValidator.validateOnlyLetters(value, 'nombre');
    if (lettersError != null) return lettersError;

    return BaseValidator.validateLength(value, 'nombre');
  }

  static String? validateSurname(String? value) {
    final emptyError = BaseValidator.isNotEmpty(value, 'apellidos');
    if (emptyError != null) return emptyError;

    final lettersError = BaseValidator.validateOnlyLetters(value, 'apellidos');
    if (lettersError != null) return lettersError;

    return BaseValidator.validateLength(value, 'apellidos');
  }
}

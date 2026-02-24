class BaseValidator {
  /// Valida que el texto tenga una longitud mínima y máxima
  static String? validateLength(
    String? value,
    String fieldName, {
    int min = 2,
    int max = 50,
  }) {
    if (value!.length < min) {
      return '$fieldName debe tener al menos $min caracteres';
    }
    if (value.length > max) {
      return '$fieldName no puede exceder los $max caracteres';
    }
    return null;
  }

  /// Valida que el texto solo contenga letras (sin números ni símbolos extraños)
  static String? validateOnlyLetters(String? value, String fieldName) {
    // Esta expresión regular permite letras de la A a la Z, espacios y tildes
    final nameRegExp = RegExp(r"^[a-zA-Z]+$");

    if (!nameRegExp.hasMatch(value!)) {
      return 'El $fieldName no puede contener números o símbolos';
    }
    return null;
  }

  // Validación genérica para campos obligatorios
  static String? isNotEmpty(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'por favor digite el $fieldName';
    }
    return null;
  }
}

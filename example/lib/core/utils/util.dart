class Util {
  static bool isNull(dynamic value) {
    if (value == null) return true;

    return false;
  }

  static bool isNullOrEmpty(dynamic value) {
    if (isNull(value)) return true;

    if (value is String && value.isEmpty) {
      return true;
    }

    return false;
  }
}
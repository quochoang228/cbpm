enum NumberType {
  number,
  text,
}

extension NumberTypeExtension on NumberType {
  static NumberType? fromString(String? type) {
    if ((type ?? '').isNotEmpty) {
      switch (type) {
        case "number":
        case "NUMBER":
          return NumberType.number;
        case "text":
        case "TEXT":
          return NumberType.text;
        default:
          return null;
      }
    }
    return null;
  }
}

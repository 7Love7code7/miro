class PasswordUtils {
  static String fillToLength({required String text, required int length, String symbol = '0'}) {
    String newText = text;
    while (newText.length < length) {
      newText = symbol + newText;
    }
    return newText;
  }
}

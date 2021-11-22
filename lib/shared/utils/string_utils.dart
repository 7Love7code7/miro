class StringUtils {
  static String fillFileToLength({required String text, required int size, String symbol = '0'}) {
    String newText = text;
    while (newText.length < size) {
      newText = symbol + newText;
    }
    return newText;
  }
}

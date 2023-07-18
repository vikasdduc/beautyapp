List<String> convertHtmlToString(String data) {
  return data
      .replaceAllMapped(
        RegExp(r"(<([^>]+)>)", caseSensitive: false),
        (Match m) => "",
      )
      .replaceAllMapped(
        RegExp(r"(?:\r\n|\r|\n)", caseSensitive: true),
        (Match m) => "",
      )
      .replaceAllMapped(
        RegExp(r"(?:&nbsp;)", caseSensitive: true),
        (Match m) => "",
      )
      .replaceAllMapped(
        RegExp(r"&amp;", caseSensitive: true),
        (Match m) => "&",
      )
      .split('.');
}

class Utils {
  static Utils? _instance;
  // Avoid self instance
  Utils._();
  static Utils get instance => _instance ??= Utils._();

  static String FormatterDescription(String text) {
    final item = text
        .replaceAll(
            "<div class=\"flex flex-grow flex-col gap-3 max-w-full\">\r\n<div class=\"min-h-[20px] flex flex-col items-start gap-3 whitespace-pre-wrap break-words overflow-x-auto\">\r\n<div class=\"markdown prose w-full break-words dark:prose-invert dark\">\r\n<p>",
            "")
        .replaceAll("</p>\r\n</div>\r\n</div>\r\n</div>\r\n", "")
        .replaceAll("<p>", "")
        .replaceAll("</p>", "");

    return item;
  }
}

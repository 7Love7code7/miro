import 'dart:html' as html;

// ignore_for_file: unsafe_html
class BrowserUtils {
  static void download(List<int> bytes, String name) {
    final html.Blob blob = html.Blob(bytes);
    final String url = html.Url.createObjectUrlFromBlob(blob);
    final html.AnchorElement anchor = html.document.createElement('a') as html.AnchorElement
      ..href = url
      ..style.display = 'none'
      ..download = name;
    html.document.body!.children.add(anchor);

    // download
    anchor.click();

    // cleanup
    html.document.body!.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  }
}

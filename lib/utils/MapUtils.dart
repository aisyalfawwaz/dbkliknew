import 'package:url_launcher/url_launcher_string.dart';

class MapUtils {
  MapUtils._();

  static Future<void> openMap(String st) async {
    String url = '';
    if (st == 'surabaya') {
      url = 'https://maps.app.goo.gl/ADCoRR5KBE9j8qB2A';
    } else if (st == 'jakarta') {
      url = 'https://maps.app.goo.gl/YBicpZCDp9ZCALCG8';
    } else if (st == 'semarang') {
      url = 'https://maps.app.goo.gl/2YqvocwRRq33oVrt6';
    } else if (st == 'bali') {
      url = 'https://maps.app.goo.gl/k13LovbtK9snAdq57';
    } else if (st == 'yogyakarta') {
      url = 'https://maps.app.goo.gl/GSmqu4BAQKrfBhEP8';
    } else if (st == 'Malang') {
      url = 'https://maps.app.goo.gl/rH469uXNoYtS2w1v6';
    }

    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      throw 'Could not open the map.';
    }
  }
}

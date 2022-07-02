// ignore: unnecessary_import
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

void launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }
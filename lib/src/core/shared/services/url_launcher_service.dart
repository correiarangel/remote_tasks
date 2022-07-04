import 'package:url_launcher/url_launcher.dart';

abstract class IUrlLauncher {
  Future<dynamic> launchInBrowser(String url);
}

class UrlLauncherSevice extends IUrlLauncher {
  @override
  Future<dynamic> launchInBrowser(String url) async {
    //final Uri uri = Uri.file(url);

    bool resp = await launch(url);
    if (!resp) return Exception('Could not launch $url');
    return resp;
  }
}

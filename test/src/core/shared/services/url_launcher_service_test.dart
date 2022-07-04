import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote_tasks/src/core/shared/services/url_launcher_service.dart';

class UrlLauncherSeviceMock extends Mock implements IUrlLauncher {}

void main() {
  late IUrlLauncher launcher;
  setUp(() {
    launcher = UrlLauncherSeviceMock();
  });
  test('url launcher service completer...', () async {
    const uri = 'https://google.com.br';
    when(() => launcher.launchInBrowser(uri))
        .thenAnswer((_) async => true);

    final result = await launcher.launchInBrowser(uri);
    expect(result, isA<bool>());
    expect(result, true);
  });

    test('url launcher service error...', () async {
      const uri = 'https://g';
    when(() => launcher.launchInBrowser(uri))
        .thenAnswer((_)  async => Exception('Could not launch $uri',));

    final result = await launcher.launchInBrowser(uri);
    expect(result, isA<Exception>());
    
  });
}

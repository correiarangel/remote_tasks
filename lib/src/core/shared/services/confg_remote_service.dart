import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

const urlDefault =
    'https://www.youtube.com/watch?v=R84AGg0lKs8&list=PLjxrf2q8roU23XGwz3Km7sQZFTdB996iG&index=2';

abstract class IRemoteConfg extends ChangeNotifier {
  // ignore: unused_element
  Future<bool> _initializeRemoteConfig();
  // ignore: unused_element
  Future<void> fetchRemoteConfig();
    // ignore: unused_element
    Future<void> _setConfig();
}

class RemoteConfgService extends IRemoteConfg {
  static FirebaseRemoteConfig? _remoteConfig;
  RemoteConfgService() {
    _initializeRemoteConfig();
  }
  bool _isLoading = true;
  Color? _color = const Color.fromARGB(50, 233, 6, 146);
  String _url = urlDefault;
  String _name = 'Remote App';

  Color? get color => _color;
  bool get isLoading => _isLoading;
  String get url => _url;
  String get name => _name;

  @override
  Future<bool> _initializeRemoteConfig() async {
    if (_remoteConfig == null) {
      _remoteConfig = FirebaseRemoteConfig.instance;
      notifyListeners();
      final Map<String, dynamic> defaults = <String, dynamic>{
        'new_color_enabled': false,
        'new_endpoint_enabled': urlDefault,
        'new_name_enabled': 'Home App Remoto'
      };
      await _remoteConfig!.setDefaults(defaults);

      await _remoteConfig!.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 1),
      ));

      await fetchRemoteConfig();
    }
    notifyListeners();
    return _isLoading = false;
  }

  @override
  Future<void> fetchRemoteConfig() async {
    try {
      await _remoteConfig!.fetch();
      await _remoteConfig!.fetchAndActivate();

      debugPrint(
          'Last fetch status: ${_remoteConfig!.lastFetchStatus.toString()}');
      debugPrint('Last fetch time: ${_remoteConfig!.lastFetchTime.toString()}');
      debugPrint(
          'New color enabled?: ${_remoteConfig!.getBool('new_color_enabled').toString()}');
      debugPrint(
          'New endpoit enabled?: ${_remoteConfig!.getString('new_endpoint_enabled').toString()}');
      debugPrint(
          'New endpoit enabled?: ${_remoteConfig!.getString('new_name_enabled').toString()}');
      _setConfig();
    } catch (e) {
      debugPrint('Error: ${e.toString()}');
    }
  }

    @override
      Future<void>  _setConfig()async {
    final isEnable = _remoteConfig!.getBool('new_color_enabled');
    if (isEnable) {
      _color = Colors.purple;
      _name = _remoteConfig!.getString('new_name_enabled').toString();
      _url = _remoteConfig!.getString('new_endpoint_enabled').toString();
      notifyListeners();
    } else {
      _color = Colors.pink;
      _name = 'Remote App';
      _url = urlDefault;
      notifyListeners();
    }
  }
}

import 'package:flutter/material.dart';
import '../core/shared/services/confg_remote_service.dart';
import '../core/shared/services/url_launcher_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late RemoteConfgService _config;
  final lauch = UrlLauncherSevice();
  @override
  void initState() {
    super.initState();
    _config = RemoteConfgService();
    _config.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _config.isLoading
          ? AppBar(
              backgroundColor: const Color.fromARGB(50, 233, 6, 146),
            )
          : AppBar(
              title: Text(_config.name),
              backgroundColor: _config.color,
            ),
      body: _config.isLoading
          ? Center(
              child: CircularProgressIndicator(
                color:Colors.deepPurpleAccent ,
                backgroundColor: _config.color,
              ),
            )
          : SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _config.name,
                    style: TextStyle(color: _config.color, fontSize: 24),
                  ),
                  const SizedBox(height: 18.0),
                  OutlinedButton(
                    onPressed: () => _config.fetchRemoteConfig(),
                    child: Text(
                      'Refresh',
                      style: TextStyle(
                        color: _config.color,
                      ),
                    ),
                  ),
                  const SizedBox(height: 18.0),
                  OutlinedButton(
                    onPressed: () async {
                      debugPrint(_config.url);
                      await lauch.launchInBrowser(_config.url);
                    },
                    child: Text(
                      'Navigator',
                      style: TextStyle(
                        color: _config.color,
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

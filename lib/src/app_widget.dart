import 'package:flutter/material.dart';
import 'package:remote_tasks/src/home/home_pege.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'RandelDev Flutter Remote App',
      home: HomePage(),
    );
  }
}

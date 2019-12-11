import 'package:extremecore/view/_debug/debug.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core.dart';

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await autoLogin();
  runApp(MyApp());
}

Future autoLogin() async {
  ExtremeCore().init();
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saji Apps',
      navigatorKey: key,
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DebugPage(),
    );
  }
}

import 'package:band_names/pages/home.dart';
import 'package:band_names/pages/status.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: 'status',
      routes: {
        'home': (_) => HomePage(),
        'status': (_) => StatusPage(),
      },
    );
  }
}

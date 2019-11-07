import 'package:flutter/material.dart';
import 'package:weather_app/getting_location.dart';

import 'homepage.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
       primarySwatch: Colors.red,

      ),
      home: GetLocation(),
    );
  }
}

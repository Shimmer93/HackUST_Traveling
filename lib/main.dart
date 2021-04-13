import 'package:flutter/material.dart';
import 'package:hackust_traveling/navigator/bottom_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FancyTrip',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
      debugShowCheckedModeBanner: false,
    );
  }
}

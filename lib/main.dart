import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hackust_traveling/navigator/bottom_navigator.dart';
import 'globals.dart' as globals;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  globals.camera = cameras.first;

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

import 'package:flutter/material.dart';
import 'package:hackust_traveling/navigator/bottom_navigator.dart';

void main() {
  runApp(MyApp());
}

class MyCleanApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
            appBar: AppBar(
              // bottom: ,
              title: Text('Tabs Demo'),
            ),
            body: TabBarView(
              children: [
                Icon(Icons.directions_car),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
            bottomNavigationBar: Container(
              color: Color(0xFF3F5AA6),
              child: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.add), text: 'New'),
                  Tab(icon: Icon(Icons.directions_transit)),
                  Tab(icon: Icon(Icons.directions_bike)),
                ],
              ),
            )),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TabNavigator(),
    );
  }
}

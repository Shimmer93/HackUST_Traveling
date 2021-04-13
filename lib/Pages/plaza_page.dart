import 'package:flutter/material.dart';
import 'package:hackust_traveling/Pages/create_new_travel.dart';

class Plaza extends StatefulWidget {
  @override
  _PlazaState createState() => _PlazaState();
}

class _PlazaState extends State<Plaza> {
  @override
  Widget build(BuildContext context) {
    return NewTravelPlanScreen();
    // return Scaffold(
    //   floatingActionButton: FloatingActionButton(
    //       onPressed: _showNewTravelPlanScreen,
    //       child: Icon(Icons.add_a_photo),
    //       backgroundColor: Colors.blue),
    // );
  }

  void _showNewTravelPlanScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewTravelPlanScreen()),
    );
  }
}

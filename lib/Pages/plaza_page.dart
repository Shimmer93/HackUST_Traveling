import 'package:flutter/material.dart';
import 'package:hackust_traveling/Pages/plan_new_trip.dart';

class Plaza extends StatefulWidget {
  @override
  _PlazaState createState() => _PlazaState();
}

class _PlazaState extends State<Plaza> {
  @override
  Widget build(BuildContext context) {
    // return PlanNewTripScreen();
    return Scaffold(
      body: Container(
        width: 50,
        height: 50,
        color: Colors.amber.shade100,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: _showNewTravelPlanScreen,
          child: Icon(Icons.add_road_rounded),
          backgroundColor: Colors.blue),
    );
  }

  void _showNewTravelPlanScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlanNewTripScreen()),
    );
  }
}

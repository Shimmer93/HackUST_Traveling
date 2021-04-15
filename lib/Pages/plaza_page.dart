import 'package:flutter/material.dart';
import 'package:hackust_traveling/Pages/plan_new_trip.dart';
import 'package:hackust_traveling/Pages/shengdi_page.dart';
import 'package:hackust_traveling/Pages/travel_page.dart';
import 'package:hackust_traveling/Pages/form_group.dart';

class Plaza extends StatefulWidget {
  @override
  _PlazaState createState() => _PlazaState();
}

class _PlazaState extends State<Plaza> {
    final GlobalKey<ScaffoldState> _scaffoldKey = new  GlobalKey();

  @override
  Widget build(BuildContext context) {
    // return PlanNewTripScreen();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState.openDrawer();
              },
              icon: Container(
                child:CircleAvatar(
                  radius: 20,
                  backgroundImage:NetworkImage(
                    'https://img.xiaohongshu.com/avatar/5b5d931b14de412246d05364.jpg@80w_80h_90q_1e_1c_1x.jpg',
  //                  scale: 0.4,
                  ),
              ),
            ),
            ),
            centerTitle: true,
            title: Text('Main Page'),
            bottom: TabBar(
                unselectedLabelColor: Colors.white54,
                indicatorColor: Colors.white,
                tabs: [
                  Tab(
                    text: 'Subscriptions',
                  ),
                  Tab(
                    text: 'Explore',
                  ),
                  Tab(
                    text: 'Group',
                  ),
                ]),
        
        ),
        body: TabBarView(
            children: <Widget>[
              TravelPage(),
              TravelPage(),
              FormGroupPage()
            ],
          // color: Colors.amber.shade100,
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: _showNewTravelPlanScreen,
          child: Icon(Icons.add_road_rounded),
          backgroundColor: Colors.blue),
        ),
    );

  }

  void _showNewTravelPlanScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PlanNewTripScreen()),
    );
  }
}

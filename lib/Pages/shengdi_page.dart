import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShengdiPage extends StatefulWidget {
  @override
  State<ShengdiPage> createState() => ShengdiPageState();
}

class ShengdiPageState extends State<ShengdiPage> {

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kHKUST = CameraPosition(
    target: LatLng(22.336723798600985, 114.26543382416752),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kHKUST,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
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
  
  static final Set<Marker> _markers = Set();
  static final InfoWindow _infoWindow = InfoWindow(title: "Robomaster", snippet: "Robomaster");

  @override
  Widget build(BuildContext context) {
    _markers.add(Marker(markerId: MarkerId("Robotmaster"), position: LatLng(22.336723798600985, 114.26543382416752), infoWindow: _infoWindow));
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kHKUST,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
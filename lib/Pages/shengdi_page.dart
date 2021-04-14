import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hackust_traveling/Pages/shengdi_detail.dart';
import 'package:hackust_traveling/Pages/shengdi_data.dart';

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

  Future<void> _displayDetail(ShengdiInfo info) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ShengdiDetailPage(info)),
    );
  }

  Marker _createMarker(ShengdiInfo info){
    return Marker(markerId: MarkerId(info.title), position: info.latLng, consumeTapEvents: true, onTap: (){_displayDetail(info);});
  }

  @override
  Widget build(BuildContext context) {
    _markers.add(_createMarker(shengdiData[0]));
    _markers.add(_createMarker(shengdiData[1]));
    _markers.add(_createMarker(shengdiData[2]));
    _markers.add(_createMarker(shengdiData[3]));
    _markers.add(_createMarker(shengdiData[4]));
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
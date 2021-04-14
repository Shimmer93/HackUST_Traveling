import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ShengdiInfo {
  LatLng latLng;
  String title;
  String subtitle;
  String imgName;

  ShengdiInfo(LatLng latLng, String title, String subtitle, String imgName) {
    this.latLng = latLng;
    this.title = title;
    this.subtitle = subtitle;
    this.imgName = imgName;
  }
}

final List<ShengdiInfo> shengdiData = [
  ShengdiInfo(LatLng(22.336723798600985, 114.26543382416752), "HKUST",
      "Robomaster", "robomaster.jpg"),
  ShengdiInfo(LatLng(22.2856424, 114.147975), "Pak Shing Temple",
      "Cardcaptor Sakura", "sakura1.jpg"),
  ShengdiInfo(
      LatLng(22.2849686, 114.148009),
      "Upper Lascar Row Antique Street Market",
      "Cardcaptor Sakura",
      "sakura2.jpg"),
  ShengdiInfo(LatLng(22.2938149, 114.1660381), "The Star ferry",
      "Cardcaptor Sakura", "sakura3.jpg"),
  ShengdiInfo(LatLng(22.327218, 114.171469), "Fa Hui Park", "Cardcaptor Sakura",
      "sakura4.jpg"),
  ShengdiInfo(LatLng(22.284435, 114.15256), "Kau Kee Food Cafe",
      "Leslie CHEUNG", "Leslie.jpg")
];

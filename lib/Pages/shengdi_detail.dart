import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackust_traveling/Pages/camera_page.dart';
import 'package:hackust_traveling/Pages/shengdi_data.dart';

class ShengdiDetailPage extends StatefulWidget {
  ShengdiInfo info;

  ShengdiDetailPage(ShengdiInfo info) {
    this.info = info;
  }

  @override
  State<ShengdiDetailPage> createState() => ShengdiDetailPageState(info);

}

class ShengdiDetailPageState extends State<ShengdiDetailPage> {
  ShengdiInfo info;

  ShengdiDetailPageState(ShengdiInfo info){
    this.info = info;
  }

  Future<void> _goToCameraPage(BuildContext context, int number) async {
    print(number);
    print('hello');
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CameraPage(filterSelect: number)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Details")),
        body: Container(
            margin: EdgeInsets.all(10),
            child: Column(
                children: <Widget>[
                  Card(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                                title: Text(info.title),
                                subtitle: Text(info.subtitle)
                            ),
                            Image.network("https://storage.googleapis.com/hackust_traveling/" + info.imgName)
                          ]
                      )
                  )
                ]
            )
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: (){_goToCameraPage(context, info.number);},
            label: Text("Take a photo"),
            icon: Icon(Icons.camera),
        )
    );
  }
}
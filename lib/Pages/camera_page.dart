import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' show join;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:simple_permissions/simple_permissions.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image/image.dart' as img;
import 'package:hackust_traveling/globals.dart' as globals;

class CameraPage extends StatefulWidget {
  final CameraDescription camera = globals.camera;
  final int filterSelect;

  CameraPage({
    Key key,
    this.filterSelect,
  }) : super(key: key);

  @override
  CameraPageState createState() => CameraPageState(filterSelect);

  /*@override
  Widget build(BuildContext context) {
    return Center(
      child: Text("相機"),
    );
  }*/
}

class CameraPageState extends State<CameraPage> {
  final int filterSelect;
  CameraPageState(this.filterSelect);

  CameraController _controller;
  Future<void> _initializeControllerFuture;
  int _filterState = 0;

  void changeFilter(int newState) {
    setState(() {
      _filterState = newState;
    });
  }

  @override
  void initState() {
    super.initState();
    changeFilter(filterSelect);
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(title: Text('Take a picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return new Stack(
                alignment: FractionalOffset.center,
                children: <Widget>[
                  new Positioned.fill(
                      child: new AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: new CameraPreview(_controller))),
                  new Positioned.fill(
                      child: new Opacity(
                          opacity: 0.9,
                          child: new Image.asset(
                            globals.filter[_filterState],
                            fit: BoxFit.fill,
                          )))
                ]);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      endDrawer: Drawer(
          child: ListView(padding: EdgeInsets.zero, children: <Widget>[
        DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(globals.filter[_filterState + 2]),
                    fit: BoxFit.cover))),
        ListTile(
          leading: new CircleAvatar(
            backgroundImage: new AssetImage(globals.filter[0 * 3 + 2]),
          ),
          title: Text(globals.filterDes[0]),
          onTap: () {
            changeFilter(0 * 3);
          },
        ),
        ListTile(
          leading: new CircleAvatar(
            backgroundImage: new AssetImage(globals.filter[1 * 3 + 2]),
          ),
          title: Text(globals.filterDes[1]),
          onTap: () {
            changeFilter(1 * 3);
          },
        ),
        ListTile(
          leading: new CircleAvatar(
            backgroundImage: new AssetImage(globals.filter[2 * 3 + 2]),
          ),
          title: Text(globals.filterDes[2]),
          onTap: () {
            changeFilter(2 * 3);
          },
        ),
        ListTile(
          leading: new CircleAvatar(
            backgroundImage: new AssetImage(globals.filter[3 * 3 + 2]),
          ),
          title: Text(globals.filterDes[3]),
          onTap: () {
            changeFilter(3 * 3);
          },
        ),
        /*ListTile(
              leading: new CircleAvatar(backgroundImage: new AssetImage(globals.filter[5]),),
              title: Text('Upper Lascar Row Antique Street Market'),
              onTap: (){changeFilter(3);},
            ),*/
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: _controller.description == null
            ? null
            : () async {
                try {
                  await _initializeControllerFuture;
                  //final image1 = await rootBundle.load('assets/images/Pak_Shing_Temple_cardcaptor_sakura_the_movie.png');
                  final image1 =
                      await rootBundle.load(globals.filter[_filterState + 1]);

                  final path = join(
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}.jpg',
                  );
                  final path1 = join(
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}-cover.png',
                  );
                  final file1 = File(path1);
                  await file1.writeAsBytes(image1.buffer
                      .asUint8List(image1.offsetInBytes, image1.lengthInBytes));

                  await _controller.takePicture(path);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DisplayPictureScreen(
                        imagePath: path,
                        imageCover: path1,
                      ),
                    ),
                  );
                } catch (e) {
                  print(e);
                }
              },
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;
  final String imageCover;

  const DisplayPictureScreen({Key key, this.imagePath, this.imageCover})
      : super(key: key);

  void save(String originPath) async {
    PermissionStatus permissionResult =
        await SimplePermissions.requestPermission(
            Permission.WriteExternalStorage);
    if (permissionResult == PermissionStatus.authorized) {
      final result =
          await ImageGallerySaver.saveImage(File(originPath).readAsBytesSync());
      print(result);
      String message;
      message = result['isSuccess']
          ? 'Saved in ' + result['filePath']
          : 'Fail to save';
      Fluttertoast.showToast(msg: (message));
    }
  }

  @override
  Widget build(BuildContext context) {
    //img.Image image = Image.file(File(imagePath)) ;
    img.Image image0 = img.decodeJpg(File(imagePath).readAsBytesSync());
    //img.drawLine(image0, 0, 0, 720, 480, img.getColor(255, 0, 0), thickness: 3);
    img.Image image1 = img.decodePng(File(imageCover).readAsBytesSync());

    img.drawImage(image0, image1);
    File(imagePath).writeAsBytesSync(img.encodeJpg(image0));

    return Scaffold(
      appBar: AppBar(
        title: Text('Display the Picture'),
        actions: [
          IconButton(
              onPressed: () {
                save(imagePath);
              },
              icon: Icon(Icons.check))
        ],
      ),
      body: Image.file(File(imagePath)),
      //body: Image.file(File(finalpath)),
    );
  }
}

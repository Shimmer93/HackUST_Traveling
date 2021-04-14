import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
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

  /* const CameraPage({
    Key key,
    @required this.camera,
  }) : super(key: key);*/

  @override
  CameraPageState createState() => CameraPageState();

  /*@override
  Widget build(BuildContext context) {
    return Center(
      child: Text("相機"),
    );
  }*/
}

class CameraPageState extends State<CameraPage> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
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
      // Wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner
      // until the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            //return CameraPreview(_controller);
            return new Stack(
              alignment: FractionalOffset.center,
              children: <Widget>[
                new Positioned.fill(child: new AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: new CameraPreview(_controller))),
                new Positioned.fill(
                    child: new Opacity(
                      opacity: 0.9,
                      child: new Image.asset(
                        'assets/images/filter_Pak_Shing_Temple_cardcaptor_sakura_the_movie.png',
                        fit: BoxFit.fill,)))
              ]
            );
          } else {
            // Otherwise, display a loading indicator.
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        // Provide an onPressed callback.
        onPressed: _controller.description == null
            ? null
            : () async {
                // Take the Picture in a try / catch block. If anything goes wrong,
                // catch the error.
                try {
                  // Ensure that the camera is initialized.
                  await _initializeControllerFuture;
                  final image1 = await rootBundle.load('assets/images/Pak_Shing_Temple_cardcaptor_sakura_the_movie.png');
              
                  // Construct the path where the image should be saved using the
                  // pattern package.
                  final path = join(
                    // Store the picture in the temp directory.
                    // Find the temp directory using the `path_provider` plugin.
                    (await getTemporaryDirectory()).path,
                    '${DateTime.now()}.jpg',
                  );
                  final path1 = join(
                      (await getTemporaryDirectory()).path,
                    '${DateTime.now()}-cover.png',
                  );
                  final file1 = File(path1);
                  await file1.writeAsBytes(image1.buffer.asUint8List(image1.offsetInBytes, image1.lengthInBytes));

                  // Attempt to take a picture and log where it's been saved.
                  await _controller.takePicture(path);

                  // If the picture was taken, display it on a new screen.
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DisplayPictureScreen(imagePath: path, imageCover: path1,),
                    ),
                  );
                } catch (e) {
                  // If an error occurs, log the error to the console.
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

  const DisplayPictureScreen({Key key, this.imagePath, this.imageCover}) : super(key: key);


  void save(String originPath) async {
    PermissionStatus permissionResult = await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
    if (permissionResult == PermissionStatus.authorized) {
      final result = await ImageGallerySaver.saveImage(
          File(originPath).readAsBytesSync());
      print(result);
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
          actions: [IconButton(onPressed: (){save(imagePath);}, icon: Icon(Icons.check))],),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
      //body: Image.file(File(finalpath)),
    );
  }
}

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlanNewTripScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Plan a NEW Trip"), actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.upload_outlined,
                // size: 40,
              ),
              onPressed: () {
                _submit(context);
              }),
        ]),
        body: Padding(
          padding: EdgeInsets.all(60.0),
          child: PlanNewTripForm(),
        ));
  }

  void _submit(context) {
    Navigator.pop(context);
  }
}

class _PlanNewTripFormState extends State<PlanNewTripForm> {
  var spots = [Spot(), Spot()];

  // var texts = Map();

  // double _formProgress = 0;

  // void _updateFormProgress() {
  //   var progress = 0.0;

  //   for (var controller in texts.values) {
  //     if (controller.value.text.isNotEmpty) {
  //       progress += 1 / texts.length;
  //     }
  //   }

  //   setState(() {
  //     _formProgress = progress;
  //   });
  // }
  var position = TextEditingController();

  // double _formProgress = 0;

  void _addNewSpot() {
    setState(() {
      spots.add(Spot());
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemBuilder: /*1*/ (context, i) {
          if (i < spots.length) {
            return ListTile(title: spots[i]);
          } else if (i == spots.length) {
            return ListTile(
                title: IconButton(
                    icon: Icon(
                      Icons.add_location_alt_outlined,
                    ),
                    iconSize: 50,
                    color: Colors.blueGrey.shade700,
                    onPressed: _addNewSpot));
          } else {
            return null;
          }
        });
  }
}

class _SpotState extends State<Spot> {
  final position = TextEditingController();
  final time = TextEditingController();
  Image img;

  @override
  Widget build(BuildContext context) {
    // return Text('Destination: ', style: Theme.of(context).textTheme.bodyText1);
    return Column(children: [
      TextFormField(
          controller: position,
          decoration: InputDecoration(
              icon: Icon(Icons.location_on), hintText: 'Where')),
      TextFormField(
          controller: time,
          decoration: InputDecoration(
              icon: Icon(Icons.access_time), hintText: 'Estimated time spent')),
      ImagePickerAndShower(),
      getDownWardChevron(),
    ]);
  }
}

class _ImagePickerAndShowerState extends State<ImagePickerAndShower> {
  // Image image = Image.asset('assets/chevron.png');
  final List<Image> images = [];
  final double size = 80;

  Image iconImg2;
  final List<SizedBox> iconImg = [];
  _ImagePickerAndShowerState() {
    iconImg.add(SizedBox(
      child: InkWell(
        child: Icon(
          Icons.add_a_photo_outlined,
          size: size * 0.7,
          color: Colors.brown.shade300,
        ),
        onTap: _pickImage,
      ),
      width: size,
      height: size,
    ));
  }

  _removeImage(Image img) async {
    setState(() {
      images.remove(img);
    });
  }

  _pickImage() async {
    Image img;
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    img = kIsWeb
        ? Image.network(pickedFile.path)
        : Image.file(File(pickedFile.path));

    setState(() {
      images.add(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children: (images
                .map((e) => SizedBox(
                      child: InkWell(
                          child: e,
                          onLongPress: () {
                            _removeImage(e);
                          }),
                      width: size,
                      height: size,
                    ))
                .toList() +
            iconImg));
  }
}

Widget getDownWardChevron() {
  return Transform(
    transform: Matrix4.diagonal3Values(2, 1.0, 1.0),
    origin: Offset(50, 0),
    child: Transform.rotate(
        angle: 3.14 / 2,
        child: Icon(
          Icons.chevron_right_rounded,
          size: 100,
          color: Colors.black26,
        )),
  );
}

class _AnimatedProgressIndicatorState extends State<AnimatedProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<Color> _colorAnimation;
  Animation<double> _curveAnimation;

  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: Duration(milliseconds: 1200), vsync: this);

    var colorTween = TweenSequence([
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.red, end: Colors.orange),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.orange, end: Colors.yellow),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ColorTween(begin: Colors.yellow, end: Colors.green),
        weight: 1,
      ),
    ]);

    _colorAnimation = _controller.drive(colorTween);
    _curveAnimation = _controller.drive(CurveTween(curve: Curves.easeIn));
  }

  @override
  void didUpdateWidget(oldWidget) {
    super.didUpdateWidget(oldWidget);
    _controller.animateTo(widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) => LinearProgressIndicator(
        value: _curveAnimation.value,
        valueColor: _colorAnimation,
        backgroundColor: _colorAnimation.value.withOpacity(0.4),
      ),
    );
  }
}

class PlanNewTripForm extends StatefulWidget {
  @override
  _PlanNewTripFormState createState() => _PlanNewTripFormState();
}

class Spot extends StatefulWidget {
  @override
  _SpotState createState() => _SpotState();
}

class ImagePickerAndShower extends StatefulWidget {
  @override
  _ImagePickerAndShowerState createState() => _ImagePickerAndShowerState();
}

class AnimatedProgressIndicator extends StatefulWidget {
  final double value;

  AnimatedProgressIndicator({
    @required this.value,
  });

  @override
  State<StatefulWidget> createState() {
    return _AnimatedProgressIndicatorState();
  }
}

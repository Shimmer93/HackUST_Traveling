import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:image_picker/image_picker.dart';

class _SpotState extends State<Spot> {
  final position = TextEditingController();
  final time = TextEditingController();
  Image img;

  @override
  Widget build(BuildContext context) {
    // return Text('Destination: ', style: Theme.of(context).textTheme.bodyText1);
    return Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black12,
            width: 5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          TextFormField(
              controller: position,
              decoration: InputDecoration(hintText: 'Where')),
          TextFormField(
              controller: time,
              decoration: InputDecoration(hintText: 'Estimated time spent')),
        ]));
  }
}

class _TravelPlanFormState extends State<TravelPlanForm> {
  final spots = [];

  // var texts = Map();

  void initState() {
    super.initState();
    spots.add(Spot());
    spots.add(Spot());
  }

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

  double _formProgress = 0;

  void _addNewSpot() {
    setState(() {
      spots.add(Spot());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          ...spots,
          IconButton(icon: Icon(Icons.add_location), onPressed: _addNewSpot),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: null,
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submit() {
    Navigator.pop(context);
  }
}

class _ImagePickAndShowerState extends State<ImagePickAndShower> {
  Image image;

  _pickImage() async {
    Image img;
    if (kIsWeb) {
      img = await FlutterWebImagePicker.getImage;
    } else {
      PickedFile pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 64,
        maxHeight: 64,
      );
      img = Image.file(
        File(pickedFile.path),
      );
    }

    if (img != null) {
      setState(() {
        image = img;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return image != null
        ? image
        : TextButton(
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor:
                  MaterialStateColor.resolveWith((Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.blue;
              }),
            ),
            onPressed: _pickImage,
            child: Text('Pick Image'),
          );
  }
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

class NewTravelPlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("New travel plan"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16.0),
          child: TravelPlanForm(),
        ));
  }
}

class TravelPlanForm extends StatefulWidget {
  @override
  _TravelPlanFormState createState() => _TravelPlanFormState();
}

class Spot extends StatefulWidget {
  @override
  _SpotState createState() => _SpotState();
}

class ImagePickAndShower extends StatefulWidget {
  @override
  _ImagePickAndShowerState createState() => _ImagePickAndShowerState();
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

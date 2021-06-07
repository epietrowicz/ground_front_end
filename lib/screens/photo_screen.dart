import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ground_front_end/widgets/camera_button.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import 'package:ground_front_end/widgets/reusable_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ground_front_end/constants.dart';

import 'package:ground_front_end/screens/results_screen.dart';

class PhotoScreen extends StatefulWidget {
  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  int _selectedIndex = 0;
  bool _getNavBar = false;

  bool hasImage = false;
  File _image;
  final picker = ImagePicker();
  String brewHintText = 'BREW METHOD';
  String grindHintText = 'GRINDER';
  FocusNode brewFieldFocusNode;
  FocusNode grinderFieldFocusNode;
  String brewMethod = '';
  String grindMethod = '';

  @override
  void initState() {
    super.initState();

    brewFieldFocusNode = FocusNode();
    brewFieldFocusNode.addListener(() {
      setState(() {
        if (brewFieldFocusNode.hasFocus) brewHintText = '';
      });
    });

    grinderFieldFocusNode = FocusNode();
    grinderFieldFocusNode.addListener(() {
      setState(() {
        if (grinderFieldFocusNode.hasFocus) grindHintText = '';
      });
    });
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    brewFieldFocusNode.dispose();
    grinderFieldFocusNode.dispose();
    super.dispose();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    // final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        hasImage = true;
        _image = File(pickedFile.path);
        // print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  Future takeImage() async {
    // final pickedFile = await picker.getImage(source: ImageSource.gallery);
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        hasImage = true;
        _image = File(pickedFile.path);
        // print(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      backgroundColor: Color(0xff205D50),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(FontAwesomeIcons.history),
          onPressed: () {
            setState(() {
              _getNavBar = !_getNavBar;
            });
            print('getting history');
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(
                FontAwesomeIcons.photoVideo,
                color: Colors.white,
              ),
              onPressed: getImage)
        ],
        elevation: 0.0,
        backgroundColor: Color(0xFF205D50),
        title: Text('roastlytics', style: kH1TextStyle),
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _getNavBar
              ? NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  labelType: NavigationRailLabelType.selected,
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite_border),
                      selectedIcon: Icon(Icons.favorite),
                      label: Text('First'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bookmark_border),
                      selectedIcon: Icon(Icons.book),
                      label: Text('Second'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.star_border),
                      selectedIcon: Icon(Icons.star),
                      label: Text('Third'),
                    ),
                  ],
                )
              : Container(),
          Flexible(
            child: Column(
              children: <Widget>[
                !isKeyboard
                    ? ReusableCard(
                        width: double.infinity,
                        color: kActiveCardColour,
                        cardChild: _image != null
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                    onTap: takeImage,
                                    child: Image.file(_image)),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CameraIconButton(
                                      icon: FontAwesomeIcons.camera,
                                      onPressed: takeImage),
                                  SizedBox(
                                    height: 50.0,
                                  ),
                                  Text(
                                    'Take a picture of your grounds',
                                    style: kLabelTextStyle,
                                  )
                                ],
                              ),
                      )
                    : Container(),
                Row(
                  children: [
                    Flexible(
                      child: ReusableCard(
                        width: double.infinity,
                        onPress: () {
                          print('do something');
                        },
                        color: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.coffee,
                              color: Color(0xFF4C4F5E),
                              size: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                focusNode: brewFieldFocusNode,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontFamily: "Poppins",
                                ),
                                onChanged: (value) {
                                  brewMethod = value;
                                  print(brewMethod);
                                },
                                decoration: InputDecoration(
                                  hintText: brewHintText,
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                  // filled: true,
                                  // fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      //borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      child: ReusableCard(
                        width: double.infinity,
                        color: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.cogs,
                              color: Color(0xFF4C4F5E),
                              size: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                focusNode: grinderFieldFocusNode,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black,
                                  //fontFamily: "Poppins",
                                ),
                                onChanged: (value) {
                                  grindMethod = value;
                                  print(grindMethod);
                                },
                                decoration: InputDecoration(
                                  hintText: grindHintText,
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                  ),
                                  // filled: true,
                                  // fillColor: Colors.white,
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      //borderSide: BorderSide(color: Colors.black),
                                      borderRadius: BorderRadius.circular(50)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                NavigationButton(
                    activated: hasImage,
                    label: 'GET RESULTS',
                    onPressedFunction: () async {
                      if (hasImage) {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ResultsScreen(
                              imageFile: _image,
                              grinder: grindMethod == ''
                                  ? 'No grinder'
                                  : grindMethod,
                              brewMethod:
                                  brewMethod == '' ? 'No brewer' : brewMethod);
                        }));
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import '../constants.dart';
import 'photo_screen.dart';

class TutorialScreen3 extends StatefulWidget {
  @override
  _TutorialScreenState3 createState() => _TutorialScreenState3();
}

class _TutorialScreenState3 extends State<TutorialScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: Color(0xff205D50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('roastlytics', style: kTitleTextStyle),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   children: [
                  //     Text('GRO', style: kTitleTextStyle),
                  //   ],
                  // ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     Text('UND', style: kTitleTextStyle),
                  //   ],
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Avoid clusters', style: kSubtitleTextStyle),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Take care to avoid clumps of grounds. Tap out your coffee so the program can identify individual particles.',
                          style: kH1TextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          NavigationButton(
            activated: true,
            label: 'GET STARTED',
            onPressedFunction: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PhotoScreen();
              }));
            },
          ),
        ],
      ),
    );
  }
}

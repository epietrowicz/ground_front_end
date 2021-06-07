import 'package:flutter/material.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import '../constants.dart';
import 'photo_screen.dart';

class TutorialScreen2 extends StatefulWidget {
  @override
  _TutorialScreenState2 createState() => _TutorialScreenState2();
}

class _TutorialScreenState2 extends State<TutorialScreen2> {
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
                        Text('Take your photo at the right distance',
                            style: kSubtitleTextStyle),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'The algorithm needs to see all four edges of the paper, make sure they are visible in your shot.',
                          style: kH1TextStyle,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: NavigationButton(
              activated: true,
              label: 'GET STARTED',
              onPressedFunction: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PhotoScreen();
                }));
              },
            ),
          ),
        ],
      ),
    );
  }
}

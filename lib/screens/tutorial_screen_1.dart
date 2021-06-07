import 'package:flutter/material.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import '../constants.dart';
import 'photo_screen.dart';

class TutorialScreen1 extends StatefulWidget {
  @override
  _TutorialScreenState1 createState() => _TutorialScreenState1();
}

class _TutorialScreenState1 extends State<TutorialScreen1> {
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
                  Text('roastlytics', style: kTitleTextStyle),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Text(
                  //         'GRO',
                  //         style: kTitleTextStyle,
                  //       ),
                  //     ],
                  //   ),
                  //   Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       Text('UND', style: kTitleTextStyle),
                  //     ],
                  //   ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Some things to note', style: kSubtitleTextStyle),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'Swipe to see how to get the best results.',
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
          )
        ],
      ),
    );
  }
}

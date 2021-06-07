import 'package:flutter/material.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import '../constants.dart';
import 'photo_screen.dart';

class TutorialScreen4 extends StatefulWidget {
  @override
  _TutorialScreenState4 createState() => _TutorialScreenState4();
}

class _TutorialScreenState4 extends State<TutorialScreen4> {
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

                      //crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('Minimize shadows', style: kSubtitleTextStyle),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'If you are getting unfavorable results, try expirementing with your lighting. Flash or additional light may help.',
                          style: kH1TextStyle,
                          textAlign: TextAlign.start,
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

import 'package:flutter/material.dart';
import 'package:ground_front_end/widgets/navigation_button.dart';
import '../constants.dart';
import './analysis/photo_screen.dart';

class TutorialScreen extends StatefulWidget {
  TutorialScreen({this.showTitle, this.heading1, this.heading2});

  final bool showTitle;
  final String heading1;
  final String heading2;

  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
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
                  widget.showTitle
                      ? Text('roastlytics', style: kTitleTextStyle)
                      : Container(),
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
                        // 'Some things to note'
                        Text(widget.heading1, style: kSubtitleTextStyle),
                        SizedBox(
                          height: 20.0,
                        ),
                        //'Swipe to see how to get the best results.'
                        Text(
                          widget.heading2,
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

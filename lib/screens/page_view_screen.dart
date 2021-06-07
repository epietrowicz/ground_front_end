import 'package:flutter/material.dart';
import 'package:ground_front_end/screens/tutorial_screen_1.dart';
import 'package:ground_front_end/screens/tutorial_screen_2.dart';
import 'package:ground_front_end/screens/tutorial_screen_3.dart';
import 'package:ground_front_end/screens/tutorial_screen_4.dart';
import 'package:ground_front_end/widgets/dots_indicator.dart';

class PageViewScreen extends StatefulWidget {
  @override
  _PageViewScreenState createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    TutorialScreen1(),
    TutorialScreen2(),
    TutorialScreen3(),
    TutorialScreen4(),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageView.builder(
              physics: new AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            new Positioned(
              bottom: 20.0,
              left: 0.0,
              right: 0.0,
              child: new Container(
                padding: const EdgeInsets.all(20.0),
                child: new Center(
                  child: new DotsIndicator(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageSelected: (int page) {
                      _controller.animateToPage(
                        page,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

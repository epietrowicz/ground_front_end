import 'package:flutter/material.dart';
import 'package:ground_front_end/screens/tutorial_screen.dart';
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
    TutorialScreen(
        showTitle: true,
        heading1: 'Some things to note',
        heading2: 'Swipe to see how to get the best results.'),
    TutorialScreen(
        showTitle: false,
        heading1: 'Take your photo at the right distance',
        heading2:
            'The algorithm needs to see all four edges of the paper, make sure they are visible in your shot.'),
    TutorialScreen(
        showTitle: false,
        heading1: 'Avoid clusters',
        heading2:
            'Take care to avoid clumps of grounds. Tap out your coffee so the program can identify individual particles.'),
    TutorialScreen(
        showTitle: false,
        heading1: 'Minimize shadows',
        heading2:
            'If you are getting unfavorable results, try expirementing with your lighting. Flash or additional light may help.'),
  ];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IconTheme(
        data: IconThemeData(color: _kArrowColor),
        child: Stack(
          children: <Widget>[
            PageView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              controller: _controller,
              itemBuilder: (BuildContext context, int index) {
                return _pages[index % _pages.length];
              },
            ),
            Positioned(
              bottom: 20.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Center(
                  child: DotsIndicator(
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

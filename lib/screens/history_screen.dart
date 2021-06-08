import 'package:flutter/material.dart';
import 'package:ground_front_end/widgets/login.dart';
import '../constants.dart';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({this.isLoggedIn});
  final bool isLoggedIn;

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff205D50),
        appBar: AppBar(
          backgroundColor: Color(0xff205D50),
          elevation: 0.0,
          title: Text('roastlytics', style: kH1TextStyle),
        ),
        body: widget.isLoggedIn
            ? Column(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      color: Color(0xff205D50),
                      child: Text('yeah we logged in', style: kTitleTextStyle),
                    ),
                  ),
                ],
              )
            : Login());
  }
}

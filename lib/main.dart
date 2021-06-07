import 'package:flutter/material.dart';
import 'package:ground_front_end/screens/page_view_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: PageViewScreen(),
    );
  }
}

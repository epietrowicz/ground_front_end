import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {@required this.color,
      this.cardChild,
      this.onPress,
      this.height,
      this.width});

  final Color color;
  final Widget cardChild;
  final Function onPress;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        width: width,
        height: height,
        child: cardChild,
        margin: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: color,
          //border: Border.all(color: color, width: 3.0),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

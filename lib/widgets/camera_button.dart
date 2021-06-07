import 'package:flutter/material.dart';

class CameraIconButton extends StatelessWidget {
  CameraIconButton({@required this.icon, @required this.onPressed});

  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 10.0,
      child: Icon(icon, size: 75.0),
      onPressed: onPressed,
      constraints: BoxConstraints.tightFor(
        width: 150.0,
        height: 150.0,
      ),
      shape: CircleBorder(),
      fillColor: Color(0xFF4C4F5E),
    );
  }
}

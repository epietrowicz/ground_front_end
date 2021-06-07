import 'package:flutter/material.dart';

class NavigationButton extends StatelessWidget {
  NavigationButton({this.onPressedFunction, this.label, this.activated});

  final Function onPressedFunction;
  final String label;
  final bool activated;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        color: Color(0xff205D50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 60.0,
              width: 300.0,
              child: activated
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 10.0,
                        primary: Colors.white,
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(color: Colors.black),
                      ),
                      onPressed: onPressedFunction,
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        elevation: 0.0,
                        primary: Color(0xFF205D50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            side: BorderSide(width: 2.0, color: Colors.white)),
                      ),
                      child: Text(
                        label,
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        print('no picture taken yet');
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

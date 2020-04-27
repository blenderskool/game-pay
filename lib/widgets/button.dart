import 'package:flutter/material.dart';

class SolidButton extends StatelessWidget {
  SolidButton(
      {@required this.onTap,
      this.child,
      this.disabled = false,
      this.color = Colors.lightBlueAccent});
  final GestureTapCallback onTap;
  final Widget child;
  final Color color;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: disabled ? 0.7 : 1.0,
      child: Material(
        borderRadius: BorderRadius.circular(4.0),
        textStyle: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontFamily: 'Poppins',
        ),
        color: color,
        child: InkWell(
          splashColor: disabled ? Colors.transparent : Colors.white38,
          highlightColor: disabled ? Colors.transparent : Colors.white12,
          enableFeedback: !disabled,
          onTap: disabled ? () {} : onTap,
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              child: Center(child: child)),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  Button(
      {@required this.onTap, this.child, this.color = Colors.lightBlueAccent});
  final GestureTapCallback onTap;
  final Widget child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Material(
      textStyle: TextStyle(
        color: color,
        fontSize: 18.0,
        fontFamily: 'Poppins',
      ),
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          border: Border.all(color: color, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: InkWell(
          onTap: onTap,
          child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 18.0,
                vertical: 12.0,
              ),
              child: Center(child: child)),
        ),
      ),
    );
  }
}

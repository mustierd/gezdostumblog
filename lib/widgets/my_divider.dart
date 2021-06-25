import 'package:flutter/material.dart';

class MyDivider extends StatelessWidget {
  final Color dividerColor;
  final double dividerHeight;
  final double dividerThickness;

  const MyDivider(
      {Key key, this.dividerColor, this.dividerHeight, this.dividerThickness})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      child: Divider(
        color: dividerColor,
        height: dividerHeight,
        thickness: dividerThickness,
      ),
    );
  }
}

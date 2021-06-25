import 'package:flutter/material.dart';

class InsertImage extends StatelessWidget {
  final double imageHeight;
  final double imageWidth;
  final String imageLink;

  const InsertImage(
      {Key key, this.imageHeight, this.imageWidth, this.imageLink})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: imageHeight,
      width: imageWidth,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageLink),
          fit: BoxFit.fill,
        ),
        shape: BoxShape.circle,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InsertBlogClips extends StatelessWidget {
  final String imageUrl;

  const InsertBlogClips({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: 200,
          ),
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.black54.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
  }
}

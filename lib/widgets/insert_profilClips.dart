import 'package:flutter/material.dart';

class InsertProfilClips extends StatelessWidget {
  final String profilPhoto;
  final Function onTap;

  const InsertProfilClips({Key key, @required this.profilPhoto, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          border: Border.all(width: 4, color: Colors.white),
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 10,
              color: Colors.green[900].withOpacity(1),
            ),
          ],
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: profilPhoto == null
                ? NetworkImage(
                    "https://whatsappturk.com/wp-content/uploads/2020/05/whatsapp-noktayim.png")
                : NetworkImage(profilPhoto),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SnackmateAppBar extends StatelessWidget {
  const SnackmateAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withAlpha(10),
                blurRadius: 3,
                offset: Offset(0, 2))
          ]),
      child: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.white,
        title: Image.asset('images/snackmate_logo.png'),
        centerTitle: true,
        elevation: 0,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Styles {
  static Image logo = Image(image: AssetImage('TODO'), height: 24);

  static TextStyle error = TextStyle(color: Colors.red);
  static TextStyle success = TextStyle(color: Colors.green);
  static TextStyle successBig = TextStyle(color: Colors.green, fontSize: 20);

  static Widget errorText(String msg) {
    return Text(msg, style: Styles.error);
  }

  static errorSnack(BuildContext context, String msg) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: new Text(msg),
      backgroundColor: Colors.red,
    ));
  }

  static Widget waiting() {
    return SizedBox(width: 40, height: 40, child: CircularProgressIndicator());
  }
}

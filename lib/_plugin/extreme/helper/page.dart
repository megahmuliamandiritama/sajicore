import 'package:flutter/material.dart';

class Page {
  static Future show(BuildContext context, newPage) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => newPage,
      ),
    );

    return Future.value(true);
  }

  static replace(BuildContext context, newPage) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => newPage,
      ),
    );
  }

  static clearAndPush(BuildContext context, newPage) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => newPage,
        ),
        (route) => false);
  }
}

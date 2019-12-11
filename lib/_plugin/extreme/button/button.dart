import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ButtonType {
  static Color primary = Colors.blue[900];
  static Color success = Colors.green;
  static Color danger = Colors.red[400];
  static Color warning = Colors.orange;
  static Color info = Colors.lightBlue;
  static Color print1 = Colors.red[400];
  static Color print2 = Colors.purple;
  static Color selected = Session.themeColor;
  static Color themeColor = Session.themeColor;
  static Color unSelected = Colors.grey;
  static Color themeButtonColor = Color(0xffe44c5a);
}

class ExButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final dynamic onPressed;

  final Color type;
  ExButton({
    @required this.label,
    this.icon,
    @required this.onPressed,
    @required this.type,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: FlatButton.icon(
        color: type != null ? type : Colors.blue[900],
        icon: icon != null
            ? Icon(
                icon,
                color: Colors.white,
                size: 14.0,
              )
            : Container(), //`Icon` to display
        label: Text(
          label != null ? label : "",
          style: TextStyle(color: Colors.white, fontSize: 10.0),
          overflow: TextOverflow.ellipsis,
        ), //`Text` to display
        onPressed: () {
          if (onPressed != null) {
            onPressed();
          }
        },
      ),
    );
  }
}

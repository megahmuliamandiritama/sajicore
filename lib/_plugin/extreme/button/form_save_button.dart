import 'package:extremecore/core.dart';
import 'package:flutter/material.dart';

class FormSaveButton extends StatelessWidget {
  final dynamic onPressed;

  FormSaveButton({
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 60.0,
              child: ExButton(
                label: "Save",
                icon: Icons.save,
                type: ButtonType.primary,
                onPressed: () {
                  if (this.onPressed != null) {
                    this.onPressed();
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

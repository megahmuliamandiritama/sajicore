import 'package:extremecore/_plugin/extreme/button/button.dart';
import 'package:extremecore/app.dart';
import 'package:flutter/material.dart';

class SaveButton extends StatelessWidget {
  final dynamic onPressed;
  SaveButton({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: "Save",
      icon: Icons.save,
      type: ButtonType.success,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}

class UpdateButton extends StatelessWidget {
  final dynamic onPressed;
  UpdateButton({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: "Update",
      icon: Icons.save,
      type: ButtonType.warning,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}

class DangerButton extends StatelessWidget {
  final dynamic onPressed;
  DangerButton({
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: "Delete",
      icon: Icons.delete,
      type: ButtonType.danger,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}

class IButton extends StatelessWidget {
  final dynamic onPressed;
  final String label;
  IButton({
    @required this.onPressed,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ExButton(
      label: label,
      icon: Icons.flash_on,
      type: ButtonType.primary,
      onPressed: () {
        if (onPressed != null) {
          onPressed();
        }
      },
    );
  }
}

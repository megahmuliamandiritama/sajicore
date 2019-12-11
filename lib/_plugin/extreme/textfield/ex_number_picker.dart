import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExNumberPicker extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon; 
  final bool useIcon; 
  final String value;
  final BuildContext context;

final int minValue;
final int maxValue;

  ExNumberPicker({
    @required this.id,
    @required this.label,
    this.minValue = 0,
    this.maxValue = 1000000,
    this.useIcon = true,
    this.icon = Icons.confirmation_number,
    this.value,
    @required this.context,
  });

  @override
  _ExNumberPickerState createState() => _ExNumberPickerState();
}

class _ExNumberPickerState extends State<ExNumberPicker> {
  @override
  void initState() {
    super.initState();

    if (widget.value == null) {
      Input.set(widget.id, "");
    } else {
      Input.set(widget.id, widget.value);
    }
  }

  int _currentValue = 1;

   showBottomSheet(context) {
     showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                Container(
                  width: 1000,
                  padding: EdgeInsets.all(12.0),
                  child: Text(widget.label + ": ",style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),),
                ),
                Container(
                  height: 200.0,
                  child: NumberPicker.integer(
                initialValue: _currentValue,
                minValue: widget.minValue,
                maxValue: widget.maxValue,
                onChanged: (newValue) =>
                    setState(() {
                      _currentValue = newValue;
                      Input.controllerList[widget.id].text = newValue.toString();
                    })),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ExTextField(
      id: widget.id,
      label: widget.label,
      icon: widget.icon,
      useBorder: true,
      useIcon: widget.useIcon,
      enable: false,
      value: widget.value != null ? widget.value : "",
      valueFromController: true,
      onContainerTap: () {
        showBottomSheet(context);
      },
    );
  }
}

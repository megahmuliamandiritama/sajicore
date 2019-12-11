import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExDatePicker extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final String value;
  final BuildContext context;

  final bool enableDatePicker;

  ExDatePicker({
    @required this.id,
    @required this.label,
    this.icon = Icons.note,
    this.value,
    @required this.context,
    this.enableDatePicker = true,
  });

  @override
  _ExDatePickerState createState() => _ExDatePickerState();
}

class _ExDatePickerState extends State<ExDatePicker> {
  @override
  void initState() {
    super.initState();

    if (widget.value == null) {
      Input.set(widget.id, "");
    } else {
      Input.set(widget.id, widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    String formattedDate;

    return ExTextField(
      id: widget.id,
      label: widget.label,
      icon: widget.icon,
      useBorder: true,
      useIcon: true,
      enable: false,
      value: widget.value != null ? widget.value : "",
      valueFromController: true,
      onContainerTap: () {
        if (widget.enableDatePicker == false) {
          return;
        }
        DatePicker.showDatePicker(context,
            theme: DatePickerTheme(),
            showTitleActions: true,
            minTime: DateTime(1900, 1, 1),
            maxTime: DateTime(2050, 12, 31), onChanged: (date) {
          Input.set(widget.id, date);
          Input.controllerList[widget.id].text = date.toString();
          print('change $date');
        }, onConfirm: (date) {
          formattedDate = DateFormat('yyyy-MM-dd').format(date);
          print('confirm $date');
          print('confirm $formattedDate');
          
          Input.set(widget.id, formattedDate);
          Input.controllerList[widget.id].text = formattedDate.toString();

          // Input.set(widget.id, date);
          // Input.controllerList[widget.id].text = date.toString();
        }, currentTime: DateTime.now(), locale: LocaleType.en);
      },
    );
  }
}

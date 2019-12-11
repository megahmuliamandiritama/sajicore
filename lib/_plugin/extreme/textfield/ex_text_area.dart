import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExTextArea extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final String value;
  final int maxLines;
  final int maxLength;
  final BuildContext context;

  ExTextArea({
    @required this.id,
    @required this.label,
    this.icon = Icons.note,
    this.value,
    this.maxLines = 4,
    this.maxLength = 500,
    @required this.context,
  });

  @override
  _ExTextAreaState createState() => _ExTextAreaState();
}

class _ExTextAreaState extends State<ExTextArea> {
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
    return ExTextField(
      id: widget.id,
      label: widget.label,
      icon: widget.icon,
      useBorder: true,
      useIcon: true,
      enable: false,
      value: widget.value != null ? widget.value : "",
      maxLines: widget.maxLines,
      maxLength: widget.maxLength,
      keyboardType: TextInputType.multiline,
      valueFromController: true,
      onContainerTap: () {
        Page.show(
            widget.context,
            TextAreaPopup(
              id: widget.id,
              label: widget.label,
              icon: widget.icon,
            ));
      },
    );
  }
}

class TextAreaPopup extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final int maxLines;
  final int maxLength;

  TextAreaPopup({
    @required this.id,
    @required this.label,
    this.icon = Icons.note,
    this.maxLines = 4,
    this.maxLength = 500,
  });

  @override
  _TextAreaPopupState createState() => _TextAreaPopupState();
}

class _TextAreaPopupState extends State<TextAreaPopup> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("Default Value:");
    print(Input.get(widget.id));

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      body: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            ExTextField(
              id: widget.id,
              label: widget.label,
              icon: widget.icon,
              useBorder: true,
              useIcon: true,
              maxLines: widget.maxLines,
              maxLength: widget.maxLength,
              keyboardType: TextInputType.multiline,
              value: Input.get(widget.id),
              useAutoFocus: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ExButton(
                  label: "Clear Text",
                  icon: Icons.clear,
                  type: Colors.black,
                  onPressed: () {
                    Input.controllerList[widget.id].text = "";
                  },
                ),
                Container(
                  width: 8.0,
                ),
                ExButton(
                  label: "Select All",
                  icon: Icons.select_all,
                  type: Colors.black,
                  onPressed: () {
                    var textEditingController = Input.controllerList[widget.id];
                    textEditingController.selection = TextSelection(
                        baseOffset: 0,
                        extentOffset: textEditingController.text.length);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

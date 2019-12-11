import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExTextField extends StatefulWidget {
  final String id;
  final String label;
  final String hintText;
  final String helperText;
  final TextInputType keyboardType;
  final IconData icon;
  final String value;
  final TextAlign textAlign;
  final Color textColor;
  final Color prefixColor;
  final Color suffixColor;

  final EdgeInsets contentPadding;
  final double fontSize;

  final bool useBorder;
  final bool usePassword;
  final bool useIcon;
  final bool useSuffix;
  final bool useAutoFocus;
  final bool valueFromController;

  final bool enable;

  final int maxLines;
  final int maxLength;

  //event
  final dynamic onChanged;
  final dynamic onFocus;
  final dynamic onSubmitted;
  final dynamic onContainerTap;

  ExTextField({
    @required this.id,
    this.label,
    this.hintText,
    this.helperText,
    this.value,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.useBorder = false,
    this.usePassword = false,
    this.useIcon = false,
    this.useSuffix = true,
    this.useAutoFocus = false,
    this.valueFromController = false,
    this.textAlign = TextAlign.left,
    this.contentPadding = const EdgeInsets.all(8.0),
    this.fontSize = 16.0,
    this.maxLength,
    this.maxLines,
    this.onChanged,
    this.onFocus,
    this.onSubmitted,
    this.onContainerTap,
    this.enable = true,
    this.textColor,
    this.prefixColor,
    this.suffixColor,
  });

  @override
  _ExTextFieldState createState() => _ExTextFieldState();
}

class _ExTextFieldState extends State<ExTextField> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  bool showSuffix = false;

  void saveToHistory(id, value) {
    // var storageInputHistory = LocalStorage.load(id + "_input_history");
    // if (storageInputHistory == null) {
    //   storageInputHistory = [];
    // }

    // var inputHistory = (storageInputHistory as List);
    // inputHistory.add(value);

    // LocalStorage.save(id + "_input_history", value);
  }

  @override
  void initState() {
    Input.set(widget.id, "");
    if (widget.value != null) {
      Input.set(widget.id, widget.value);
    }

    //! Save Input TextEditingController
    Input.controllerList[widget.id] = textEditingController;
    textEditingController.text = widget.value;
    textEditingController.addListener(() {
      Input.set(widget.id, textEditingController.text);
      // saveToHistory(widget.id, textEditingController.text);
    });

    //FocusNode
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (this.mounted) {
          setState(() {
            showSuffix = true;
          });
          if (widget.onFocus != null) {
            widget.onFocus();
          }
        }
      } else {
        if (this.mounted) {
          setState(() {
            showSuffix = false;
          });
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Khusus untuk searchfield/textarea
    if (Input.get(widget.id) != null && widget.valueFromController == true) {
      // textEditingController.text = Input.get(widget.id).toString() == "null"
      //     ? ""
      //     : Input.get(widget.id).toString();


      //! FIX!! Cursor ke posisi 0 terus
      var cursorPos = textEditingController.selection;

      textEditingController.text = Input.get(widget.id).toString() ?? '';

      if (cursorPos.start > textEditingController.text.length) {
        cursorPos = new TextSelection.fromPosition(
            new TextPosition(offset: textEditingController.text.length));
      }
      textEditingController.selection = cursorPos;
    }

    return InkWell(
      onTap: () {
        if (widget.enable == false) {
          widget.onContainerTap != null ? widget.onContainerTap() : Container();
        }
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 8.0),
        child: TextField(
          autocorrect: false,
          keyboardType: widget.keyboardType,
          focusNode: focusNode,
          controller: textEditingController,
          obscureText: widget.usePassword,
          textAlign: widget.textAlign,
          autofocus: widget.useAutoFocus,
          enabled: widget.enable,
          onChanged: (text) {
            print("onChanged called");
            if (widget.onChanged != null) {
              print("widget.onChanged != null");
              widget.onChanged(text);
              // SystemChannels.textInput.invokeMethod('TextInput.hide');
            }
          },
          onSubmitted: (text) {
            if (widget.onSubmitted != null) {
              widget.onSubmitted();
              SystemChannels.textInput.invokeMethod('TextInput.hide');
            }
          },
          maxLength: widget.maxLength,
          maxLines: widget.maxLines ?? 1,
          style: TextStyle(
            fontSize: widget.fontSize,
            color: widget.textColor ?? Theme.of(context).hintColor,
          ),
          decoration: InputDecoration(
            prefixIcon: widget.useIcon == true
                ? Icon(
                    widget.icon,
                    color: widget.prefixColor ?? Theme.of(context).hintColor,
                  )
                : null,
            suffixIcon: widget.useSuffix == true && showSuffix == true
                ? IconButton(
                    icon: Icon(
                      Icons.close,
                      color: widget.suffixColor ?? Theme.of(context).hintColor,
                    ),
                    onPressed: () {
                      textEditingController.text = "";
                      Input.set(widget.id, "");
                    },
                  )
                : null,
            // counterText: "",
            labelText: widget.label,
            hintText: widget.hintText,
            helperText: widget.helperText,
            contentPadding: widget.contentPadding,
            isDense: true,
            border: !widget.useBorder
                ? null
                : OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
          ),
        ),
      ),
    );
  }
}

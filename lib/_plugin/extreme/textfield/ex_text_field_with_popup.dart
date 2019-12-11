import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExTextField2 extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final String value;
  final BuildContext context;

  ExTextField2({
    @required this.id,
    @required this.label,
    this.icon = Icons.note,
    this.value,
    @required this.context,
  });

  @override
  _ExTextField2State createState() => _ExTextField2State();
}

class _ExTextField2State extends State<ExTextField2> {
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
      onContainerTap: () {
        Page.show(
            widget.context,
            ExTextFieldPopup(
              id: widget.id,
              label: widget.label,
              icon: widget.icon,
            ));
      },
    );
  }
}

class ExTextFieldPopup extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;

  ExTextFieldPopup({
    @required this.id,
    @required this.label,
    this.icon = Icons.note,
  });

  @override
  _ExTextFieldPopupState createState() => _ExTextFieldPopupState();
}

class _ExTextFieldPopupState extends State<ExTextFieldPopup> {
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
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              ExTextField(
                id: widget.id,
                label: widget.label,
                icon: widget.icon,
                useBorder: true,
                useIcon: true,
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
                      var textEditingController =
                          Input.controllerList[widget.id];
                      textEditingController.selection = TextSelection(
                          baseOffset: 0,
                          extentOffset: textEditingController.text.length);
                    },
                  ),
                ],
              ),
              TextFieldHistory(
                id: widget.id,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TextFieldHistory extends StatefulWidget {
  final String id;

  TextFieldHistory({
    this.id,
  });

  @override
  _TextFieldHistoryState createState() => _TextFieldHistoryState();
}

class _TextFieldHistoryState extends State<TextFieldHistory> {
  var items = [];

  @override
  void initState() {
    super.initState();

    // var storageInputHistory = LocalStorage.load(widget.id + "_input_history");
    // if (storageInputHistory == null) {
    //   storageInputHistory = [];
    // }

    // var inputHistory = (storageInputHistory as List);
    // items = inputHistory;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "History",
            style: TextStyle(color: Colors.red),
          ),
          Container(
            height: 400.0,
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                var item = items[index];

                return Card(
                  child: ListTile(
                    title: item,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

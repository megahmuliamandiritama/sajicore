import 'package:extremecore/core.dart';
import 'package:flutter/material.dart';
import 'listview.dart';

class ExLocationPicker extends StatefulWidget {
  final String id;
  final String value;
  final String labelText;

  final String placeId;
  final double lat;
  final double lng;

  ExLocationPicker({
    Key key,
    @required this.id,
    this.value,
    this.labelText,
    this.placeId,
    this.lat,
    this.lng,
  });

  @override
  _ExLocationPickerState createState() => _ExLocationPickerState();
}

class _ExLocationPickerState extends State<ExLocationPicker> {
  @override
  void initState() {
    print("WidgetValue ${widget.value}");
    Input.set(widget.id, widget.value ?? "");
    Input.set("placeId", widget.placeId);
    Input.set("lat", widget.lat);
    Input.set("lng", widget.lng);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController textEditingController = TextEditingController();

    textEditingController.text = Input.get(widget.id);

    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            Page.show(
              context,
              GooglePlaceAutoCompleteSearchWidgetListView(
                id: widget.id,
              ),
            );
          },
          child: TextField(
            controller: textEditingController,
            enabled: false,
            decoration: InputDecoration(
              labelText: widget.labelText,
              icon: Icon(Icons.place),
            ),
          ),
        ),
      ],
    );
  }
}

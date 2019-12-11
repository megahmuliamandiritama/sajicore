import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExIconField extends StatefulWidget {
  final String id;
  final String label;
  final String value;
  final String placeHolder;
  final TextAlign align;
  final TextOverflow overflow;
  final Color color;
  final String fontFamily;
  final IconData icon;
  final String displayField;
  final String valueField;
  final ApiDefinition apiDefinition;
  final dynamic items;

  ExIconField({
    @required this.id,
    @required this.label,
    this.value,
    this.placeHolder,
    this.align,
    this.overflow,
    this.color,
    this.fontFamily,
    this.icon,
    @required this.displayField,
    @required this.valueField,
    this.apiDefinition,
    this.items,
  });

  @override
  _ExIconFieldState createState() => _ExIconFieldState();
}

class _ExIconFieldState extends State<ExIconField> {
  @override
  void initState() {
    super.initState();
    Input.set(widget.id + "_item", null);
    Input.set(widget.id + "_displayField", null);
    Input.set(widget.id, null);
    
    if (widget.value != null) {
      Input.set(widget.id, widget.value);
    }
  }

  getList() {
    if (widget.apiDefinition != null) {
      return ExList(
        title: widget.label,
        onItemSelected: (item) {
          print("#1.1 You Select ");
          print("#1.2 $item");
          Input.set(widget.id + "_item", item);
          Input.set(widget.id + "_displayField", item[widget.displayField]);
          Input.set(widget.id, item[widget.valueField]);
          
          String value0 = "$item";
          String value1 = Input.get(widget.id + "_displayField");
          String value2 = item[widget.displayField];
          String value3 = widget.displayField;
          print("#1.3 $value0");
          print("#1.4 $value1");
          print("#1.5 $value2");
          print("#1.6 $value3");
        },
        noActionsButton: true,
        noFloatingActionButton: true,
        apiDefinition: ApiDefinition(
          endpoint: widget.apiDefinition.endpoint,
          primaryKey: widget.apiDefinition.primaryKey,
          leadingPhotoIndex: widget.apiDefinition.leadingPhotoIndex,
          titleIndex: widget.apiDefinition.titleIndex,
          subtitleIndex: widget.apiDefinition.subtitleIndex,
        ),
      );
    } else {
      return ExLocalList(
        items: widget.items,
        title: widget.label,
        displayField: widget.displayField,
        valueField: widget.valueField,
        onItemSelected: (item) {
          print("#2 You Select ");
          print("#2 $item");
          Input.set(widget.id + "_item", item);
          Input.set(widget.id + "_displayField", item[widget.displayField]);
          Input.set(widget.id, item[widget.valueField]);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String value = Input.get(widget.id + "_displayField");
    print("#3 value : $value");

    return InkWell(
      onTap: () {
        Page.show(
          context,
          getList(),
        );
      },
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            //  AutoSizeText(value ?? "No Data"),
            Icon(
              Icons.arrow_drop_down,
              color: widget.color,
            ),
            Container(
              child: AutoSizeText(
                value ?? widget.placeHolder,
                textAlign: widget.align,
                overflow: widget.overflow,
                style: TextStyle(
                  color: widget.color,
                  fontFamily: widget.fontFamily,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

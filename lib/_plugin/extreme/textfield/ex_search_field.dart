import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExSearchField extends StatefulWidget {
  final String id;
  final String label;
  final String beforeSubtitle;
  final IconData icon;
  final String displayField; //? dari ApiDefinition primaryKey
  final String valueField; //? dari ApiDefinition titleIndex
  final String value;
  final String displayValue;
  final ApiDefinition apiDefinition;
  final dynamic items;

  ExSearchField({
    @required this.id,
    @required this.label,
    this.beforeSubtitle = "",
    this.icon,
    @required this.displayField,
    @required this.valueField,
    this.value,
    this.displayValue,
    this.apiDefinition,
    this.items,
  });

  @override
  _ExSearchFieldState createState() => _ExSearchFieldState();
}

class _ExSearchFieldState extends State<ExSearchField> {
  @override
  void initState() {
    super.initState();
    // Input.set(widget.id + "_item", null);
    Input.set(widget.id + "_displayField", widget.displayValue);
    Input.set(widget.id, widget.value);
    print("================================");
    print(Input.get(widget.id));
    print(Input.get(widget.id + "_item"));
  }

  getList() {
    if (widget.apiDefinition != null) {
      return ExList(
        title: widget.label,
        beforeSubtitle: widget.beforeSubtitle,
        noDelete: true,
        onItemSelected: (item) {
          // setState(() {});
          print("You Select ");
          print(item);
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
          print(Input.get(widget.id + "_item"));
          // print(Input.get("discount_id_item")["discount_type"]);
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
          print("You Select ");
          print(item);
          Input.set(widget.id + "_item", item);
          Input.set(widget.id + "_displayField", item[widget.displayField]);
          Input.set(widget.id, item[widget.valueField]);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ExTextField(
      id: widget.id + "_displayField",
      label: widget.label,
      icon: widget.icon == null ? Icons.search : widget.icon,
      useBorder: true,
      useIcon: true,
      enable: false,
      value: widget.displayValue,
      valueFromController: true,
      onContainerTap: () {
        print("Tapped from SearchField");
        Page.show(
          context,
          getList(),
        );
      },
    );
  }
}

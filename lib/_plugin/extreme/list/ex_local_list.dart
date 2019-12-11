import 'package:extremecore/view/partial/saji_appbar.dart';
import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExLocalList extends StatefulWidget {
  final String title;
  final dynamic items;
  final String displayField;
  final String valueField;

  final dynamic onTap;
  final dynamic onItemSelected;

  ExLocalList({
    @required this.items,
    @required this.title,
    @required this.displayField,
    @required this.valueField,
    this.onTap,
    this.onItemSelected,
  });

  @override
  _ExLocalListState createState() => _ExLocalListState();
}

class _ExLocalListState extends State<ExLocalList> {
  List items = [];
  String nextPageUrl;
  String prevUrl;

  @override
  void initState() {
    super.initState();
    items = widget.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Saji.getAppBar(
        context: context,
        title: widget.title,
        hasBottom: false,
      ),
      body: items.length == 0
          ? Center(child: Text("Please provide some items"))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];

                  return InkWell(
                    onTap: () {
                      if (widget.onItemSelected != null) {
                        widget.onItemSelected(item);
                        Navigator.of(context).pop();
                        return;
                      }

                      if (widget.onTap != null) {
                        widget.onTap();
                        return;
                      }
                    },
                    child: Card(
                      child: ListTile(
                        title: Text(item[widget.displayField]),
                      ),
                      semanticContainer: true,
                    ),
                  );
                },
              ),
            ),
    );
  }
}

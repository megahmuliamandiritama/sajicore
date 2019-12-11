import 'package:extremecore/core.dart';
import 'package:flutter/material.dart';

class ExampleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mainListView = ExList(
      noActionsButton: true,
      noFloatingActionButton: true,
      noAppBar: true,
      noDelete: true,
      apiDefinition: ApiDefinition(
        endpoint: "table_management",
        primaryKey: "table_id",
        leadingPhotoIndex: null,
        titleIndex: "table_number",
        subtitleIndex: null,
        where: {
          // "table_number": "(>)270",
          // "table_number": "(<)270",
          // "table_number": "(>=)270",
          // "table_number": "(<=)270",
          // "table_number": "(<>)270",
          // "order_id": "(<>)270",
          "order_id": "270",
        },
      ),
      itemBuilder: (context, item, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(item["table_number"].toString() +
                  " - " +
                  item["order_id"] +
                  " - " +
                  item["status"]),
            ],
          ),
        );
      },
      onItemSelected: (item) {
        print("You Select Item: ${item["table_id"]} / ${item["order_id"]}");
      },
    );

    // return mainListView;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            padding: EdgeInsets.all(10.0),
            color: Colors.red[200],
            child: Row(
              children: <Widget>[
                Text("Order ID: 122"),
                Spacer(),
                ExButton(
                  label: "Refresh",
                  icon: Icons.refresh,
                  type: ButtonType.primary,
                  onPressed: () {
                    EX.reload();
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: mainListView,
          ),
          Container(
            height: 50.0,
            padding: EdgeInsets.all(10.0),
            color: Colors.red,
            child: Row(
              children: <Widget>[
                Text("Order ID: 122"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

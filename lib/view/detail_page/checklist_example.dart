import 'package:extremecore/core.dart';
import 'package:flutter/material.dart';

class ChecklistExamplePage extends StatefulWidget {
  @override
  _ChecklistExamplePageState createState() => _ChecklistExamplePageState();
}

class _ChecklistExamplePageState extends State<ChecklistExamplePage> {
  var items = [
    {
      "id": 101,
      "name": "DS",
      "activated_date": "2019-06-30",
    },
    {
      "id": 102,
      "name": "DF",
      "activated_date": "2019-06-29",
    },
    {
      "id": 103,
      "name": "ETC",
      "activated_date": "2019-06-29",
    },
    {
      "id": 104,
      "name": "PS",
      "activated_date": "2019-06-30",
    },
    {
      "id": 105,
      "name": "DBS[A]²",
      "activated_date": "2019-06-28",
    },
    {
      "id": 106,
      "name": "DF[B]",
      "activated_date": "2019-06-30",
    }
  ];

  isActivated(item) {
    var date = DateTime.parse(item["activated_date"]);
    var today = DateTime.now();

    if (date.difference(today).inDays == 0) {
      return true;
    }
    return false;
  }

  getListView() {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        var item = items[index];

        return Card(
          child: ListTile(
            title: Row(
              children: <Widget>[
                Text(item["name"]),
                Spacer(),
                Switch(
                  value: isActivated(item),
                  onChanged: (value) {},
                  activeTrackColor: Colors.lightGreenAccent,
                  activeColor: Colors.green,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    test();
  }

  Future test() async {
    var response =
        await http.get("http://192.168.43.82/sajiweb/public/api/get-all/users");
    print("Callback : " + response.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Checklist"),
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: getListView(),
      ),
    );
  }
}

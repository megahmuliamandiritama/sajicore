import 'package:extremecore/_plugin/extreme/button/template/ibutton.dart';
import 'package:extremecore/_plugin/extreme/location_picker/ex_location_picker.dart';
import 'package:extremecore/core.dart';
import 'package:extremecore/view/detail_page/checklist_example.dart';
import 'package:extremecore/view/page/order/example_checklist.dart';
import 'package:extremecore/view/page/order/example_list.dart';
import 'package:extremecore/view/page/swiper-example/swiper_example.dart';
import 'package:extremecore/view/page/timeline-example/timeline.dart';
import 'package:flutter/material.dart';

class DebugPage extends StatefulWidget {
  @override
  _DebugPageState createState() => _DebugPageState();
}

class _DebugPageState extends State<DebugPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ExButton(
              label: "Timeline Example",
              icon: Icons.timeline,
              type: ButtonType.primary,
              onPressed: () {
                Page.show(context, TimelineExamplePage());
              },
            ),
            ExButton(
              label: "Swiper Example",
              icon: Icons.timeline,
              type: ButtonType.primary,
              onPressed: () {
                Page.show(context, SwiperExamplePage());
              },
            ),
            ExLocationPicker(
              id: "location",
              lat: 0,
              lng: 0,
              placeId: "",
            ),
            Text(Input.get("placeId") == null
                ? ""
                : Input.get("placeId").toString()),
            Text(Input.get("lat") == null ? "" : Input.get("lat").toString()),
            Text(Input.get("lng") == null ? "" : Input.get("lng").toString()),
            ExButton(
              label: "GetLocation",
              icon: Icons.timeline,
              type: ButtonType.primary,
              onPressed: () {
                var placeId = Input.get("placeId");
                var lat = Input.get("lat");
                var lng = Input.get("lng");

                print("placeId : $placeId");
                print("lat : $lat");
                print("lng : $lng");
              },
            ),
            IButton(
              label: "Example List",
              onPressed: () {
                Page.show(context, ExampleList());
              },
            ),
            IButton(
              label: "Example Checklist",
              onPressed: () {
                Page.show(context, ExampleChecklist());
              },
            ),
            IButton(
              label: "Save List",
              onPressed: () async {
                var items = [
                  {
                    "product_id": 1001,
                    "product_name": "SM MILD 12",
                    "price": 15600,
                    "stock": 90,
                  },
                  {
                    "product_id": 1002,
                    "product_name": "SK KRETEK 12",
                    "price": 12600,
                    "stock": 50,
                  },
                  {
                    "product_id": 1003,
                    "product_name": "GG MILD 12",
                    "price": 12500,
                    "stock": 150,
                  },
                ];
                await LocalStorage.save("product", json.encode(items));
                print("Data Saved!");
              },
            ),
            IButton(
              label: "Load List",
              onPressed: () async {
                var items = await LocalStorage.load("product");
                List decodedItems = json.decode(items);
                print(decodedItems);
                print(decodedItems.length);

                var products = decodedItems;

                var prod =
                    products.where((product) => product["product_id"] == 1003);
                print("Your Selected Item");
                print(prod);
              },
            ),
            IButton(
              label: "Secure DIO",
              onPressed: () async {},
            ),
            IButton(
              label: "Checklist Example",
              onPressed: () {
                Page.show(context, ChecklistExamplePage());
              },
            ),
            Text("Connected to ${Session.host}"),
          ],
        ),
      ),
    );
  }
}

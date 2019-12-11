import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SwiperExamplePage extends StatefulWidget {
  SwiperExamplePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SwiperExamplePageState createState() => new _SwiperExamplePageState();
}

class _SwiperExamplePageState extends State<SwiperExamplePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Swiper(
        itemBuilder: (BuildContext context, int index) {
          return new Image.network(
            "http://via.placeholder.com/350x150",
            fit: BoxFit.fill,
          );
        },
        itemCount: 3,
        pagination: new SwiperPagination(),
        control: new SwiperControl(),
      ),
    );
  }
}

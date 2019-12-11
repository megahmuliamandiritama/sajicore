import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExImage extends StatefulWidget {
  final String photo;
  final double height;
  final double width;
  final BoxShape shape;
  final BoxFit fit;

  ExImage({
    @required this.photo,
    this.height = 90,
    this.width = 90,
    this.shape = BoxShape.circle,
    this.fit = BoxFit.fill,
  });

  @override
  _ExImageState createState() => _ExImageState();
}

class _ExImageState extends State<ExImage> {
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  String urlPhoto = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    urlPhoto = widget.photo;

    return widget.photo == null
        ? Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Session.themeColor,
              shape: widget.shape,
              image: DecorationImage(
                fit: widget.fit,
                image: AssetImage("assets/images/no_pict.png"),
              ),
            ),
          )
        : Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: Session.themeColor,
              shape: widget.shape,
              image: DecorationImage(
                fit: widget.fit,
                image: NetworkImage("${Session.storageUrl}/$urlPhoto"),
              ),
            ),
          );
  }
}

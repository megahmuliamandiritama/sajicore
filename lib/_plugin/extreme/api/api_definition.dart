import 'package:extremecore/core.dart';

class ApiDefinition {
  final String endpoint;
  final String primaryKey;
  final String leadingPhotoIndex;
  final String titleIndex;
  final String subtitleIndex;
  // final String subText1;
  // final String subText2;

  //aditional field
  final String headerLeft;
  final String headerRight;

  final String footerLeft;
  final String footerRight;

  //paging & filter & sorting
  final int pageCount;
  final Map<String, dynamic> where;
  final String sortField;
  final String sortOrder;

  ApiDefinition({
    @required this.endpoint,
    @required this.primaryKey,
    @required this.leadingPhotoIndex,
    @required this.titleIndex,
    @required this.subtitleIndex,
    // this.subText1,
    // this.subText2,

    //! Will Be Removed, because Custom Item Template
    this.headerLeft,
    this.headerRight,
    this.footerLeft,
    this.footerRight,
    //###

    this.pageCount = 10,
    this.where,
    this.sortField,
    this.sortOrder: "asc",
  });
}

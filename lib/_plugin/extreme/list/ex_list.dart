import 'package:extremecore/view/partial/saji_appbar.dart';
import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class ExList extends StatefulWidget {
  final String title;
  final String beforeTitle;
  final String afterTitle;
  final String beforeSubtitle;
  final String afterSubtitle;
  final ApiDefinition apiDefinition;

  final dynamic onTap;

  final dynamic onItemSelected;

  final bool noFloatingActionButton;
  final bool noActionsButton;
  final bool noAppBar;
  final bool noDelete;
  final bool noContext;

  final formPageTemplate;
  final editPageTemplate;

  final dynamic itemBuilder;
  final String pageType;

  ExList({
    this.title = "",
    this.beforeTitle = "",
    this.afterTitle = "",
    this.beforeSubtitle = "",
    this.afterSubtitle = "",
    @required this.apiDefinition,
    this.onTap,
    this.onItemSelected,
    this.noFloatingActionButton = false,
    this.noActionsButton = false,
    this.noAppBar = false,
    this.noDelete = false,
    this.noContext = false,
    this.formPageTemplate,
    this.editPageTemplate,
    this.itemBuilder,
    this.pageType = "Normal",
  });

  @override
  EX createState() => EX();
}

class EX extends State<ExList> {
  ApiDefinition apiDefinition;
  RefreshController _refreshController;

  static EX instance;
  static List items = [];
  List itemsBackup = [];
  String nextPageUrl;
  String prevUrl;
  String title;
  String subtitle;
  // String subtext1 = "";
  // String subtext2 = "";

  static reload() {
    EX.instance.setState(() {});
    EX.instance.loadData();
  }

  @override
  void initState() {
    EX.instance = this;
    super.initState();
    apiDefinition = widget.apiDefinition;
    _refreshController = RefreshController();
    loadData();
  }

  bool isLoading = true;
  void loadData() async {
    setState(() {
      isLoading = true;
    });

    // var obj = await Server.getTable(endpoint: apiDefinition.endpoint);

    var whereQuery = "";
    if (apiDefinition.where != null) {
      apiDefinition.where.forEach((key, value) {
        whereQuery += "f_$key=$value&";
      });
      whereQuery = whereQuery.length == 0 ? "" : "?$whereQuery";
    }

    print("WhereQuery");
    print(whereQuery);

    var sortQuery = "";
    if (apiDefinition.sortField != null) {
      if (whereQuery.length == 0) {
        sortQuery = "?";
      } else {
        if (whereQuery.length > 1) {
          sortQuery = "";
        } else {
          sortQuery = "&";
        }
      }
      sortQuery +=
          "sort_field=${apiDefinition.sortField}&sort_order=${apiDefinition.sortOrder}";
    }

    // var url = Session.apiUrl + "/table/${apiDefinition.endpoint}$whereQuery$sortQuery";
    var url = Session.apiUrl + "/get-all/${apiDefinition.endpoint}$whereQuery$sortQuery";
    print(url);
    var response = await http.get(url);

    print(response.toString());
    var obj = response;

    print("ExList LoadData : $url");

    if (this.mounted) {
      setState(() {
        items = obj["data"];
        itemsBackup = items;
        nextPageUrl = obj["next_page_url"];
        isLoading = false;

        _refreshController.refreshCompleted();
      });
    }
  }

  void _deleteData(item) async {
    var id = item[apiDefinition.primaryKey];
    var url = Session.getApiUrl(
      endpoint: "delete/${apiDefinition.endpoint}/$id",
    );
    await http.post(url, {
      "id": id,
    });
  }

  void loadNextPage(url) async {
    print("Loading Data from $url");

    var response = await http.get(url);
    var obj = response;

    print(obj);
    setState(() {
      items += obj["data"];
      nextPageUrl = obj["next_page_url"];

      if (nextPageUrl == null) {
        _refreshController.loadNoData();
      } else {
        _refreshController.loadComplete();
      }
    });
  }

  void _onRefresh() {
/*.  after the data return,
use _refreshController.refreshComplete() or refreshFailed() to end refreshing
*/
    loadData();

// Future.delayed(const Duration(milliseconds: 500), () {
//   _refreshController.refreshCompleted();
// });
  }

  void _onLoading() async {
/* 
use _refreshController.loadComplete() or loadNoData() to end loading
*/

    if (nextPageUrl == null) {
      _refreshController.loadComplete();
    } else {
      loadNextPage(nextPageUrl);
    }

// Future.delayed(const Duration(seconds: 500), () {
//   _refreshController.loadNoData();
// });
  }

  void _showSortOptions(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: Text(
                    "Sort By:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                ListTile(
                    leading: Icon(Icons.sort),
                    title: Text('Newest Item'),
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.sort_by_alpha),
                  title: Text('A - Z'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<bool> confirmDismiss(BuildContext context, String action) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Do you want to $action this item?'),
          actions: <Widget>[
            FlatButton(
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false); // showDialog() returns false
              },
            ),
            FlatButton(
              child: const Text('Yes'),
              onPressed: () {
                Navigator.pop(context, true); // showDialog() returns true
              },
            ),
          ],
        );
      },
    );
  }

  onItemTap(item) {
    if (widget.onItemSelected != null) {
      widget.onItemSelected(item);
      Navigator.of(context).pop();
      return;
    }

    if (widget.onTap != null) {
      widget.onTap();
      return;
    }

    if (widget.formPageTemplate != null) {
      Input.set("selectedId", item[widget.apiDefinition.primaryKey]);
      Page.show(context, widget.formPageTemplate).then((hook) {
        loadData();
        setState(() {
          items = [];
        });
      });
    } else {
      SweetAlert.show(
        context,
        title: "Please add Property FormPageTemplate to ExList declaration!",
      );
    }
  }

  getDefaultItemTemplate(context, item, index) {
    print(item[apiDefinition.titleIndex]);

    if (apiDefinition.titleIndex != null) {
      title = item[apiDefinition.titleIndex].toString();
      if (Input.isNumeric(title)) {
        title = Input.setThousandSeparator(
            item[apiDefinition.titleIndex].toString());
      }
      title = widget.beforeTitle + title + widget.afterTitle;
    }

    print(apiDefinition.subtitleIndex);
    if (apiDefinition.subtitleIndex != null) {
      subtitle = item[apiDefinition.subtitleIndex].toString();
      if (Input.isNumeric(subtitle)) {
        subtitle = Input.setThousandSeparator(
            item[apiDefinition.subtitleIndex].toString());
      }
      subtitle = widget.beforeSubtitle + subtitle + widget.afterSubtitle;
    }

    // print(apiDefinition.subText1);
    // if (apiDefinition.subText1 != null) {
    //   subtext1 = item[apiDefinition.subText1].toString();
    //   if (Input.isNumeric(subtext1)) {
    //     subtext1 = Input.setThousandSeparator(
    //         item[apiDefinition.subText1].toString());
    //   }
    // }

    // if (apiDefinition.subText2 != null) {
    //   subtext2 = item[apiDefinition.subText2].toString();
    //   if (Input.isNumeric(subtext2)) {
    //     subtext2 = Input.setThousandSeparator(
    //         item[apiDefinition.subText2].toString());
    //   }
    // }

    if (widget.itemBuilder != null) {
      return widget.itemBuilder(context, item, index);
    }

    return InkWell(
      onTap: () {
        onItemTap(item);
      },
      child: Card(
        child: Column(
          children: <Widget>[
            ListTile(
              leading: apiDefinition.leadingPhotoIndex != null
                  ? Container(
                      width: 60.0,
                      height: 60.0,
                      child: FadeInImage(
                        placeholder:
                            AssetImage("assets/gif/saji_logo_only_black.gif"),
                        image: item[apiDefinition.leadingPhotoIndex] != null
                            ? NetworkImage(
                                "${Session.storageUrl}/${item[apiDefinition.leadingPhotoIndex]}")
                            : AssetImage("assets/images/no_pict.png"),
                      ),
                      // child: CachedNetworkImage(
                      //   imageUrl:
                      //       "${Session.publicUrl}/aaaaaaaaaaaaaaaaa${item[apiDefinition.leadingPhotoIndex]}",
                      //   placeholder: (context, url) => Image.asset(
                      //       "assets/images/saji_logo_only_black.gif"),
                      //   errorWidget: (context, url, error) =>
                      //       Image.asset("assets/images/no_pict.png"),
                      // ),
                    )
                  : null,
              title: apiDefinition.titleIndex != null ? Text(title) : null,
              subtitle: 
              apiDefinition.subtitleIndex != null ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(subtitle),
                            // subtext1 == "" ? Container () : Text(subtext1),
                            // subtext2 == "" ? Container () : Text(subtext2),
                          ],
                        )
                  : null,

              // title: apiDefinition.titleIndex != null
              //     ? Text(item[apiDefinition.beforeTitle].toString() +
              //         item[apiDefinition.titleIndex].toString() +
              //         item[apiDefinition.afterTitle].toString())
              //     : null,
              // subtitle: apiDefinition.subtitleIndex != null
              //     ? Text(item[apiDefinition.beforeSubtitle] +
              //         item[apiDefinition.subtitleIndex].toString() +
              //         item[apiDefinition.afterSubtitle])
              //     : null,

              // title: apiDefinition.titleIndex != null
              //     ? Text(beforeTitle +
              //         title +
              //         afterTitle)
              //     : null,
              // subtitle: apiDefinition.subtitleIndex != null
              //     ? Text(beforeSubtitle +
              //         subtitle +
              //         afterSubtitle)
              //     : null,
            ),
          ],
        ),
        semanticContainer: true,
      ),
    );
  }

  PreferredSize buildSearchBar() {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.all(2.0),
        child: Card(
          child: Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    // autofocus: true,
                    onChanged: (text) {
                      var search = text.toString().toLowerCase();
                      items = itemsBackup;
                      items = items
                          .where((i) =>
                              i[apiDefinition.titleIndex]
                                  .toString()
                                  .toLowerCase()
                                  .indexOf(search) >
                              -1)
                          .toList();
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Search by Name",
                      hintStyle: TextStyle(
                        fontFamily: 'RobotoLight',
                        fontSize: 15,
                        color: Color(0xffC0C0C0),
                      ),
                      icon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.search,
                          size: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      preferredSize: Size.fromHeight(80.0),
    );
  }

  getAppBar() {
    return widget.noAppBar
        ? null
        : Session.appName == "Saji"
            ? Saji.getAppBar(
                context: widget.noContext ? null : context,
                title: widget.title,
                hasBottom: false,
                actions: widget.noActionsButton == true
                    ? []
                    : [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: InkWell(
                        //     onTap: () {
                        //       _showSortOptions(context);
                        //     },
                        //     child: Icon(Icons.sort),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Icon(Icons.search),
                        // )
                      ])
            : Saji.getAppBar(
                context: widget.noContext ? null : context,
                title: widget.title,
                hasBottom: false,
                actions: widget.noActionsButton == true
                    ? []
                    : [
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: InkWell(
                        //     onTap: () {
                        //       _showSortOptions(context);
                        //     },
                        //     child: Icon(Icons.sort),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Icon(Icons.search),
                        // )
                      ]);
  }

  getMainContent() {
    if (isLoading) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(child: Image.asset("assets/gif/saji_cropped_breath.gif")),
            Container(
              height: 20.0,
            ),
            Text(
              "Loading",
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    if (items.length == 0) {
      Input.set("no_data", true);
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.3,
            ),
            Center(
              child: Image(
                height: MediaQuery.of(context).size.width * 0.25,
                width: MediaQuery.of(context).size.width * 0.25,
                image: AssetImage("assets/images/empty_list.png"),
              ),
            ),
            // Text(
            //   "No Data",
            //   style: TextStyle(
            //     fontSize: MediaQuery.of(context).size.width * 0.05,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.03,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.red[100],
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
              child: Text(
                "You can add " + widget.title + " by pressing (+) button",
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      );
    }
    Input.set("no_data", false);
    print("Load Data Ex_list");

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          widget.noDelete
              ? Container()
              : Container(
                  child: Text(
                    "<<< swipe to delete >>>",
                    style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
          Container(
            height: widget.pageType == "Normal"
                ? MediaQuery.of(context).size.height * 0.75
                : MediaQuery.of(context).size.height * 0.72,
            child: SmartRefresher(
              enablePullDown: true,
              enablePullUp: true,
              header: WaterDropHeader(
                complete: Wrap(
                  children: [
                    Icon(
                      Icons.check_box,
                      color: Colors.green,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Text(
                        "Success",
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              controller: _refreshController,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  var item = items[index];

                  if (widget.noDelete) {
                    return getDefaultItemTemplate(context, item, index);
                  }

                  return Dismissible(
                    key: Key(item[apiDefinition.primaryKey].toString()),
                    confirmDismiss: (DismissDirection dismissDirection) {
                      confirmDismiss(context, 'delete').then((bool value) {
                        if (value) {
                          SweetAlert.show(context,
                              style: SweetAlertStyle.success,
                              title: "Success delete data");
                          setState(
                            () {
                              _deleteData(item);
                              items.removeAt(index);
                            },
                          );
                        }
                      });
                      return;
                    },
                    onDismissed: (direction) {},
                    background: Container(color: Colors.red),
                    child: getDefaultItemTemplate(context, item, index),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.pageType != "Normal" ? null : getAppBar(),
        resizeToAvoidBottomPadding: false,
        floatingActionButton: widget.noFloatingActionButton == true
            ? Container()
            : Container(
                margin: widget.pageType != "Normal"
                    ? EdgeInsets.only(bottom: 50.0)
                    : null,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your onPressed code here!

                    Input.set("selectedId", null);
                    if (widget.formPageTemplate != null) {
                      Page.show(context, widget.formPageTemplate).then((hook) {
                        loadData();
                        setState(() {
                          items = [];
                        });
                      });
                    } else {
                      SweetAlert.show(
                        context,
                        title:
                            "Please add Property AddPageTemplate to ExList declaration!",
                      );
                    }
                  },
                  child: Icon(FontAwesomeIcons.plus),
                  backgroundColor: Colors.grey[800],
                ),
              ),
        body: Column(
          children: <Widget>[
            buildSearchBar(),
            getMainContent(),
          ],
        ));
  }
}

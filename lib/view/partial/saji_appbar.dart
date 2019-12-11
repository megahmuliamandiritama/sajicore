import 'package:extremecore/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Saji {
  static getAppBar({
    @required String title,
    BuildContext context,
    List<Widget> actions,
    bool hasBottom = false,
    TabController tabController,
    String tabBar1 = "",
    String tabBar2 = "",
    String tabBar3 = "",
    String tabBar4 = "",
    dynamic onBack,
  }) {
    getTitle() {
      return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/saji_bg_finger.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                if(onBack!=null){
                  onBack();
                  return;
                }
                Navigator.of(context).pop();
              },
              child: context != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.arrow_back),
                    )
                  : Container(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Image.asset(
                'assets/images/saji_logo_only.png',
                height: 30.0,
                width: 30.0,
              ),
            ),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            Spacer(),
            actions != null
                ? Row(
                    children: actions,
                  )
                : Container(),
          ],
        ),
      );
    }

    getTabs() {
      List<Tab> tabs =[];

      // [
      //   tabBar1 == "" ? Tab(
      //     text: tabBar1,
      //   ) : Container(),
      //   tabBar2 == "" ? Tab(
      //     text: tabBar2,
      //   ) : Container(),
      //   tabBar3 == "" ? Tab(
      //     text: tabBar3,
      //   ) : Container(),
      //   tabBar4 == "" ? Tab(
      //     text: tabBar4,
      //   ) : Container(),
      // ]

      if (tabBar1 != "") {
        tabs.add(Tab(text: tabBar1));
      }
      if (tabBar2 != "") {
        tabs.add(Tab(text: tabBar2));
      }
      if (tabBar3 != "") {
        tabs.add(Tab(text: tabBar3));
      }
      if (tabBar4 != "") {
        tabs.add(Tab(text: tabBar4));
      }

      return tabs;
    }

    getBottom() {
      return TabBar(
        indicatorColor: Colors.yellow[200],
        controller: tabController,
        tabs: getTabs(),
      );
    }

    return hasBottom
        ? AppBar(
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Session.themeColor,
            title: getTitle(),
            bottom: getBottom(),
          )
        : AppBar(
            titleSpacing: 0.0,
            automaticallyImplyLeading: false,
            backgroundColor: Session.themeColor,
            title: getTitle(),
          );
  }
}

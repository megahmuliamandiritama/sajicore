import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    login(pageContext) async {
      Alert.showSuccess(
        context: context,
        message: "Hello World",
      );
    }

    selectUserDemo(context) {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text('Owner'),
                  onTap: () {
                    Input.controllerList["email"].text = "admin@gmail.com";
                    Input.controllerList["password"].text = "123456";
                    Navigator.of(context).pop();
                    login(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text('Manager'),
                  onTap: () {
                    Input.controllerList["email"].text = "manager@gmail.com";
                    Input.controllerList["password"].text = "123456";
                    Navigator.of(context).pop();
                    login(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text('Waiter'),
                  onTap: () {
                    Input.controllerList["email"].text = "waiter@gmail.com";
                    Input.controllerList["password"].text = "123456";
                    Navigator.of(context).pop();
                    login(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text('Kitchen'),
                  onTap: () {
                    Input.controllerList["email"].text = "kitchen@gmail.com";
                    Input.controllerList["password"].text = "123456";
                    Navigator.of(context).pop();
                    login(context);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.verified_user),
                  title: Text('Cashier'),
                  onTap: () {
                    Input.controllerList["email"].text = "cashier@gmail.com";
                    Input.controllerList["password"].text = "123456";
                    Navigator.of(context).pop();
                    login(context);
                  },
                ),
              ],
            );
          });
    }

    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
        textSelectionColor: Colors.white,
        textSelectionHandleColor: Colors.white,
        hintColor: Colors.white,
        cursorColor: Colors.white,
        accentColor: Colors.green,
      ),
      child: WillPopScope(
        onWillPop: () {
          return;
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Image.network(
                    "https://www.exhibitionrp.com/uploads/monthly_2017_06/5942397f0975a_Websitepicture.jpg.be315e37efd1eed9c7316fd1b84b57e1.jpg",
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitHeight,
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                      ),
                      InkWell(
                        onTap: () {
                          //if (!kReleaseMode) {
                          selectUserDemo(context);
                          //}
                        },
                        child: Image.network(
                          "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/ce/37/e5/ce37e528-a855-08a5-a556-83c8eb424750/AppIcon-0-1x_U007emarketing-0-0-GLES2_U002c0-512MB-sRGB-0-0-0-85-220-0-0-0-8.png/246x0w.jpg",
                          height: 140,
                          width: 140,
                        ),
                      ),
                      Container(
                        height: 50,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ExButton(
                            icon: FontAwesomeIcons.google,
                            label: "Google SignIn",
                            type: ButtonType.success,
                            onPressed: () {
                              login(context);
                            },
                          ),
                          Container(width: 6.0),
                          ExButton(
                            icon: FontAwesomeIcons.userNinja,
                            label: "Guest SignIn",
                            type: ButtonType.info,
                            onPressed: () {
                              login(context);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

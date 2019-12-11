import 'package:extremecore/_plugin/extreme/api/post_response.dart';
import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class Server {
  static Future<PostResponse> create({
    String endpoint,
    dynamic body,
  }) async {
    var url = Session.getApiUrl(
      endpoint: "create/$endpoint",
    );

    var response = await dio.post(url, data: body);

    var obj;
    try {
      obj = json.decode(response.data);
      print("Response:");
      print(obj);
      return Future.value(PostResponse.fromJson(obj));
    } catch (ex) {
      print("Can't convert json to object");
      print("Response Body:");
      print(response.statusCode);
      print(response.data);
      return Future.value(PostResponse.fromJson({
        "is_success": "false",
        "message": "Server ERROR, check PHP Script Response for $url",
      }));
    }
  }

  static Future<PostResponse> update({
    String endpoint,
    dynamic body,
  }) async {
    var url = Session.getApiUrl(
      endpoint: "update/$endpoint",
    );

    var response = await dio.post(url, data: body);

    var obj;
    try {
      obj = json.decode(response.data);
      print("Response:");
      print(obj);
      return Future.value(PostResponse.fromJson(obj));
    } catch (ex) {
      print("Can't convert json to object");
      print("Response Body:");
      print(response.statusCode);
      print(response.data);
      return Future.value(PostResponse.fromJson({
        "is_success": "false",
        "message": "Server ERROR, check PHP Script Response for $url",
      }));
    }
  }

  static dynamic get({
    String endpoint,
    int id,
  }) async {
    var url = Session.getApiUrl(
      endpoint: "get/$endpoint/$id",
    );

    var response = await dio.get(url);

    var obj;
    try {
      obj = json.decode(response.data);

      print("-----");
      print("Loaded Data:");
      print(obj);
      print("-----");

      return obj;
    } catch (ex) {
      print("Can't convert json to object");
      print("Response Body:");
      print(response.statusCode);
      print(response.data);
    }

    var postResponse = PostResponse.fromJson({
      "is_success": "false",
      "message": "Server ERROR, check PHP Script Response for $url",
    });

    return Future.value(postResponse);
  }

  static dynamic getTable({
    String endpoint,
    int id,
  }) async {
    List<ParameterValue> params = [];
    params.add(ParameterValue(
      key: "page_count",
      value: 10,
    ));

    var url = Session.getApiUrl(
      endpoint: "table/$endpoint",
      params: params,
    );

    var response = await dio.get(url);

    var obj = response.data;

    return Future.value(obj);
  }
}

class Alert {
  static showSuccess({
    BuildContext context,
    String title,
    String message,
    dynamic onOk,
    dynamic onCancel,
  }) {
    SweetAlert.show(
      context,
      title: title,
      subtitle: message,
      style: SweetAlertStyle.success,
      onPress: (isConfirmed) {
        return true;
      },
    );
    return;
  }

  static showSuccessAndPop({
    BuildContext context,
    String title,
    String message,
    dynamic onOk,
    dynamic onCancel,
  }) {
    SweetAlert.show(
      context,
      title: title,
      subtitle: message,
      style: SweetAlertStyle.success,
      onPress: (isConfirmed) {
        Navigator.of(context).pop();
        return true;
      },
    );
    return;
  }

  // static showError(context, title, message, onConfirmed, onUnconfirmed) {

  static showError({
    BuildContext context,
    String title,
    String message,
    dynamic onOk,
    dynamic onCancel,
  }) {
    SweetAlert.show(
      context,
      title: title,
      subtitle: message,
      style: SweetAlertStyle.error,
      onPress: (isConfirmed) {
        if (isConfirmed) {
          if (onOk != null) {
            onOk();
          }

          if (onCancel != null) {
            onCancel();
          }
        }
        return true;
      },
    );
  }

  static showWarning({
    BuildContext context,
    String title,
    String message,
    dynamic onOk,
    dynamic onCancel,
    bool showCancel = true,
  }) {
    SweetAlert.show(
      context,
      title: title,
      subtitle: message,
      style: SweetAlertStyle.confirm,
      showCancelButton: showCancel,
      onPress: (isConfirmed) {
        if (isConfirmed) {
          if (onOk != null) {
            onOk();
          }

          if (onCancel != null) {
            onCancel();
          }
        }
        return true;
      },
    );
  }

  static showAlertDialog({
    BuildContext context,
    String title,
    String message,
    String strCancel = "Cancel",
    String strOk = "Ok",
    IconData iconCancel = FontAwesomeIcons.times,
    IconData iconOk = FontAwesomeIcons.check,
    dynamic onOk,
    bool showCancel = true,
    bool barrierDismissable = true,
  }) {
    showDialog(
        barrierDismissible: barrierDismissable,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: <Widget>[
              showCancel == false ? Container() : ExButton(
                label: "Cancel",
                icon: iconCancel,
                type: ButtonType.themeButtonColor,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ExButton(
                label: "Confirm",
                icon: iconOk,
                type: ButtonType.themeButtonColor,
                onPressed: () {
                  if (onOk != null) {
                    onOk();
                  }
                },
              ),
            ],
          );
        });
  }
}

class Loading {
  static show() {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text("Loading..."),
        ),
      ),
    );
  }
}

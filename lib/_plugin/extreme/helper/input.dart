import 'package:flutter/material.dart';
import 'package:extremecore/core.dart';

class Input {
  static Map<String, dynamic> valueList = HashMap();
  static Map<String, TextEditingController> controllerList = HashMap();

  static get(String id) {
    return valueList[id];
  }

  static set(String id, dynamic value) {
    valueList[id] = value;
  }

  static setAndUpdate(String id, dynamic value) {
    controllerList[id].text = value;
    // valueList[id] = value;
  }

  static setThousandSeparator(dynamic param) {
    double number = double.parse(param.toString());
    final formatter = NumberFormat("###,###.##", "id-ID");
    return formatter.format(number);
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return double.parse(
          s,
          (e) => null,
        ) !=
        null;
  }

  static getValueOnEdit(key, isEdit) {
    if (isEdit) {
      // print("isedit is true");
      return Input.get(key).toString();
    } else {
      // print("isedit is false");
      return null;
    }
  }

  static generateFormData() {
    Input.controllerList.forEach((key, textEditingController) {
      if (key.indexOf("email") > -1) {
        textEditingController.text =
            "saji." + Random().nextInt(100000).toString() + "@mailinator.com";
      } else if (key.indexOf("name") > -1) {
        textEditingController.text = "Mr. John";
      } else if (key.indexOf("mobile") > -1 || key.indexOf("phone") > -1) {
        textEditingController.text = "+62" + min(10000000, 90000000).toString();
      } else {
        textEditingController.text = min(10000000, 90000000).toString();
      }
    });
  }
}

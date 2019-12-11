import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class Session {
  //User Data
  static String userId;
  static String username;
  static int branchId;
  static int idPrivileges;
  static String userLevel = "Owner"; 
  static String email;
  static String password;
  static String mobile;
  static String gopayQrCode;
  static String ovoQrCode;
  static String danaQrCode;
  static String membershipLevel;
  static dynamic expiredDate;
  static dynamic serverDate;
  static int isCompleteWizard;
  static String appName = "";

  static bool isLogin = false;
  static BluetoothDevice device;
  static bool connected = false;
  static bool pressed = false;
  static bool expiredNoted = false;
  static bool allowedToPrint = false;

  //? Colors
  static Color themeButtonColor = Color(0xffe44c5a);
  static Color themeColor = Color(0xffA40C33);
  static Color colorOccupied = Color(0xffDFC7B4);
  static Color colorEmpty = Color(0xff8A8989);
  static Color color01 = Color(0xff6B4595);
  static Color color02 = Color(0xff335AA6);
  static Color color03 = Color(0xff71C9E4);
  static Color color04 = Color(0xff9CCC93);
  static Color color05 = Color(0xffD0CA03);
  static Color color06 = Color(0xffFFDC2E);
  static Color color07 = Color(0xffCE8B0B);
  static Color color08 = Color(0xffF28F5F);
  static Color color09 = Color(0xffD991BE);
  static Color color10 = Color(0xffDB6363);
  static Color color11 = Color(0xffE6690B);
  static Color color12 = Color(0xffE8441E);





  //! URL SETTING
  static String host = "";
  static String baseUrl = "$host/public/admin";
  static String apiUrl = "$host/public/api";
  static String publicUrl = "$host/public";
  static String storageUrl = "$host/storage/app";

  static String lastBuildTime = "";

  static String getAssetUrl(String imageUrl) {
    // print("getAssetUrl");
    // print("$host/public/" + imageUrl);
    // return "$host/public/" + imageUrl;
    // print("getAssetUrl");
    // print("$storageUrl/" + imageUrl);
    return "$storageUrl/" + imageUrl;
  }

  static String getUrl({
    String endpoint = "",
  }) {
    var singleviewmodestr = endpoint.indexOf("?") == -1
        ? "?singleviewmode=true"
        : "&singleviewmode=true";

    if (endpoint.indexOf("singleviewmode") > -1) {
      singleviewmodestr = "";
    }

    return baseUrl + (endpoint != "" ? "/" + endpoint + singleviewmodestr : "");
  }

  static String getApiUrl({
    String endpoint = "",
    List<ParameterValue> params = const [],
  }) {
    var queryString = "";
    if(params.length>0){
      queryString = "?";

      for(var param in params){
        var key = param.key;
        var value = param.value.toString();
        queryString += "$key=$value";
      }
    }

    var url = apiUrl + (endpoint != "" ? "/" + endpoint + queryString: "");
    print("Request URL: " + url);
    return url;
  }

  static bool isDeveloperMode = false;
}


class ParameterValue {
  final String key;
  final dynamic value;
  ParameterValue({
    @required this.key,
    @required this.value,
  });
}
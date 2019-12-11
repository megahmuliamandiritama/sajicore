import 'dart:async';
import 'package:extremecore/core.dart';
import 'package:flutter/material.dart';

var cachedEndpoint = [
  "product",
  "product_category",
  "product_station",
];

class ExtremeHttp {
  //Event
  static dynamic onBranchedEndpoint;
  static dynamic onUndefinedError;

  static dynamic onConnectTimeout;
  static dynamic onSendTimeout;
  static dynamic onReceiveTimeout;
  static dynamic onInternetConnectionProblem;

  BuildContext httpContext;
  String httpUrl;
  String httpMethod;
  String httpPostData;
  String httpResponse;

  int maxRetryCount = 3;

  ExtremeHttp() {
    // dio.options.connectTimeout = 5000;
    // dio.options.sendTimeout = 1000;
    // dio.options.receiveTimeout = 1000;
  }

  Future<dynamic> get(
    String url, {
    bool isCached = false,
  }) async {
    bool requestDone = false;
    int requestCount = 0;
    var returnedResponse;

    dio.clear();

    while (requestDone == false) {
      print("GET: " + url);
      try {
        var response = await dio.get(url);
        handleUserDefinedError(response.data);
        requestDone = true;
        returnedResponse = response.data;

        print("GetResponse: ");
        print(returnedResponse);
        print("~~~~~~~~~~~~~~");

        httpUrl = url;
        httpMethod = "GET";
        httpPostData = "";
        httpResponse = returnedResponse;
      } catch (error) {
        // String prodHost = "http://192.168.6.234/sajiweb";
        // String devHost = "http://192.168.43.82/sajiweb";

        // Session.host = "http://192.168.6.333/sajiweb";
        requestCount++;
        if (requestCount <= maxRetryCount) {
          print("Retry Connection To: $url   $requestCount/$maxRetryCount");
        } else {
          handleDioError(error);
          requestDone = true;
          returnedResponse = null;
        }
      }
    }

    return Future.value(returnedResponse);
  }

  Future<dynamic> post(String url, dynamic postData) async {
    bool requestDone = false;
    int requestCount = 0;
    var returnedResponse;

    while (requestDone == false) {
      print("----------------");
      print("POST: " + url);
      print("PostData: ");
      print(postData);
      print("################");

      try {
        var response = await dio.post(url, data: postData);
        handleUserDefinedError(response.data);
        requestDone = true;
        returnedResponse = response.data;

        print("PostResponse: ");
        print(returnedResponse);
        print("~~~~~~~~~~~~~~");

        httpUrl = url;
        httpMethod = "POST";
        httpPostData = postData;
        httpResponse = returnedResponse;
      } catch (error) {
        requestCount++;
        if (requestCount <= maxRetryCount) {
          print("Retry Connection To: $url $requestCount/$maxRetryCount");
        } else {
          handleDioError(error);
          requestDone = true;
          returnedResponse = null;
        }
      }
    }

    return Future.value(returnedResponse);
  }

  handleUserDefinedError(responseData) {
    if (responseData["error"] == true) {
      switch (responseData["error_code"]) {
        case "BRANCHED_ENDPOINT":
          if (ExtremeHttp.onBranchedEndpoint != null) {
            ExtremeHttp.onBranchedEndpoint();
          }
          print(responseData["message"]);
          print(responseData);
          break;
        default:
          if (ExtremeHttp.onUndefinedError != null) {
            ExtremeHttp.onUndefinedError();
          }
          print("Undefined UserDefined Error");
          print(responseData);
          break;
      }
    }
  }

  handleDioError(error) {
    print(":: Dio Error ::");
    print(error);
    if (error is DioError) {
      var errorDescription;
      switch (error.type) {
        case DioErrorType.CANCEL:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.CONNECT_TIMEOUT:
          errorDescription = "Connection timeout with API server";
          if (ExtremeHttp.onConnectTimeout != null) {
            ExtremeHttp.onConnectTimeout();
          }
          break;
        case DioErrorType.DEFAULT:
          errorDescription =
              "Connection to API server failed due to internet connection";
          if (ExtremeHttp.onInternetConnectionProblem != null) {
            ExtremeHttp.onInternetConnectionProblem();
          }
          break;
        case DioErrorType.RECEIVE_TIMEOUT:
          errorDescription = "Receive timeout in connection with API server";
          if (ExtremeHttp.onReceiveTimeout != null) {
            ExtremeHttp.onReceiveTimeout();
          }
          break;
        case DioErrorType.SEND_TIMEOUT:
          errorDescription = "Send timeout in connection with API server";
          if (ExtremeHttp.onSendTimeout != null) {
            ExtremeHttp.onSendTimeout();
          }
          break;
        case DioErrorType.RESPONSE:
          errorDescription =
              "Received invalid status code: ${error.response.statusCode}";
          print(error.response);
          print(error.response.data);
          break;
        default:
          errorDescription = "### UNDEFINED ERROR ###";
          errorDescription += error;
          break;
      }
      print(errorDescription);
    }
  }
}

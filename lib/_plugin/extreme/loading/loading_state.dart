import 'package:flutter/material.dart';

class LoadingState {
  static String loading = "LOADING";
  static String noData = "NO_DATA";
  static String serverError = "SERVER_ERROR";
  static String serverTimeout = "SERVER_TIMEOUT";
}

class LoadingUI {
  showLoading(context) {
    return Center(
      child: Text("Loading..."),
    );
  }

  showNoData(context) {
    return Center(
      child: Text("No Data"),
    );
  }

  showServerError(context) {
    return Center(
      child: Text("Server Error"),
    );
  }
}

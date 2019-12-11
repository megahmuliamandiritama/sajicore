export 'dart:convert';
export 'package:pull_to_refresh/pull_to_refresh.dart';
export 'package:sweetalert/sweetalert.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'dart:io';
export 'package:image_picker/image_picker.dart';
export 'package:meta/meta.dart';

export 'dart:collection';
export 'package:intl/intl.dart';
export 'package:sqflite/sqflite.dart';

export 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
export 'package:numberpicker/numberpicker.dart';
export 'package:auto_size_text/auto_size_text.dart';

export 'package:flutter/services.dart';
export 'package:badges/badges.dart';

export 'package:timeline_list/timeline.dart';
export 'package:timeline_list/timeline_model.dart';

export 'package:dio/dio.dart';

export 'dart:math';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:extremecore/_plugin/extreme/api/http.dart';

import './_plugin/extreme/api/server_api.dart';
import '_plugin/extreme/api/api.dart';

import 'package:dio/dio.dart';

var srv = ServerApi();
var api = Api();
var dio = Dio();

class ExtremeCore {
  init() {
    dio.interceptors.add(CookieManager(CookieJar()));
    // dio.options.connectTimeout = 10000;
    // dio.options.receiveTimeout = 10000;
    // dio.options.sendTimeout = 10000;
  }
}

var extremeCore = ExtremeCore();
var http = ExtremeHttp();

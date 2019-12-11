import 'package:extremecore/core.dart';

import 'mapview.dart';
import 'model.dart';

class GooglePlaceApi {
  static String apiKey = "AIzaSyCdzWC9wcJQix-vmB7nDrJ1sBK6F9bWG2Y";
  static Future<List<GooglePlaceModel>> fetchResult(String query) async {
    var url =
        'https://maps.googleapis.com/maps/api/place/queryautocomplete/json?key=$apiKey&input=$query';

    final response = await dio.get(url);

    Map userMap = response.data;

    final parsed = userMap["predictions"].cast<Map<String, dynamic>>();

    return parsed
        .map<GooglePlaceModel>((json) => GooglePlaceModel.fromJson(json))
        .toList();
  }

  static Future getPlaceDetail(String placeId, String address) async {
    var url =
        "https://maps.googleapis.com/maps/api/place/details/json?placeid=$placeId&fields=name,rating,geometry,formatted_phone_number&key=$apiKey";

    final response = await dio.get(url);
    Map resultMap = response.data;

    try {
      print(resultMap["result"]["geometry"]["location"]["lat"]);
      print(resultMap["result"]["geometry"]["location"]["lng"]);

      double lat = resultMap["result"]["geometry"]["location"]["lat"];
      double lng = resultMap["result"]["geometry"]["location"]["lng"];

      Input.set("placeId", placeId);
      Input.set("lat", lat);
      Input.set("lng", lng);

      GoogleMapViewState.updateSelectedMarker(lat, lng, address);

      print("-----------------");
    } catch (e) {
      print(e);
    }
    return null;
  }
}

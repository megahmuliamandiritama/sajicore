import 'package:extremecore/_plugin/extreme/api/http.dart';
import 'package:extremecore/_plugin/extreme/local_storage/local_storage.dart';
import 'package:extremecore/core.dart';

class Product {}

class ProductCategory {}

class ProductStation {}

class ProductAssignedStation {}

class ProductStockAdjustment {}

class ProductStockAdjustmentCategory {}

class ProductVariant {}

List<Product> productList;
List<ProductCategory> productCategoryList;
List<ProductStation> productStationList;
List<ProductAssignedStation> productAssignedStationList;
List<ProductStockAdjustment> productStockAdjustmentList;
List<ProductStockAdjustmentCategory> productStockAdjustmentCategoryList;
List<ProductVariant> productVariantList;

Map<String, List<dynamic>> collectionMap;

Future<List<dynamic>> getCollection(endpoint) async {
  return collectionMap[endpoint];
}

Future<List<dynamic>> getCollectionFromSqlite(endpoint) async {
  var sqliteData = await LocalStorage.load(endpoint);
  collectionMap[endpoint] = json.decode(sqliteData);
  return collectionMap[endpoint];
}

Future saveCollection(endpoint, responseData) async {
  collectionMap[endpoint] = responseData;
  var value = json.encode(responseData);
  await LocalStorage.save(endpoint, value);
}

var endpoints = [
  "product",
  "product_category",
  "product_station",
  "product_assigned_station",
  "product_variant",
  "product_stock_adjustment",
  "product_stock_adjustment_category",
];

ExtremeHttp http = ExtremeHttp();

//All Cache is Handled on ExtremeHttp
Future initCollection() async {
  endpoints.forEach((endpoint) async {
    var url = Session.apiUrl + "/get-all/$endpoint";
    await http.get(url);
  });
}

//TODO: Update List onNotification Update/Insert/Delete
//TODO: Kerepotan menggunakan Model? Gunakan List<dynamic>!

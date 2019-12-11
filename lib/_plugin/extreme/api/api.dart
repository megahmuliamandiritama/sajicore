import 'package:extremecore/_plugin/extreme/api/post_response.dart';
import 'package:extremecore/core.dart';

class Api {
  String endpoint = "no-endpoint";

  Future customUrl(url) async {
    //!Get Table API
    await http.get(url);
  }

  Future<Response> getTable() async {
    var url = Session.getApiUrl(endpoint: "table/${this.endpoint}");
    var response = await http.get(url);
    return Future.value(response);
  }

  Future<Response> getAll() async {
    //!Get All Data Api
    var url = Session.getApiUrl(endpoint: "get-all/${this.endpoint}");
    var response = await http.get(url);
    return Future.value(response);
  }

  Future get(id) async {
    //!Get Single Data Api
    var url = Session.getApiUrl(endpoint: "get/${this.endpoint}/$id");
    var response = await http.get(url);
    return Future.value(response);
  }

  Future<PostResponse> create(postData) async {
    var url = "${Session.host}/public/api/create/${this.endpoint}";
    var response = await http.post(url, postData);
    return Future.value(PostResponse.fromJson(response));
  }

  Future<PostResponse> update(postData) async {
    //!Update Data API
    var url = "${Session.host}/public/api/update/${this.endpoint}";
    var response = await http.post(url, postData);

    return Future.value(PostResponse.fromJson(response));
  }

  Future<Response> delete(id) async {
    //!Delete Data Ap
    var url = Session.getApiUrl(endpoint: "delete/${this.endpoint}/$id");
    var response = await http.post(url, {});
    return Future.value(response);
  }
}

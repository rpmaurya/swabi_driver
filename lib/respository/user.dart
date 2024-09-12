import 'package:flutter_driver/data/app_url.dart';
import 'package:flutter_driver/view_model/services/HttpService.dart';

import '../data/network/base_apiservices.dart';
import '../data/network/network_apiservice.dart';

class UserRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  //user registration
  Future<dynamic> loginApi(dynamic data) async {
    var http = HttpService();
    try {
      dynamic response =
          await _apiServices.getPostWithoutApiResponse(AppUrl.login, data);
      print("registration api success $data");
      return response;
    } catch (e) {
      print("registration api not successful error");
      print(e);
      // http.handleErrorResponse(error: e);
      rethrow;
    }
  }
}

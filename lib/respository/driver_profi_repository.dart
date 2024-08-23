import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/app_url.dart';
import 'package:flutter_driver/data/network/base_apiservices.dart';
import 'package:flutter_driver/data/network/network_apiservice.dart';
import 'package:flutter_driver/data/response/baseResponse.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/view_model/services/HttpService.dart';

///Driver Profile Detail Repo
class DriverProfileRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverBookingListRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices
          .getGetApiResponse('http://swabi.ap-south-1.elasticbeanstalk.com/'
              'driver/get_driver_by_driverId?driverId=${data["driverId"]}');
      print("Driver Profile Repo api success");
      print(response);
      return response = DriverProfileModel.fromJson(response);
    } catch (e) {
      print("Driver Profile api repo not successful error");
      print(e);
      rethrow;
    }
  }
}

class DriverProfileUpdateRepository {
  Future<DriverProfileUpdateModel?> editProfile(
      {required BuildContext context,
      required Map<String, dynamic> body}) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverProfileUpdateEndUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        body: body);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print('response data:--${response?.data}');
      var resp = DriverProfileUpdateModel.fromJson(response?.data);
      return resp;
    } on DioException catch (error) {
      BaseResponseModel baseResponseModel =
          BaseResponseModel.fromJson(error.response?.data);
      print(baseResponseModel.status?.message);

      print({'error..': error});
      http.handleErrorResponse(
          context: context, error: error, errorResponse: baseResponseModel);
    }
    return null;
  }
  // final BaseApiServices _apiServices = NetworkApiService();

  // Future<dynamic> userProfileUpdateRepositoryApi(data) async {
  //   try {
  //     dynamic response = await _apiServices.getPutApiResponseWithData(
  //         "http://swabi.ap-south-1.elasticbeanstalk.com"
  //         "/driver/update_driver_details?driverId=${data["driverId"]}&mobile=${data["mobile"]}",
  //        data);
  //     // dynamic response = await _apiServices.getPutApiResponseWithData(AppUrl.userProfileUpdate, data);
  //     print("Driver Update Repo api success $data");
  //     return response = DriverProfileUpdateModel.fromJson(response);
  //   } catch (e) {
  //     print("Driver Update Repo api not success");
  //     print(e);
  //     rethrow;
  //   }
  // }
}

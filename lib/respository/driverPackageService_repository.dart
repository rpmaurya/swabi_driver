import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/app_url.dart';
import 'package:flutter_driver/data/response/baseResponse.dart';
import 'package:flutter_driver/model/driverPackageModel.dart';
import 'package:flutter_driver/model/driverpackageHistoryModel.dart';
import 'package:flutter_driver/view_model/services/HttpService.dart';

class DriverpackageserviceRepository {
  Future<DriverPackageBookingListModel?> getPackageUpcommingListApi({
    required Map<String, dynamic> query,
    required BuildContext context,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverBookingListUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..packageBooking list': response?.data});

      var resp = DriverPackageBookingListModel.fromJson(response?.data);
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

  Future<DriverPackageDetailModel?> getPackageDetailListApi({
    required Map<String, dynamic> query,
    required BuildContext context,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverBookingDetailListUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..packageBooking list': response?.data});

      var resp = DriverPackageDetailModel.fromJson(response?.data);
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

  Future<DriverActivityStartModel?> startActivityApi({
    required Map<String, dynamic> query,
    required BuildContext context,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverActivityStartUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    print(http);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..package start activity': response});

      var resp = DriverActivityStartModel.fromJson(response?.data ?? {});
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

  Future<DriverActivityCompleteModel?> completeActivityApi({
    required Map<String, dynamic> query,
    required BuildContext context,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverActivityCompleteUrl,
        methodType: HttpMethodType.PUT,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..packageBooking list': response?.data});

      var resp = DriverActivityCompleteModel.fromJson(response?.data);
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

  Future<DriverPackageBookingListModel?> getPackageHistoryListApi({
    required Map<String, dynamic> query,
    required BuildContext context,
  }) async {
    var http = HttpService(
        isAuthorizeRequest: false,
        baseURL: AppUrl.baseUrl,
        endURL: AppUrl.driverPackageHistoryUrl,
        methodType: HttpMethodType.GET,
        bodyType: HttpBodyType.JSON,
        queryParameters: query);
    try {
      Response<dynamic>? response = await http.request<dynamic>();
      print({'response..packageBookingHistory list': response?.data});

      var resp = DriverPackageBookingListModel.fromJson(response?.data);
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
}

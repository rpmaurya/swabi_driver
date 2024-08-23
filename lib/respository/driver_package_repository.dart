import 'package:dio/dio.dart';
import 'package:flutter_driver/data/network/base_apiservices.dart';
import 'package:flutter_driver/data/network/network_apiservice.dart';
import 'package:flutter_driver/model/driverPackageModel.dart';
import 'package:flutter_driver/model/driverpackageHistoryModel.dart';

///Driver Package Booking Repo
class DriverPackageBookingListRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<DriverPackageBookingListModel>
      driverDriverPackageBookingListRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'package_booking/get_package_booking_by_driver_id?driverId=${data["driverId"]}');
      print("Driver Package Booking Completed Repo");
      print(response);
      var respon = DriverPackageBookingListModel.fromJson(response);
      return respon;
    } catch (e) {
      print("Driver Package Booking Not Completed Repo");
      print(e);
      rethrow;
    }
  }
}

///Driver Package Booking history Repo
class DriverPackageBookingHistoryListRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<DriverPackageBookingHistoryListModel>
      driverDriverPackageBookingHistoryListRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'package_booking/get_package_booking_history_by_driver_id?driverId=${data["driverId"]}');
      print("Driver Package Booking history Completed Repo");
      print(response);
      var respon = DriverPackageBookingHistoryListModel.fromJson(response);
      return respon;
    } catch (e) {
      print("Driver Package Booking Not Completed Repo");
      print(e);
      rethrow;
    }
  }
}

///Driver Package Details Repo
class DriverPackageDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverDriverPackageDetailsRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'package_booking/get_assigned_package_booking_detail?driverAssignedId=${data["driverAssignedId"]}');
      print("Driver Package Booking Completed Repo");
      print(response);
      return response = DriverPackageDetailModel.fromJson(response);
    } catch (e) {
      print("Driver Package Booking Not Completed Repo");
      print(e);
      rethrow;
    }
  }
}

///Driver Activity start Repo
class DriverActivityStartRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<DriverActivityStartModel> driverActivityStartRepositoryApi(
      data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponseWithData(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'package_booking/start_activity?packageBookingId=${data['packageBookingId']}&date=${data['date']}&zoneId=${data['zoneId']}',
          data);
      print("Driver Package start  Repo$data");
      print(response);
      var resp = DriverActivityStartModel.fromJson(response);

      return resp;
    } catch (e) {
      print("Driver Package Booking Not Completed Repo");
      print(e);
      rethrow;
    }
  }
}

///Driver Activity start Repo
class DriverActivityCompleteRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<DriverActivityCompleteModel> driverActivityCompleteRepositoryApi(
      data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponseWithData(
          'http://swabi.ap-south-1.elasticbeanstalk.com/'
          'package_booking/complete_activity?packageBookingId=${data['packageBookingId']}&date=${data['date']}&zoneId=${data['zoneId']}',
          data);
      print("Driver Package complete  Repo$data");
      print(response);
      var resp = DriverActivityCompleteModel.fromJson(response);

      return resp;
    } catch (e) {
      print("Driver Package Booking Not Completed Repo");
      print(e);
      rethrow;
    }
  }
}

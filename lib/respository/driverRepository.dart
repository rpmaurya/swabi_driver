import 'package:flutter_driver/data/network/base_apiservices.dart';
import 'package:flutter_driver/data/network/network_apiservice.dart';
import 'package:flutter_driver/model/driverBookingModel.dart';

///Driver Booking Details List View Repo
class DriverRentalBookingListRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverBookingListRepositoryApi(Map<String, dynamic>data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse('http://swabi.ap-south-1.elasticbeanstalk.com/' 'rental/get_rental_booking_by_driverId?driverId=${data["driverId"]}&pageNumber=${data["pageNumber"]}&pageSize=${data["pageSize"]}&bookingStatus=${data["bookingStatus"]}');
      print("Driver Booking View List Repo api success");
      print(response);
      return response = DriverBookingModel.fromJson(response);
    } catch (e) {
      print("Driver Booking View List api not successful error");
      print(e);
      rethrow;
    }
  }
}

///Driver Booking Details Single View Repo
class DriverRentalBookingDetailsRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverBookingDetailsRepositoryApi(Map<String, dynamic>data) async {
    try {
      dynamic response = await _apiServices.getGetApiResponse('http://swabi.ap-south-1.elasticbeanstalk.com/' 'rental/get_rental_booking_by_id?id=${data["id"]}');
      print("Driver Booking View Details Repo api success");
      print(response);
      return response = DriverGetBookingDetailsModel.fromJson(response);
    } catch (e) {
      print("Driver Booking View Details api not successful error");
      print(e);
      rethrow;
    }
  }
}

///Driver Booking Details Single View Repo
class DriverOnRunningRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverOnRunningRepositoryApi(Map<String, dynamic>data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponseWithData('http://swabi.ap-south-1.elasticbeanstalk.com/' 'rental/change_booking_status?id=${data["id"]}&bookingStatus=${data["bookingStatus"]}',data);
      print("Driver On Running Ride Repo api success");
      print(response);
      return response = DriverOnRunningModel.fromJson(response);
    } catch (e) {
      print("Driver  On Running Ride api not successful error");
      print(e);
      rethrow;
    }
  }
}

///Driver Booking Completed Repo
class DriverBookingCompletedRepository {
  final BaseApiServices _apiServices = NetworkApiService();
  Future<dynamic> driverDriverBookingCompletedRepositoryApi(data) async {
    try {
      dynamic response = await _apiServices.getPutApiResponseWithData('http://swabi.ap-south-1.elasticbeanstalk.com/' 'rental/change_booking_status?id=${data["id"]}&bookingStatus=${data["bookingStatus"]}',data);
      print("Driver Booking Completed Repo");
      print(response);
      return response = DriverBookingCompletedModel.fromJson(response);
    } catch (e) {
      print("Driver Booking Not Completed Repo");
      print(e);
      rethrow;
    }
  }
}



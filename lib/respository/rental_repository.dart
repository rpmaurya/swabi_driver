//
// import 'package:flutter_driver/data/app_url.dart';
// import 'package:flutter_driver/model/rentalBooking_model.dart';
//
// import '../data/network/base_apiservices.dart';
// import '../data/network/network_apiservice.dart';
//
// class RentalRepository {
//   final BaseApiServices _apiServices = NetworkApiService();
//   Future<dynamic> rentalRepositoryApi(Map<String, dynamic> data) async {
//     print(data['date'] + "adasdaa");
//     try {
//       dynamic response = await _apiServices.getGetApiResponse('http://swabi.ap-south-1.elasticbeanstalk.com/' 'rental/rental_car_price?date=${data["date"]}&pickupTime=${data["pickupTime"]}&seat=${data["seat"]}&hours=${data["hours"]}&kilometers=${data["kilometers"]}&pickUpLocation=${data["pickUpLocation"]}');
//       print("rental api success");
//       return response = RentalCarListStatus.fromJson(response);
//     } catch (e) {
//       print("rental api not successful error");
//       print(e);
//       rethrow;
//     }
//   }
// }
//
// ///Rental Booking Repo
// class RentalBookingRepository {
//   final BaseApiServices _apiServices = NetworkApiService();
//   Future<dynamic> rentalBookingRepositoryApi(data) async {
//     try {
//       dynamic response = await _apiServices.getPostApiResponse(AppUrl.rentalBooking,data);
//       print("rentalBooking Repo api success");
//       return response = RentalCarBookingModel.fromJson(response);
//     } catch (e) {
//       print("rentalBooking Repo api not successful error");
//       print(e);
//       rethrow;
//     }
//   }
// }
//
// ///Rental Booking Cancel Repo
// class RentalBookingCancelRepository {
//   final BaseApiServices _apiServices = NetworkApiService();
//   Future<dynamic> rentalBookingCancelRepositoryApi(data) async {
//     try {
//       dynamic response = await _apiServices.getPutApiResponse('http://swabi.ap-south-1.elasticbeanstalk.com/' 'rental/cancel_rental_booking?id=${data["id"]}&reason=${data["reason"]}');
//       print("rentalBooking cancel Repo api success");
//       return response = RentalCarBookingCancelModel.fromJson(response);
//     } catch (e) {
//       print("rentalBooking cancel Repo api not successful error");
//       print(e);
//       rethrow;
//     }
//   }
// }
//
// ///Rental Booking List Repo
// class RentalBookingListRepository {
//   final BaseApiServices _apiServices = NetworkApiService();
//   Future<dynamic> rentalBookingListRepositoryApi(data) async {
//     try {
//       dynamic response = await _apiServices.getGetApiResponse('http://swabi.ap-south-1.elasticbeanstalk.com/' 'rental/get_rental_booking_by_userId?userId=${data["userId"]}&pageNumber=${data["pageNumber"]}&pageSize=${data["pageSize"]}&bookingStatus=${data["bookingStatus"]}');
//       print("rentalBooking Repo api success");
//       return response = RentalCarBookingListModel.fromJson(response);
//     } catch (e) {
//       print("rentalBooking Repo api not successful error");
//       print(e);
//       rethrow;
//     }
//   }
// }
//
//
// ///Rental View Single Detail Repo
// class RentalViewDetailsRepository {
//   final BaseApiServices _apiServices = NetworkApiService();
//   Future<dynamic> rentalViewDetailsRepositoryApi(data) async {
//     try {
//       dynamic response = await _apiServices.getGetApiResponse("http://swabi.ap-south-1.elasticbeanstalk.com" "/rental/get_rental_booking_by_id?id=${data["id"]}");
//       print("rental View Detail Repo api success");
//       return response = RentalDetialsViewModel.fromJson(response);
//     } catch (e) {
//       print("rental View Detail api not successful error");
//       print(e);
//       rethrow;
//     }
//   }
// }

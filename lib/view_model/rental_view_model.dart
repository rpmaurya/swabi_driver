// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_driver/data/response/api_response.dart';
// import 'package:flutter_driver/model/rentalBooking_model.dart';
// import 'package:flutter_driver/respository/rental_repository.dart';
// import 'package:flutter_driver/utils/color.dart';
// import 'package:go_router/go_router.dart';
// import '../utils/utils.dart';
// // ignore: depend_on_referenced_packages
//
// // Rental View Model
// class RentalViewModel with ChangeNotifier {
//   final _myRepo = RentalRepository();
//   ApiResponse<RentalCarListStatus> DataList = ApiResponse.loading();
//
//   setDataList(ApiResponse<RentalCarListStatus> response) {
//     DataList = response;
//     notifyListeners();
//   }
//   Future<void> fetchRentalViewModelApi(BuildContext context,data) async {
//     print("${data}sfsdfsdf");
//   setDataList(ApiResponse.loading());
//   _myRepo.rentalRepositoryApi(data).then((value) async {
//     setDataList(ApiResponse.completed(value));
//     print('Rental Api Success');
//     context.push('/rentalForm/carsDetails');
//     Utils.toastMessage("Data fetching",greenColor);
//   }).onError((error, stackTrace) {
//     print(error.toString());
//     print('Rental Api Failed');
//     Utils.flushBarErrorMessage(error.toString(), context,redColor);
//     setDataList(ApiResponse.error(error.toString()));
//     });
//   }
// }
//
// // Rental Booking View Model
// class RentalBookingViewModel with ChangeNotifier {
//   final _myRepo = RentalBookingRepository();
//   ApiResponse<RentalCarBookingModel> DataList = ApiResponse.loading();
//
//   setDataList(ApiResponse<RentalCarBookingModel> response) {
//     DataList = response;
//     notifyListeners();
//   }
//   Future<void> fetchRentalViewModelApi(BuildContext context,data) async {
//     print("${data}sfsdfsdf");
//     setDataList(ApiResponse.loading());
//     _myRepo.rentalBookingRepositoryApi(data).then((value) async {
//       setDataList(ApiResponse.completed(value));
//       print('RentalBooking Api Success');
//       context.push('/rentalForm/rentalCarBooking');
//       Utils.toastMessage("Data fetching",greenColor);
//     }).onError((error, stackTrace) {
//       print(error.toString());
//       print('RentalBooking Api Failed');
//       Utils.flushBarErrorMessage(error.toString(), context,redColor);
//       setDataList(ApiResponse.error(error.toString()));
//     });
//   }
// }
// // Rental Booking View Model
// class RentalBookingCancelViewModel with ChangeNotifier {
//   final _myRepo = RentalBookingCancelRepository();
//   ApiResponse<RentalCarBookingCancelModel> DataList = ApiResponse.loading();
//
//   setDataList(ApiResponse<RentalCarBookingCancelModel> response) {
//     DataList = response;
//     notifyListeners();
//   }
//   Future<void> fetchRentalBookingCancelViewModelApi(BuildContext context,data) async {
//     print("${data}sfsdfsdf");
//     setDataList(ApiResponse.loading());
//     _myRepo.rentalBookingCancelRepositoryApi(data).then((value) async {
//       setDataList(ApiResponse.completed(value));
//       print('RentalBooking Cancel Api Success');
//       context.push('/rentalForm/rentalHistory');
//       Utils.toastMessage("Rental Car Cancel Booking",greenColor);
//     }).onError((error, stackTrace) {
//       print(error.toString());
//       print('RentalBooking Cancel Api Failed');
//       Utils.flushBarErrorMessage(error.toString(), context,redColor);
//       setDataList(ApiResponse.error(error.toString()));
//     });
//   }
// }
//
// // Rental Booking List FilterWise View Model
// class RentalBookingListViewModel with ChangeNotifier {
//   final _myRepo = RentalBookingListRepository();
//   ApiResponse<RentalCarBookingListModel> DataList = ApiResponse.loading();
//   ApiResponse<RentalCarBookingListModel> DataList1 = ApiResponse.loading();
//
//   setDataList(ApiResponse<RentalCarBookingListModel> response) {
//     DataList = response;
//     notifyListeners();
//   }
//
//   setDataList1(ApiResponse<RentalCarBookingListModel> response) {
//     DataList1 = response;
//     notifyListeners();
//   }
//
//   Future<void> fetchRentalBookingListBookedViewModelApi(BuildContext context,data) async {
//     setDataList(ApiResponse.loading());
//     _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
//       setDataList(ApiResponse.completed(value));
//       // context.push('/rentalForm/rentalCarBooking');
//       Utils.toastMessage("Rental Car List BOOKED Booking",greenColor);
//     }).onError((error, stackTrace) {
//       Utils.flushBarErrorMessage(error.toString(), context,redColor);
//       setDataList(ApiResponse.error(error.toString()));
//     });
//   }
//
//   Future<void> fetchRentalBookingListCancelledViewModelApi(BuildContext context,data) async {
//     setDataList1(ApiResponse.loading());
//     _myRepo.rentalBookingListRepositoryApi(data).then((value) async {
//       setDataList1(ApiResponse.completed(value));
//       // context.push('/rentalForm/rentalCarBooking');
//       Utils.toastMessage("Rental Car List CANCELLED Booking",greenColor);
//     }).onError((error, stackTrace) {
//       Utils.flushBarErrorMessage(error.toString(), context,redColor);
//       setDataList1(ApiResponse.error(error.toString()));
//     });
//   }
// }
//
//
// // Rental View Detail View Model
// class RentalViewDetailViewModel with ChangeNotifier {
//   final _myRepo = RentalViewDetailsRepository();
//   ApiResponse<RentalDetialsViewModel> DataList = ApiResponse.loading();
//   ApiResponse<RentalDetialsViewModel> DataList1 = ApiResponse.loading();
//
//   setDataList(ApiResponse<RentalDetialsViewModel> response) {
//     DataList = response;
//     notifyListeners();
//   }
//   setDataList1(ApiResponse<RentalDetialsViewModel> response) {
//     DataList1 = response;
//     notifyListeners();
//   }
//   Future<void> fetchRentalBookedViewDetialViewModelApi(BuildContext context,data,String bookid) async {
//     setDataList(ApiResponse.loading());
//     print(bookid);
//     _myRepo.rentalViewDetailsRepositoryApi(data).then((value) async {
//       setDataList(ApiResponse.completed(value));
//       context.push('/rentalForm/rentalBookedPageView',extra:{"bookedId" : bookid});
//       Utils.toastMessage("Rental Car View Detail Booking",greenColor);
//     }).onError((error, stackTrace) {
//       print(error.toString());
//       Utils.flushBarErrorMessage(error.toString(), context,redColor);
//       setDataList(ApiResponse.error(error.toString()));
//     });
//   }
//   Future<void> fetchRentalCancelledViewDetialViewModelApi(BuildContext context,data,String cancelId) async {
//     setDataList1(ApiResponse.loading());
//     _myRepo.rentalViewDetailsRepositoryApi(data).then((value) async {
//       setDataList1(ApiResponse.completed(value));
//       context.push('/rentalForm/rentalCancelledPageView',extra:{"cancelledId" : cancelId});
//       Utils.toastMessage("Rental Car View Detail Booking",greenColor);
//     }).onError((error, stackTrace) {
//       print(error.toString());
//       Utils.flushBarErrorMessage(error.toString(), context,redColor);
//       setDataList1(ApiResponse.error(error.toString()));
//     });
//   }
// }
// Rental Booking View Model
import 'package:flutter/material.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/respository/driver_profi_repository.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverProfileViewModel with ChangeNotifier {
  final _myRepo = DriverProfileRepository();
  ApiResponse<DriverProfileModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<DriverProfileModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future<void> fetchDriverProfileViewModelApi(
      BuildContext context, data, String uid) async {
    print("${data}sfsdfsdf");
    setDataList(ApiResponse.loading());
    _myRepo.driverBookingListRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      print('Driver Profile Api Success');
      context.push("/profilePage", extra: {"userId": uid});
      // Utils.toastMessage("Data fetching");
    }).onError((error, stackTrace) {
      print(error.toString());
      print('Driver Profile Api Failed');
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }

  Future<void> fetchDriverDetailViewModelApi(
      BuildContext context, data, String uid) async {
    print("${data}sfsdfsdf");
    setDataList(ApiResponse.loading());
    _myRepo.driverBookingListRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));
      print('Driver Profile Api Success');
      // context.push("/profilePage", extra: {"userId": uid});
      // Utils.toastMessage("Data fetching");
    }).onError((error, stackTrace) {
      print(error.toString());
      print('Driver Profile Api Failed');
      // Utils.flushBarErrorMessage(error.toString(), context);
      setDataList(ApiResponse.error(error.toString()));
    });
  }
}

///Driver Profile Update View Model
class DriverProfileUpdateViewModel with ChangeNotifier {
  final _myRepo = DriverProfileUpdateRepository();
  ApiResponse<DriverProfileUpdateModel> DataList = ApiResponse.loading();

  setDataList(ApiResponse<DriverProfileUpdateModel> response) {
    DataList = response;
    notifyListeners();
  }

  Future editProfile(
      {required BuildContext context,
      required String firstName,
      required String lastName,
      required String location,
      required String gender}) async {
    SharedPreferences srp = await SharedPreferences.getInstance();
    var driverId = srp.getString('userId');
    Map<String, dynamic> body = {
      "driverId": driverId,
      "firstName": firstName,
      "lastName": lastName,
      "driverAddress": location,
      "gender": gender,
    };
    try {
      setDataList(ApiResponse.loading());
      await _myRepo.editProfile(context: context, body: body).then((value) {
        setDataList(ApiResponse.completed(value));
        print('Updated successfull');
        context.pop(context);
        Utils.flushBarSuccessMessage("Profile Updated Successfully", context);
      });
    } catch (e) {
      print('error$e');
    }
  }
  // Future<void> fetchDriverProfileUpdateViewModelApi(
  //     BuildContext context, data, String uid) async {
  //   setDataList(ApiResponse.loading());
  //   _myRepo.userProfileUpdateRepositoryApi(data).then((value) async {
  //     setDataList(ApiResponse.completed(value));
  //     Provider.of<DriverProfileViewModel>(context, listen: false)
  //         .fetchDriverProfileViewModelApi(context, {"driverId": uid}, uid);
  //     context.pop(context);
  //     // context.pushReplacement("/profilePage",extra: {"userId":uid});
  //     print('Driver Update Profile Api Success');
  //     Utils.flushBarSuccessMessage("Number Updated Successfully", context);
  //   }).onError((error, stackTrace) {
  //     debugPrint(error.toString());
  //     print('Driver Update Profile Api field');
  //     setDataList(ApiResponse.error(error.toString()));
  //   });
  // }
}

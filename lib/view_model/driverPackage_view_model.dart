import 'package:flutter/cupertino.dart';
import 'package:flutter_driver/data/response/api_response.dart';
import 'package:flutter_driver/model/driverPackageModel.dart';
import 'package:flutter_driver/model/driverpackageHistoryModel.dart';
import 'package:flutter_driver/respository/driver_package_repository.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

///Driver Get Booking Details Single Full View Model
class DriverPackageBookingListViewModel with ChangeNotifier {
  final _myRepo = DriverPackageBookingListRepository();
  ApiResponse<DriverPackageBookingListModel> driverPackageList =
      ApiResponse.loading();

  setDataList(ApiResponse<DriverPackageBookingListModel> response) {
    driverPackageList = response;

    notifyListeners();
    debugPrint(
        "Driver Booking dayStatus ${driverPackageList.data?.data.last.dayStatus}");
  }

  void updateDayStatus(DriverPackageBookingListModel newdata) {
    driverPackageList.data = newdata;
    notifyListeners();
  }

  Future fetchDriverPackageBookingListViewModel(
      data, BuildContext context, String myIdDriver, String historyList) async {
    setDataList(ApiResponse.loading());
    _myRepo.driverDriverPackageBookingListRepositoryApi(data).then((value) {
      setDataList(ApiResponse.completed(value));
      updateDayStatus(value);
      debugPrint(
          "Driver Booking dayStatus............ ${value.data.last.dayStatus}");
      context.push("/packageBookingList",
          extra: {"myId": myIdDriver, 'historyList': historyList});
      debugPrint("Driver Booking Details Success");
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }
}

///Driver Get Booking Details Single Full View Model
class DriverPackageBookingHistoryListViewModel with ChangeNotifier {
  final _myRepo = DriverPackageBookingHistoryListRepository();
  ApiResponse<DriverPackageBookingHistoryListModel> driverPackageList =
      ApiResponse.loading();

  setDataList(ApiResponse<DriverPackageBookingHistoryListModel> response) {
    driverPackageList = response;

    notifyListeners();
  }

  Future fetchDriverPackageBookingHistoryListViewModel(
      data, BuildContext context, String myIdDriver, String historyList) async {
    setDataList(ApiResponse.loading());
    _myRepo
        .driverDriverPackageBookingHistoryListRepositoryApi(data)
        .then((value) {
      setDataList(ApiResponse.completed(value));

      context.push("/packageBookingList",
          extra: {"myId": myIdDriver, 'historyList': historyList});
      debugPrint("Driver Booking Details Success");
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }
}

///Driver Get Booking Details Single Full View Model
class DriverPackageDetailViewModel with ChangeNotifier {
  final _myRepo = DriverPackageDetailsRepository();
  ApiResponse<DriverPackageDetailModel> driverPackageDetails =
      ApiResponse.loading();

  setDataList(ApiResponse<DriverPackageDetailModel> response) {
    driverPackageDetails = response;
    notifyListeners();
  }

  void updateDayStatus(String newStatus) {
    if (driverPackageDetails.data?.data != null) {
      driverPackageDetails.data?.data.dayStatus = newStatus;
      notifyListeners();
    }
  }

  // Your other methods to fetch and update data...

  Future fetchDriverPackageDetailViewModel(
      data, BuildContext context, String driverAssID) async {
    setDataList(ApiResponse.loading());
    _myRepo.driverDriverPackageDetailsRepositoryApi(data).then((value) async {
      setDataList(ApiResponse.completed(value));

      context.push('/pageViewDetails', extra: {"driverAss": driverAssID}).then(
          (onValue) {
        print('returning daataa...');
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          Provider.of<DriverPackageBookingListViewModel>(context, listen: false)
              .fetchDriverPackageBookingListViewModel(
                  {"driverId": driverPackageDetails.data?.data.driverId},
                  context,
                  driverPackageDetails.data?.data.driverId.toString() ?? '',
                  'list');
        });
      });

      debugPrint("Driver Booking Details Success");
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }
}

///Driver Activity Start Single Full View Model
class DriverActivityStartViewModel with ChangeNotifier {
  final _myRepo = DriverActivityStartRepository();
  ApiResponse<DriverActivityStartModel> driverActivityStart =
      ApiResponse.loading();

  setDataList(ApiResponse<DriverActivityStartModel> response) {
    driverActivityStart = response;
    notifyListeners();
  }

  Future fetchDriverActivityStartViewModel(data, BuildContext context) async {
    setDataList(ApiResponse.loading());

    await _myRepo.driverActivityStartRepositoryApi(data).then((value) {
      setDataList(ApiResponse.completed(value));
      // context.push('/pageViewDetails', );
      debugPrint("Driver Booking Details Success");
      Utils.flushBarSuccessMessage("Journey started", context);
      print('jhjhjkkjkllkl${value.status.httpCode}');
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }
}

///Driver Activity Start Single Full View Model
class DriverActivityCompleteViewModel with ChangeNotifier {
  final _myRepo = DriverActivityCompleteRepository();
  ApiResponse<DriverActivityCompleteModel> driverActivityComplete =
      ApiResponse.loading();

  setDataList(ApiResponse<DriverActivityCompleteModel> response) {
    driverActivityComplete = response;
    notifyListeners();
  }

  Future fetchDriverActivityCompleteViewModel(
      data, BuildContext context) async {
    setDataList(ApiResponse.loading());

    await _myRepo.driverActivityCompleteRepositoryApi(data).then((value) {
      setDataList(ApiResponse.completed(value));
      // Provider.of<DriverPackageDetailViewModel>(context, listen: false)
      //     .fetchDriverPackageDetailViewModel(data,BuildContext context,);
      // context.push('/pageViewDetails', extra: {"driverAss": driverAssID});
      debugPrint("Driver Booking Details Success");
      Utils.flushBarSuccessMessage("Journey completed", context);
      print('jhjhjkkjkllkl${value.status.httpCode}');
    }).onError((error, stackTrace) {
      setDataList(ApiResponse.error(error.toString()));
      debugPrint(error.toString());
    });
  }
}

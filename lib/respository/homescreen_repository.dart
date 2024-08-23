//
// import 'dart:developer';
//
// import 'package:flutter_driver/data/app_url.dart';
// import 'package:flutter_driver/model/dashboard_model.dart';
//
// import '../data/network/base_apiservices.dart';
// import '../data/network/network_apiservice.dart';
//
// class DashBoardRepository {
//   final BaseApiServices _apiServices = NetworkApiService() ;
//
//
//
//   Future<DashBoardModel> fetchHomeListApi()async{
//     try{
//       dynamic response = await _apiServices.getGetApiResponse(AppUrl.dashBoardHome);
//       return response = DashBoardModel.fromJson(response);
//
//     }catch(e){
//       rethrow ;
//     }
//   }
//
//
//
//   Future<dynamic> fetchBirthdayWish(dynamic data )async{
//     try{
//       dynamic response = await _apiServices.getPostApiResponse(AppUrl.birthDayWishApiEndPoint,data);
//       return response;
//
//     }catch(e){
//       rethrow ;
//     }
//   }
//
//
//
// }

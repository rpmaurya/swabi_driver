import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../respository/user.dart';
import '/model/user_model.dart';
import '/utils/utils.dart';

class AuthViewModel with ChangeNotifier {
  final _myRepo = UserRepository();
  late bool setupFinish = false;

  bool check = true;
  bool _loading = false;
  bool get loading => _loading;

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;

  setLoading(bool value) {
    _loading = value;
    notifyListeners();
  }

  setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  // Future<void> loginApi(dynamic data, BuildContext context) async {
  //   setLoading(true);
  //   _myRepo.loginApi(data).then((value) async {
  //     print(value);
  //     setLoading(false);
  //     String token = value['token'].toString();
  //     final userPreference = Provider.of<UserViewModel>(context, listen: false);
  //     userPreference.saveToken(UserModel(token: token.toString()));
  //     print("Data of user ${value['data'].toString()}");
  //     // userPreference.saveUserEmail(value['email'].toString());
  //     print(value['token']);
  //     print("Data of user ${value['data'].toString(),''}");
  //     Utils.toastMessage('Login Successfully',Colors.green);
  //     print("Login Successfully token ${value.toString()}");
  //     /// navigate to dashbaord
  //     context.go('/');
  //   }).onError((error, stackTrace) {
  //     setLoading(false);
  //     Utils.flushBarErrorMessage(error.toString(), context,Colors.red);
  //     if (kDebugMode) {
  //       print(error.toString());
  //     }
  //   });
  // }

  Future<void> loginApi(
      {required BuildContext context,
      required String email,
      required String password,
      required String notificationToken,
      required bool rememberMe}) async {
    Map<String, String> data = {
      'email': email,
      'password': password,
      'notificationToken': notificationToken,
      'userType': 'DRIVER'
    };
    setLoading(true);
    {
      _myRepo.loginApi(data).then((value) async {
        print(value);

        final userPreference =
            Provider.of<UserViewModel>(context, listen: false);
        print("save token");
        // userPreference.saveEmail(value['user']);
        print(value['data']['userId'].toString());
        String userID = value['data']['userId'].toString();
        String token1 = value['data']['token'].toString();
        userPreference.saveToken(UserModel(token: token1));
        userPreference.saveUserId(UserModel(userId: userID));
        rememberMe
            ? userPreference.saveRememberMe(email, password, rememberMe)
            : userPreference.clearRememberMe();
        print('userId: $userID');
        print('token: ${token1.toString()}');
        Utils.toastSuccessMessage("Login Successfully");
        context.go('/');
        setLoading(false);
      }).onError((error, stackTrace) {
        setLoading(false);
        Utils.toastMessage(error.toString());
        FocusScope.of(context).unfocus();
        if (kDebugMode) {
          print(error.toString());
        }
      });
    }
  }
}

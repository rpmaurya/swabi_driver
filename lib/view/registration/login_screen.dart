import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/login/login_customTextFeild.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:flutter_driver/view_model/auth_view_model.dart';

// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String usr = '';
  String pass = '';
  bool value = false;
  String? notificationToken = '';
  List<TextEditingController> controller =
      List.generate(2, (index) => TextEditingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestPermission();
    getToken();
    savecredential();
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //
    // });
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  void getToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    notificationToken = token;
    print("FCM Token: $notificationToken");
  }

  savecredential() async {
    final prefsData = await SharedPreferences.getInstance();
    List<String>? items = prefsData.getStringList('saveCredential');
    setState(() {
      usr = items![0].toString();
      pass = items[1].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: bgGreyColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: Center(child: Image.asset(appLogo1)),
                // child: Center(child: Image.asset(appLogo1)),
              ),
              const SizedBox(height: 50),
              LoginTextFeild(
                headingReq: true,
                hint: "xyz@gmail.com",
                controller: controller[0]..text = usr.toString(),
                img: email,
                heading: "Enter your Email",
              ),
              const SizedBox(height: 8),
              LoginTextFeild(
                headingReq: true,
                controller: controller[1]..text = pass.toString(),
                obscure: true,
                suffixIcon: true,
                img: email,
                hint: "XXXXXXXXXXX",
                heading: "Enter your Password",
              ),
              // const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    child: TextButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => ForgotPassword()));
                      },
                      child: Text('Forgot Password',
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w700,
                              color: const Color.fromRGBO(0, 0, 0, 0.5))),
                    ),
                  ),
                ],
              ),
              CustomButtonBig(
                btnHeading: "LOGIN",
                loading: authViewMode.loading,
                onTap: () {
                  if (controller[0].text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Enter your valid Email Id", context);
                  } else if (controller[1].text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "Enter your valid Password", context);
                  } else {
                    Map<String, String> data = {
                      'email': controller[0].text.toString(),
                      'password': controller[1].text.toString(),
                      'notificationToken': notificationToken ?? '',
                      'userType': 'DRIVER'
                    };
                    authViewMode.loginApi(data, context);
                  }
                  // context.push('/');
                  // controller[0].clear();
                  // controller[1].clear();
                },
              ),
              const SizedBox(
                height: 10,
              ),
            ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view/registration/login_screen.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:go_router/go_router.dart';

// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  var email = TextEditingController();
  TextEditingController forgetPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<ResetPasswordViewModel>(
        builder: (context, viewModel, child) {
      return Scaffold(
        backgroundColor: bgGreyColor,
        body: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Center(
                  child: Image.asset('assets/images/Asset 233000 1.png')),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Forgot Password',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Text('Enter your email to reset your password'),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(children: [
                        TextSpan(
                            text: 'Enter your Email', style: titleTextStyle),
                        TextSpan(text: ' *', style: TextStyle(color: redColor))
                      ])),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            hintText: 'xyz@gmail.com',
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 10.0),
                            filled: true,
                            fillColor: const Color.fromRGBO(255, 255, 255, 1),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide.none)),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          const pattern =
                              r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
                              r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
                              r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
                              r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
                              r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
                              r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
                              r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
                          final regex = RegExp(pattern);
                          if (value == null || value.isEmpty) {
                            return 'Enter valid email';
                          } else if (!regex.hasMatch(value)) {
                            return 'Enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButtonSmall(
                          width: double.infinity,
                          loading: viewModel.isLoading,
                          height: 50,
                          btnHeading: 'Submit',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              viewModel
                                  .sendOtp(context: context, email: email.text)
                                  .then((onValue) {
                                if (onValue?.status?.httpCode == '200') {
                                  // Utils.flushBarSuccessMessage(
                                  //     onValue?.status?.message, context);
                                  context.push('/verifyOtp',
                                      extra: {"email": email.text});
                                }
                              });
                            }
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Remember your password?'),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen()));
                              },
                              child: Text(
                                'Login',
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w700,
                                    color:
                                        const Color.fromRGBO(69, 30, 243, 1)),
                              ))
                        ],
                      )
                    ],
                  )),
            ),
          ]),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/login/login_customTextFeild.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:go_router/go_router.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return PageLayout_Curve(appHeading: "Change Password",
        child: Column(
          children: [
            LoginTextFeild(headingReq: true,
                controller: TextEditingController(),
                hint: "Enter your new password",
              suffixIcon: true,
              obscure: true,
              prefixIcon: true,
              img: pass,
              heading: "New Password",
            ),
            const SizedBox(height: 10),
            LoginTextFeild(headingReq: true,
              controller: TextEditingController(),
              hint: "Enter your confirm password",
              suffixIcon: true,
              obscure: true,
              prefixIcon: true,
              img: pass,
              heading: "Confirm Password",
            ),
            const Spacer(),
            CustomButtonBig(btnHeading: "Update",
              onTap: () => context.push("/login"),),
            const SizedBox(height: 10),
          ],
        ));
  }
}

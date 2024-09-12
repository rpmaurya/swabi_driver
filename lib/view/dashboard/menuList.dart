import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/custom_ListTile.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/view_model/driverPackage_view_model.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuList extends StatefulWidget {
  final String userId;
  const MenuList({super.key, required this.userId});

  @override
  State<MenuList> createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  bool noti = false;

  UserViewModel userViewModel = UserViewModel();

  @override
  void initState() {
    super.initState();
    _loadNotiValue();
  }

  Future<void> _loadNotiValue() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      noti = prefs.getBool('noti') ?? false;
    });
  }

  Future<void> _saveNotiValue(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('noti', value);
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("${noti}Value Data");
    debugPrint('${widget.userId} menu user id');
    // return PageLayout_Curve(
    //     appHeading: "Account",
    //     leadingAppImage: package,
    //     child:
    //     );

    return CustomPagelayout(
        appBarTitle: 'Account',
        child: Column(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          children: [
            const SizedBox(height: 10),
            Custom_ListTile(
              img: profile,
              heading: "Profile",
              onTap: () {
                Provider.of<DriverProfileViewModel>(context, listen: false)
                    .fetchDriverProfileViewModelApi(
                        context, {"driverId": widget.userId}, widget.userId);
              },
            ),
            Custom_ListTile(
              img: booking,
              heading: "Rental Management",
              onTap: () => context
                  .push("/historyManagement", extra: {"myID": widget.userId}),
              // context.push("/booking")
            ),
            Custom_ListTile(
              img: package,
              heading: "Package Management",
              onTap: () {
                // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                //   Provider.of<DriverPackageBookingHistoryListViewModel>(context,
                //           listen: false)
                //       .fetchDriverPackageBookingHistoryListViewModel(
                //           {"driverId": widget.userId},
                //           context,
                //           widget.userId,
                //           'historyList');
                // });
                context.push('/packageBookingManagement');
              },
              // context.push("/booking")
            ),
            // Custom_ListTile(
            //   img: card,
            //   heading: "Cards Details",
            //   onTap: () => context.push("/myCards"),
            // ),
            // Custom_ListTile(
            //   img: transaction,
            //   heading: "Transaction",
            //   onTap: () => context.push("/myTransaction"),
            // ),
            // Custom_ListTile(
            //   img: settingimg,
            //   heading: "Settings",
            //   onTap: () => context.push("/setting"),
            // ),
            // Custom_ListTileSwitch(
            //   img: notification,
            //   heading: "Notification",
            //   notification: FlutterSwitch(
            //     width: 55,
            //     height: 30,
            //     activeColor: Colors.green,
            //     toggleSize: 20,
            //     value: noti,
            //     inactiveColor: naturalGreyColor.withOpacity(0.3),
            //     onToggle: (value) {
            //       setState(() {
            //         noti = value;
            //       });
            //       _saveNotiValue(value);
            //     },
            //   ),
            // ),
            // Custom_ListTile(
            //   img: tnc,
            //   heading: "Term & Condition",
            //   onTap: () => context.push("/termCondition"),
            // ),
            // Custom_ListTile(
            //   img: contact,
            //   heading: "Contact",
            //   onTap: () => context.push("/contact"),
            // ),
            Custom_ListTile(
              img: contact,
              heading: "Help & Support",
              onTap: () => context.push("/help&support"),
            ),
            Custom_ListTile(
              img: faq,
              heading: "FAQ",
              onTap: () => context.push("/faqPage"),
            ),
            // const SizedBox(
            //   height: 30,
            // ),
            const Spacer(),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButtonLogout(
                  img: logout,
                  btnHeading: "Logout",
                  onTap: () {
                    // userViewModel.removeUser(context);
                    userViewModel.remove(context);
                    context.go("/login");
                  }),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ));
  }
}

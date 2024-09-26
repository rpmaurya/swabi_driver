import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/login/login_customTextFeild.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  final String user;
  const ProfilePage({super.key, required this.user});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String dataUser = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataUser = widget.user;
  }

  var userId;
  // var userName, userLastName, userMobile, userAdd, userEmail, userGender,userImg,userId;

  @override
  Widget build(BuildContext context) {
    debugPrint(dataUser);
    var userName =
        context.watch<DriverProfileViewModel>().DataList.data?.data.firstName ??
            '';
    var userLastName =
        context.watch<DriverProfileViewModel>().DataList.data?.data.lastName ??
            '';
    var userMobile =
        context.watch<DriverProfileViewModel>().DataList.data?.data.mobile ??
            '';
    var userAdd = context
            .watch<DriverProfileViewModel>()
            .DataList
            .data
            ?.data
            .driverAddress ??
        '';
    var userEmail =
        context.watch<DriverProfileViewModel>().DataList.data?.data.email ?? '';
    var userGender =
        context.watch<DriverProfileViewModel>().DataList.data?.data.gender ??
            '';
    var emiId = context
            .watch<DriverProfileViewModel>()
            .DataList
            .data
            ?.data
            .emiratesId ??
        '';
    var licenceNo = context
            .watch<DriverProfileViewModel>()
            .DataList
            .data
            ?.data
            .licenceNumber ??
        '';
    var countryCode = context
            .watch<DriverProfileViewModel>()
            .DataList
            .data
            ?.data
            .countryCode ??
        '';
    userId =
        context.watch<DriverProfileViewModel>().DataList.data?.data.driverId ??
            '';
    print('${userName}User Name');
    return CustomPagelayout(
      appBarTitle: 'Profile',
      actionIcon: InkWell(
        onTap: () {
          context.push("/profilePage/editProfilePage", extra: {
            'uId': dataUser,
            'phoneNo': userMobile,
          }).then((value) {
            Provider.of<DriverProfileViewModel>(context, listen: false)
                .fetchDriverDetailViewModelApi(
                    context, {"driverId": userId}, userId);
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(right: 22),
          child: Image.asset(
            edit,
            width: 26,
            height: 30,
            color: background,
          ),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "My Id No.",
              headingReq: true,
              controller: TextEditingController(text: dataUser),
              prefixIcon: true,
              readOnly: true,
              img: idCard,
            ),
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "Name",
              headingReq: true,
              controller:
                  TextEditingController(text: "$userName $userLastName"),
              prefixIcon: true,
              readOnly: true,
              img: profile,
            ),
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "Email",
              headingReq: true,
              controller: TextEditingController(text: userEmail),
              prefixIcon: true,
              readOnly: true,
              img: email,
            ),
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "Gender",
              headingReq: true,
              prefixIcon: true,
              controller: TextEditingController(text: userGender),
              readOnly: true,
              img: gender,
            ),
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "Address",
              headingReq: true,
              prefixIcon: true,
              controller: TextEditingController(text: userAdd),
              readOnly: true,
              img: address,
            ),
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "Mobile",
              headingReq: true,
              prefixIcon: true,
              controller:
                  TextEditingController(text: "+$countryCode $userMobile"),
              readOnly: true,
              img: phone,
            ),
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "EmiratesId",
              headingReq: true,
              prefixIcon: true,
              controller: TextEditingController(text: emiId),
              readOnly: true,
              img: emiID,
            ),
            const SizedBox(height: 10),
            CommonTextFeild(
              heading: "LicenceNumber",
              headingReq: true,
              prefixIcon: true,
              controller: TextEditingController(text: licenceNo),
              readOnly: true,
              img: drivingLic,
            ),
            const SizedBox(height: 10),
            // Custom_ListTile(
            //   headingTitleReq: true,
            //   headingTitle: "Password",
            //   onTap: () => context.push("/verifyPassword"),
            //   heading: "**********",
            //   img: pass,
            // )
          ],
        ),
      ),
    );
    // return PageLayout_Curve(
    //   addtionalIconReq: true,
    //   addtionalIcon: edit,
    //   iconOnTap: () {
    //     context.push("/profilePage/editProfilePage", extra: {
    //       'uId': dataUser,
    //       'phoneNo': userMobile,
    //     }).then((value) {
    //       Provider.of<DriverProfileViewModel>(context, listen: false)
    //           .fetchDriverDetailViewModelApi(
    //               context, {"driverId": userId}, userId);
    //     });
    //   },
    //   appHeading: "Profile",
    //   child: SingleChildScrollView(
    //     child: Column(
    //       children: [
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "My Id No.",
    //           headingReq: true,
    //           controller: TextEditingController(text: dataUser),
    //           prefixIcon: true,
    //           readOnly: true,
    //           img: idCard,
    //         ),
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "Name",
    //           headingReq: true,
    //           controller:
    //               TextEditingController(text: "$userName $userLastName"),
    //           prefixIcon: true,
    //           readOnly: true,
    //           img: profile,
    //         ),
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "Email",
    //           headingReq: true,
    //           controller: TextEditingController(text: userEmail),
    //           prefixIcon: true,
    //           readOnly: true,
    //           img: email,
    //         ),
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "Gender",
    //           headingReq: true,
    //           prefixIcon: true,
    //           controller: TextEditingController(text: userGender),
    //           readOnly: true,
    //           img: gender,
    //         ),
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "Address",
    //           headingReq: true,
    //           prefixIcon: true,
    //           controller: TextEditingController(text: userAdd),
    //           readOnly: true,
    //           img: address,
    //         ),
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "Mobile",
    //           headingReq: true,
    //           prefixIcon: true,
    //           controller:
    //               TextEditingController(text: "$countryCode $userMobile"),
    //           readOnly: true,
    //           img: phone,
    //         ),
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "EmiratesId",
    //           headingReq: true,
    //           prefixIcon: true,
    //           controller: TextEditingController(text: emiId),
    //           readOnly: true,
    //           img: emiID,
    //         ),
    //         const SizedBox(height: 10),
    //         CommonTextFeild(
    //           heading: "LicenceNumber",
    //           headingReq: true,
    //           prefixIcon: true,
    //           controller: TextEditingController(text: licenceNo),
    //           readOnly: true,
    //           img: drivingLic,
    //         ),
    //         const SizedBox(height: 10),
    //         // Custom_ListTile(
    //         //   headingTitleReq: true,
    //         //   headingTitle: "Password",
    //         //   onTap: () => context.push("/verifyPassword"),
    //         //   heading: "**********",
    //         //   img: pass,
    //         // )
    //       ],
    //     ),
    //   ),
    // );
  }
}

class ProfileContainer extends StatelessWidget {
  final dynamic imgPath;
  final VoidCallback onTap;
  final String name;

  const ProfileContainer(
      {required this.onTap, required this.imgPath, this.name = "", super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: AppDimension.getWidth(context) * .3,
          height: AppDimension.getHeight(context) * .2,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: curvePageColor,
          ),
          child: imgPath.runtimeType != String
              ? Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: FileImage(imgPath), fit: BoxFit.cover)),
                )
              :
              // imgPath.toString() == ""
              //     ? Container(
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: curvePageColor.withOpacity(0.5)),
              //   alignment: Alignment.center,
              //   child: Text(
              //     getInitials(name),
              //     style: const TextStyle(
              //         fontSize: 18, fontWeight: FontWeight.w700),
              //   ),
              // )
              //     :
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                              // AppUrl.userProfileUpdate +
                              imgPath),
                          // image: AssetImage(imgPath),
                          fit: BoxFit.cover))),
          // child: const CircleAvatar(
          //   backgroundColor: curvePageColor,
          //   child: Icon(Icons.person,color: background,size: 40,),
          // ),
        ),
        Positioned(
          bottom: 20,
          right: 0,
          child: InkWell(
            borderRadius: BorderRadius.circular(50),
            onTap: onTap,
            child: const Card(
              elevation: 0,
              shape: CircleBorder(),
              color: lightBrownColor,
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    color: background,
                  )),
            ),
          ),
        )
      ],
    );
  }
}

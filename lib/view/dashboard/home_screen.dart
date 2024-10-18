import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/model/user_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/customTextWidget.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:flutter_driver/view_model/user_view_model.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class home_screen extends StatefulWidget {
  // final String timeZone;
  const home_screen({
    super.key,
    // required this.timeZone
  });

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  UserViewModel userViewModel = UserViewModel();
  final isFilteredList = ValueNotifier<bool>(true);

  String? uId;
  UserModel? userModel;
  List<Map<String, dynamic>> images = [
    {'image': carImage1},
    {'image': carImage2},
    {'image': carImage3},
    {'image': carImage4},
    {'image': carImage5},
    {'image': carImage6},
    {'image': carImage7},
    {'image': carImage8},
    {'image': carImage9},
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    userViewModel.getUserId().then((value) async {
      setState(() {
        if (value.userId != null && value.userId != '') {
          uId = value.userId.toString();
          userModel = value;
        }
      });
    });
    getUser();
    // Future.delayed(const Duration(milliseconds: 100),() {
    //   WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //     Provider.of<DriverGetBookingListViewModel>(context,listen: false).fetchDriverGetBookingListViewModel(
    //         {
    //           "driverId": uId,
    //           "pageNumber":"0",
    //           "pageSize":"10",
    //           "bookingStatus":"BOOKED"
    //         }, context);
    //   });
    // },);
  }

  getUser() async {
    Future.delayed(const Duration(seconds: 2), () {
      Provider.of<DriverProfileViewModel>(context, listen: false)
          .fetchDriverDetailViewModelApi(
              context, {"driverId": uId}, uId.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    var userName =
        context.watch<DriverProfileViewModel>().DataList.data?.data.firstName ??
            '';
    var userLastName =
        context.watch<DriverProfileViewModel>().DataList.data?.data.lastName ??
            '';
    var email =
        context.watch<DriverProfileViewModel>().DataList.data?.data.email ?? '';
    String status =
        context.watch<DriverProfileViewModel>().DataList.status.toString();
    var driverAddress = context
            .watch<DriverProfileViewModel>()
            .DataList
            .data
            ?.data
            .driverAddress ??
        '';
    String? userimage = context
        .watch<DriverProfileViewModel>()
        .DataList
        .data
        ?.data
        .profileImageUrl;
    print("DriverId here at homeScreen $status");
    return WillPopScope(
      // canPop: false,
      onWillPop: () async {
        bool shouldExit = await showDialog(
          context: context,
          builder: (context) => exitContainer(),
        );
        return shouldExit ?? false;
        // return await showDialog(context: context, builder: (context) =>
        //     exitContainer());
      },
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: appBarbgcolor,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              toolbarHeight: 150,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                                onPressed: () => context
                                    .push("/menuPage", extra: {'id': uId}),
                                icon: const Icon(
                                  Icons.notes_rounded,
                                  size: 26,
                                  color: Colors.white,
                                )),
                            const Text(
                              'Hi,',
                              style: TextStyle(color: background),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 45,
                                    width: 45,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        'https://tse1.mm.bing.net/th?id=OIP.kgD1sf9q75e3KYAajA8FBwHaHa&pid=Api&P=0&h=220',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$userName $userLastName',
                                    style: const TextStyle(
                                        color: background, fontSize: 24),
                                  ),
                                  Text(
                                    email,
                                    style: const TextStyle(
                                        color: background, fontSize: 14),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.notifications_on_sharp,
                        color: background,
                      ))
                ],
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(30),
                child: Container(
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: background,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: btnColor,
                      ),
                      Expanded(
                        child: Text(
                          driverAddress,
                          style: const TextStyle(color: btnColor, fontSize: 16),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: background,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: const TextField(
                  //     readOnly: true,
                  //     decoration: InputDecoration(
                  //         prefixIcon: Icon(Icons.search),
                  //         hintText: 'Search',
                  //         border: OutlineInputBorder(),
                  //         contentPadding: EdgeInsets.symmetric(vertical: 8)),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: CustomButtonSmall(
                              width: 150,
                              height: 45,
                              btnHeading: 'Rental',
                              onTap: () {
                                context.push("/historyManagement",
                                    extra: {"myID": uId});
                              }),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: CustomButtonSmall(
                              height: 45,
                              width: 150,
                              btnHeading: 'Package',
                              onTap: () {
                                context.push('/packageBookingManagement');
                              }),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Near By Location',
                      style: titleTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(5),
                    ),
                    height: 160,
                    width: double.infinity,
                    child: CarouselSlider(
                        items: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              sliderImage1,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              sliderImage2,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.asset(
                              sliderImage3,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          )
                        ],
                        options: CarouselOptions(
                            autoPlay: true,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Categories',
                      style: titleTextStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 100,
                    child: ListView.builder(
                        itemCount: images.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: 90,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        shape: BoxShape.rectangle,
                                        border:
                                            Border.all(color: Colors.black12)),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.asset(
                                        images[index]['image'],
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                                // Expanded(child: Text('datadsdsads'))
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
          status == "Status.loading"
              ? const SpinKitFadingCube(
                  color: greenColor,
                  size: 70,
                )
              : SizedBox()
        ],
      ),
    );
  }

  ///Exit Container Alert Box
  Widget exitContainer() {
    return SizedBox(
      width: AppDimension.getWidth(context) * .7,
      height: AppDimension.getHeight(context) * .5,
      child: Dialog(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        child: Stack(clipBehavior: Clip.none, children: [
          SizedBox(
            width: AppDimension.getWidth(context) * .7,
            height: AppDimension.getHeight(context) * .25,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 50, bottom: 20),
                  child: CustomTextWidget(
                      content: "Are you sure want to exit ?",
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      textColor: textColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonSmall(
                      width: 70,
                      btnHeading: "NO",
                      onTap: () {
                        context.pop();
                      },
                    ),
                    CustomButtonSmall(
                      width: 70,
                      btnHeading: "YES",
                      onTap: () {
                        exit(0);
                      },
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
              top: -60,
              left: 0,
              right: 0,
              child: SizedBox(
                height: 100,
                width: 100,
                child: Card(
                  surfaceTintColor: background,
                  elevation: 5,
                  shape: const CircleBorder(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(question),
                  ),
                ),
              ))
        ]),
      ),
    );
  }
}

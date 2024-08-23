import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driverPackageModel.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/customTextWidget.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/driverPackage_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_timezone/flutter_timezone.dart';

class PageViewDetails extends StatefulWidget {
  final String driverAss;

  const PageViewDetails({super.key, required this.driverAss});

  @override
  State<PageViewDetails> createState() => _PageViewDetailsState();
}

class _PageViewDetailsState extends State<PageViewDetails> {
  String? dateFormat;
  String _timeZone = 'unknown';
  String formattedTodayDate = '';
  DriverActivityStart? driverActivityStart;
  String? activityStatus;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimezone();
    final date = DateTime.now().add(Duration(days: 2));
    setState(() {
      dateFormat = DateFormat('dd-MM-yyyy').format(date);
    });
    formattedTodayDate = dateFormat.toString();
  }

  bool btn = false;
  bool? hideBtn;

  var packageDetails, vehicleDetails;
  List<PackageDetailActivityList> packageActivityList = [];
  Future<void> getTimezone() async {
    String timezone;

    try {
      timezone = await FlutterTimezone.getLocalTimezone();
      print('hgjhjhj.............$timezone');
      if (!mounted) return;

      setState(() {
        _timeZone = timezone;
      });
    } catch (e) {
      print('Could not get the local timezone');
    }
  }

  @override
  Widget build(BuildContext context) {
    packageDetails = context
            .watch<DriverPackageDetailViewModel>()
            .driverPackageDetails
            .data
            ?.data ??
        '';
    packageActivityList = context
            .watch<DriverPackageDetailViewModel>()
            .driverPackageDetails
            .data
            ?.data
            .activityList ??
        [];
    driverActivityStart = context
        .watch<DriverActivityStartViewModel>()
        .driverActivityStart
        .data
        ?.data;
    print('timeZone....${packageDetails.dayStatus}');
    print(widget.driverAss);
    return PageLayout_Curve(
        appHeading: "Page View",
        child: SingleChildScrollView(
          child: DetailsContainer(
            driverId: packageDetails.driverId,
            driverAss: packageDetails.driverAssignedId,
            pickUpLocation: packageDetails.pickupLocation,
            date: packageDetails.date,
            vehicleId: packageDetails.vehicle.vehicleId,
            carName: packageDetails.vehicle.carName,
            year: packageDetails.vehicle.year,
            brand: packageDetails.vehicle.brandName,
            carType: packageDetails.vehicle.carType,
            fuelType: packageDetails.vehicle.fuelType,
            carColor: packageDetails.vehicle.color,
            noOfSeat: packageDetails.vehicle.seats,
            vehicleNo: packageDetails.vehicle.vehicleNumber,
            modelNo: packageDetails.vehicle.modelNo,
            userFirstName: packageDetails.user.firstName,
            userLastName: packageDetails.user.lastName,
            userCountryCode: packageDetails.user.countryCode,
            userMobile: packageDetails.user.mobile,
            userEmail: packageDetails.user.email,
            widgetButton: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                packageDetails.dayStatus == 'PENDING'
                    ? CustomButtonSmall(
                        width: 170,
                        height: 40,
                        btnHeading: "Activity Start",
                        // btnHeading: "Activity Start",
                        isEnabled: formattedTodayDate == packageDetails.date
                            ? btn = true
                            : false,
                        onTap: btn != true
                            ? null
                            : () {
                                Map<String, dynamic> data = {
                                  "packageBookingId":
                                      packageDetails.packageBookingId,
                                  "date": packageDetails.date,
                                  // 'date': '22-7-2024',
                                  "zoneId": _timeZone
                                };
                                Provider.of<DriverActivityStartViewModel>(
                                        context,
                                        listen: false)
                                    .fetchDriverActivityStartViewModel(
                                        data, context)
                                    .then((onValue) {
                                  Provider.of<DriverPackageDetailViewModel>(
                                          context,
                                          listen: false)
                                      .updateDayStatus('ONGOING');

                                  print(
                                      'package status day    ....${packageDetails.dayStatus}');
                                });

                                // print(
                                //     'packege booking id${packageDetails.packageBookingId}');
                              },
                      )
                    : const SizedBox(),
                // hideBtn == false
                packageDetails.dayStatus == 'ONGOING'
                    ? CustomButtonSmall(
                        width: 170,
                        height: 40,
                        btnHeading: "Activity Completed",
                        isEnabled: formattedTodayDate == packageDetails.date
                            ? btn = true
                            : false,
                        onTap: btn != true
                            ? null
                            : () {
                                Map<String, dynamic> data = {
                                  "packageBookingId":
                                      packageDetails.packageBookingId,
                                  "date": packageDetails.date,
                                  // 'date': '22-7-2024',
                                  "zoneId": _timeZone
                                };

                                Provider.of<DriverActivityCompleteViewModel>(
                                        context,
                                        listen: false)
                                    .fetchDriverActivityCompleteViewModel(
                                        data, context)
                                    .then((response) {
                                  // setState(() {
                                  Provider.of<DriverPackageDetailViewModel>(
                                          context,
                                          listen: false)
                                      .updateDayStatus('COMPLETED');
                                  // hideBtn = false;
                                  // });
                                });
                                context.pop('update');
                              },
                      )
                    : const SizedBox()
              ],
            ),
            child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: packageActivityList.length,
                itemBuilder: (context, index) {
                  // activityStatus = packageActivityList[index].;
                  return ActivityContainer(
                    activityNo: "Activity ${index + 1}",
                    activityName:
                        packageActivityList[index].activityName?.toString() ??
                            "",
                    activityHour:
                        packageActivityList[index].activityHours?.toString() ??
                            "",
                    activityVisit: packageActivityList[index]
                            .bestTimeToVisit
                            ?.toString() ??
                        "",
                    address:
                        packageActivityList[index].address?.toString() ?? "",
                    closeTime:
                        packageActivityList[index].endTime?.toString() ?? "",
                    description:
                        packageActivityList[index].description?.toString() ??
                            "",
                    openTime:
                        packageActivityList[index].startTime?.toString() ?? "",
                  );
                }),
          ),
        ));
  }
}

class DetailsContainer extends StatelessWidget {
  final Widget child;
  final String driverId;
  final String driverAss;
  final String pickUpLocation;
  final String date;
  final String vehicleId;
  final String carName;
  final String year;
  final String brand;
  final String carType;
  final String fuelType;
  final String carColor;
  final String noOfSeat;
  final String vehicleNo;
  final String modelNo;
  final String userFirstName;
  final String userLastName;
  final String userCountryCode;
  final String userMobile;
  final String userEmail;
  final Widget? widgetButton;
  final VoidCallback? activityStartOnTap;

  const DetailsContainer(
      {super.key,
      required this.child,
      required this.driverId,
      required this.driverAss,
      required this.pickUpLocation,
      required this.date,
      required this.vehicleId,
      required this.carName,
      required this.year,
      required this.brand,
      required this.carType,
      required this.fuelType,
      required this.carColor,
      required this.noOfSeat,
      required this.vehicleNo,
      required this.modelNo,
      required this.userFirstName,
      required this.userLastName,
      required this.userCountryCode,
      required this.userMobile,
      this.activityStartOnTap,
      this.widgetButton,
      required this.userEmail});

  @override
  Widget build(BuildContext context) {
    String packagedayStatus = context
            .watch<DriverPackageDetailViewModel>()
            .driverPackageDetails
            .data
            ?.data
            .dayStatus ??
        '';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        packagedayStatus == 'COMPLETED'
            ? Container(
                margin: EdgeInsets.only(bottom: 10),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.green,
                    // border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(5)),
                child: const Row(
                  children: [
                    Icon(
                      Icons.check_circle,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    CustomTextWidget(
                        content: 'Journey Completed',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.white)
                  ],
                ),
              )
            : Container(),
        const CustomLogoTextWidget(
            logo: true,
            content: "Package Details",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            textColor: Colors.black),
        const SizedBox(height: 10),
        Container(
          // borderReq: true,
          // // height: AppDimension.getHeight(context) / 7,
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          // borderColor: naturalGreyColor.withOpacity(0.3),
          // elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: naturalGreyColor.withOpacity(0.3)),
              color: background),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const CustomTextWidget(
                      content: "Driver Id : ",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black),
                  SizedBox(
                    width: AppDimension.getWidth(context) * .7,
                    child: CustomTextWidget(
                        content: driverId,
                        // align: TextAlign.start,
                        fontSize: 15,
                        maxline: 3,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Driver Assign Id : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    CustomTextWidget(
                        content: driverAss,
                        // align: TextAlign.start,
                        fontSize: 15,
                        maxline: 3,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "PickUp Location : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .6,
                      child: CustomTextWidget(
                          content: pickUpLocation,
                          // : TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Date : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: date,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const CustomLogoTextWidget(
            logo: true,
            content: "Vehicle Details",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            textColor: Colors.black),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: naturalGreyColor.withOpacity(0.3)),
              color: background),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const CustomTextWidget(
                        content: "Vehicle Id : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: vehicleId,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Car Name : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: carName,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Year : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: year,
                          // : TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Brand : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: brand,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Car Type : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: carType,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Fuel Type : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: fuelType,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Car Color : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      // width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: carColor,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "No of Seats : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      // width: AppDimension.getWidth(context) * .7,
                      child: CustomTextWidget(
                          content: noOfSeat,
                          // align: TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Vehicle No : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    Expanded(
                      child: SizedBox(
                        // width: AppDimension.getWidth(context) * .7,
                        child: CustomTextWidget(
                            content: vehicleNo,
                            // align: TextAlign.start,
                            fontSize: 15,
                            maxline: 3,
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Model No : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    Expanded(
                      child: SizedBox(
                        // width: AppDimension.getWidth(context) * .7,
                        child: CustomTextWidget(
                            content: modelNo,
                            // align: TextAlign.start,
                            fontSize: 15,
                            maxline: 3,
                            fontWeight: FontWeight.w400,
                            textColor: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const CustomLogoTextWidget(
            logo: true,
            content: "User Details",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            textColor: Colors.black),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: naturalGreyColor.withOpacity(0.3)),
              color: background),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  const CustomTextWidget(
                      content: "User Name : ",
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black),
                  SizedBox(
                    // width: AppDimension.getWidth(context) * .7,
                    child: CustomTextWidget(
                        content: "$userFirstName $userLastName",
                        // align: TextAlign.start,
                        fontSize: 15,
                        maxline: 3,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Mobile No : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    CustomTextWidget(
                        content: "+$userCountryCode $userMobile",
                        // align: TextAlign.start,
                        fontSize: 15,
                        maxline: 3,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Email Id : ",
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black),
                    SizedBox(
                      // width: AppDimension.getWidth(context) * .6,
                      child: CustomTextWidget(
                          content: userEmail,
                          // : TextAlign.start,
                          fontSize: 15,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const CustomLogoTextWidget(
            logo: true,
            content: "Activity Details",
            fontSize: 20,
            fontWeight: FontWeight.w700,
            textColor: Colors.black),
        const SizedBox(height: 10),
        SizedBox(
          child: child,
        ),
        const SizedBox(height: 10),
        SizedBox(
          child: widgetButton,
        )
      ],
    );
  }
}

class ActivityContainer extends StatefulWidget {
  final String activityName;
  final String activityNo;
  final String description;
  final String activityHour;
  final String activityVisit;
  final String openTime;
  final String closeTime;
  final String address;

  const ActivityContainer(
      {required this.activityName,
      required this.description,
      required this.activityHour,
      required this.activityNo,
      required this.activityVisit,
      required this.openTime,
      required this.closeTime,
      required this.address,
      super.key});

  @override
  State<ActivityContainer> createState() => _ActivityContainerState();
}

class _ActivityContainerState extends State<ActivityContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: naturalGreyColor.withOpacity(0.3)),
                color: background),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                  decoration: const BoxDecoration(
                      color: btnColor,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  child: CustomTextWidget(
                    content: widget.activityNo,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    textColor: background,
                  ),
                ),
                const SizedBox(height: 5),
                CustomTextWidget(
                  content: widget.activityName,
                  maxline: 3,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  textColor: Colors.black,
                ),
                const SizedBox(height: 5),

                ///1st Row of Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Activity Hours : ${widget.activityHour} ",
                      style: titleTextStyle,
                    ),
                    Text(
                      "Time To Visit : ${widget.activityVisit} ",
                      style: titleTextStyle,
                    ),
                    // Expanded(
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "Activity Hours : ",
                    //         style: titleTextStyle,
                    //       ),
                    //       SizedBox(
                    //         width: 40,
                    //         child: Text(
                    //           widget.activityHour,
                    //           maxLines: 3,
                    //           style: titleTextStyle,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // Expanded(
                    //   child: Row(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Text(
                    //         "Time To Visit : ",
                    //         style: titleTextStyle,
                    //       ),
                    //       SizedBox(
                    //         width: 100,
                    //         child: Text(
                    //           widget.activityVisit,
                    //           maxLines: 3,
                    //           style: titleTextStyle,
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                  ],
                ),
                const SizedBox(height: 10),

                ///2nd Row of Details
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Opening Time : ${widget.openTime}",
                      style: titleTextStyle,
                    ),
                    Text(
                      "Closing Time : ${widget.openTime}",
                      style: titleTextStyle,
                    ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Opening Time : ",
                    //       style: titleTextStyle,
                    //     ),
                    //     SizedBox(
                    //       width: 40,
                    //       child: Text(
                    //         widget.openTime,
                    //         maxLines: 3,
                    //         style: titleTextStyle,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Text(
                    //       "Closing Time : ",
                    //       style: titleTextStyle,
                    //     ),
                    //     SizedBox(
                    //       width: 100,
                    //       child: Text(
                    //         widget.closeTime,
                    //         maxLines: 3,
                    //         style: titleTextStyle,
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const CustomTextWidget(
                        content: "Location : ",
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        textColor: textColor),
                    SizedBox(
                      // color: Colors.cyan,
                      width: AppDimension.getWidth(context) * .65,
                      child: CustomTextWidget(
                          content: widget.address,
                          fontSize: 18,
                          maxline: 5,
                          fontWeight: FontWeight.w400,
                          textColor: textColor),
                    )
                  ],
                ),

                // RichText(
                //     text: TextSpan(children: [
                //   // TextSpan(
                //   //     text: "Location : ",
                //   //     style: GoogleFonts.lato(
                //   //         fontSize: 14,
                //   //         fontWeight: FontWeight.w600,
                //   //         color: textColor)),
                //   TextSpan(
                //       text: ,
                //       style: GoogleFonts.lato(
                //           fontSize: 14,
                //           fontWeight: FontWeight.w400,
                //           color: textColor))
                // ])),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

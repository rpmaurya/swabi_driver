import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driverPackageModel.dart';
import 'package:flutter_driver/model/driverpackageHistoryModel.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/customTextWidget.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/view_model/driverPackage_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PackageBookingList extends StatefulWidget {
  final String myId;
  final String historylist;

  const PackageBookingList(
      {super.key, required this.myId, required this.historylist});

  @override
  State<PackageBookingList> createState() => _PackageBookingListState();
}

class _PackageBookingListState extends State<PackageBookingList> {
  List<Datum> packageList = [];
  bool loader = false;
  int selectedIndex = -1;
  List<PackageHistoryData> packagedayHistoryList = [];
  // List<Datum> packagedDetail = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updatePackageList();
  }

  var status;
  void _updatePackageList() {
    final driverPackageViewModel =
        context.watch<DriverPackageBookingListViewModel>();
    status = driverPackageViewModel.driverPackageList.status.toString();

    if (status == "Status.completed") {
      setState(() {
        packageList = driverPackageViewModel.driverPackageList.data?.data ?? [];
        packagedayHistoryList = context
                .watch<DriverPackageBookingHistoryListViewModel>()
                .driverPackageList
                .data
                ?.data ??
            [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final driverPackageViewModel =
        context.watch<DriverPackageBookingListViewModel>();
    String status = context
        .watch<DriverPackageBookingListViewModel>()
        .driverPackageList
        .status
        .toString();
    if (status == "Status.completed") {
      setState(() {
        packageList = driverPackageViewModel.driverPackageList.data?.data ?? [];
      });
    }
    String packageDetailStatus = context
        .watch<DriverPackageDetailViewModel>()
        .driverPackageDetails
        .status
        .toString();
    String packageHistoryStatus = context
        .watch<DriverPackageBookingHistoryListViewModel>()
        .driverPackageList
        .status
        .toString();
    if (packageHistoryStatus == 'Status.completed') {
      packagedayHistoryList = context
              .watch<DriverPackageBookingHistoryListViewModel>()
              .driverPackageList
              .data
              ?.data ??
          [];
    }
    // packagedayStatus = context
    //         .watch<DriverPackageBookingListViewModel>()
    //         .driverPackageList
    //         .data
    //         ?.data ??
    //     [];

    // packagedDetail = context
    //         .watch<DriverPackageBookingListViewModel>()
    //         .driverPackageList
    //         .data
    //         ?.data ??
    //     [];

    debugPrint("${widget.historylist}Packagehistory List dayStatus");
    debugPrint("${widget.myId}Package List ID");
    debugPrint("${packageList.length} Package List ID");
    return PageLayout_Curve(
        appHeading: "Package",
        padding: EdgeInsets.zero,
        child:
            // status == "Status.loading" ||
            //         packageHistoryStatus == 'Status.loading'
            //     ? const Center(
            //         child: CircularProgressIndicator(
            //         color: Colors.green,
            //       ))
            //     :
            packageList.isNotEmpty || packagedayHistoryList.isNotEmpty
                ? ListView.builder(
                    itemCount: widget.historylist == 'historyList'
                        ? packagedayHistoryList.length
                        : packageList.length,
                    itemBuilder: (context, index) {
                      // var data = widget.historylist == 'historyList'
                      //     ? packagedayHistoryList
                      //     : packageList;
                      // final activityListData = packageList[index].activityList;
                      var activityListData = widget.historylist == 'historyList'
                          ? []
                          : packageList[index].activityList ?? [];
                      var activityHistoryData =
                          widget.historylist == 'historyList'
                              ? packagedayHistoryList[index].activityList ?? []
                              : [];

                      return DriverPackageContainer(
                          index: index,
                          driverAssign: widget.historylist == 'historyList'
                              ? packagedayHistoryList[index]
                                  .driverAssignedId
                                  .toString()
                              : packageList[index].driverAssignedId.toString(),
                          // packageList[index].driverAssignedId.toString(),
                          pickUpLocation: widget.historylist == 'historyList'
                              ? packagedayHistoryList[index]
                                  .pickupLocation
                                  .toString()
                              : packageList[index].pickupLocation.toString(),
                          activity: "",
                          activityName: List.generate(
                              widget.historylist == 'historyList'
                                  ? packagedayHistoryList[index]
                                      .activityList!
                                      .length
                                  : activityListData.length,
                              (index) => widget.historylist == 'historyList'
                                  ? activityHistoryData[index]
                                      .activityName
                                      .toString()
                                  : activityListData[index]
                                      .activityName
                                      .toString()),
                          driverId: widget.historylist == 'historyList'
                              ? packagedayHistoryList[index].driverId.toString()
                              : packageList[index].driverId.toString(),
                          total: widget.historylist == 'historyList'
                              ? packagedayHistoryList[index]
                                  .isCancelled
                                  .toString()
                              : packageList[index].isCancelled.toString(),
                          date: widget.historylist == 'historyList'
                              ? packagedayHistoryList[index].date.toString()
                              : packageList[index].date.toString(),
                          dayStatus: widget.historylist == 'historyList'
                              ? packagedayHistoryList[index]
                                  .dayStatus
                                  .toString()
                              : packageList[index].dayStatus ?? '',
                          loader: widget.historylist == 'historyList'
                              ? packageHistoryStatus == 'Status.loading'
                              : packageDetailStatus == "Status.loading" &&
                                  loader &&
                                  selectedIndex == index,
                          ontap: () {
                            setState(() {
                              selectedIndex = index;
                              loader = true;
                            });
                            Provider.of<DriverPackageDetailViewModel>(context,
                                    listen: false)
                                .fetchDriverPackageDetailViewModel(
                                    {
                                  "driverAssignedId": packageList[index]
                                      .driverAssignedId
                                      .toString()
                                },
                                    context,
                                    packageList[index]
                                        .driverAssignedId
                                        .toString());
                          });
                      //   PackageContainer(
                      //   driverAssID: packageList[index].driverAssignedId?.toString() ?? '',
                      //   driverID: packageList[index].driverId?.toString() ?? '',
                      //   date: packageList[index].date?.toString() ?? '',
                      //   pickUpLocation: packageList[index].pickupLocation?.toString() ?? '',
                      //     cancelled: packageList[index].isCancelled?.toString() ?? '',
                      //   vehicleID: packageList[index].vehicle?.vehicleId.toString() ?? '',
                      //   carName: packageList[index].vehicle?.carName.toString() ?? '',
                      //   fuel: packageList[index].vehicle?.fuelType.toString() ?? '',
                      //   vehicleNo: packageList[index].vehicle?.vehicleNumber.toString() ?? '',
                      //   model:packageList[index].vehicle?.modelNo.toString() ?? '' ,
                      //   year: packageList[index].vehicle?.year.toString() ?? '',
                      //   seat: packageList[index].vehicle?.seats.toString() ?? '',
                      //   brand: packageList[index].vehicle?.brandName.toString() ?? '',
                      //
                      //
                      // );
                    })
                : Center(
                    child: Container(
                        decoration: const BoxDecoration(),
                        child: Text(
                          "No Data",
                          style: GoogleFonts.lato(
                              fontSize: 15,
                              color: redColor,
                              fontWeight: FontWeight.w600),
                        )
                        // child: Image.asset(
                        //   noData,
                        //   height: 150,
                        // ),
                        )));
  }
}

class PackageContainer extends StatelessWidget {
  final String driverID;
  final String driverAssID;
  final String pickUpLocation;
  final String date;
  final String cancelled;

  /////Vehicle Details
  final String vehicleID;
  final String carName;
  final String fuel;
  final String vehicleNo;
  final String model;
  final String year;
  final String seat;
  final String brand;

  ////Activity Details
  const PackageContainer(
      {super.key,
      required this.driverID,
      required this.driverAssID,
      required this.pickUpLocation,
      required this.date,
      required this.cancelled,
      required this.vehicleID,
      required this.carName,
      required this.fuel,
      required this.vehicleNo,
      required this.model,
      required this.year,
      required this.seat,
      required this.brand});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: naturalGreyColor.withOpacity(0.3))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.symmetric(
                        horizontal: BorderSide(
                            color: naturalGreyColor.withOpacity(0.3)))),
                child: const Align(
                  alignment: Alignment.center,
                  child: CustomTextWidget(
                    content: "Driver Details",
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    textColor: Colors.black,
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const CustomTextWidget(
                      content: "Driver Assign ID : ",
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      textColor: Colors.black,
                    ),
                    CustomTextWidget(
                      content: driverAssID,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                    ),
                  ]),
                  Row(
                    children: [
                      const CustomTextWidget(
                        content: "Date : ",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black,
                      ),
                      CustomTextWidget(
                        content: date,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CustomTextWidget(
                        content: "Driver ID : ",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black,
                      ),
                      CustomTextWidget(
                        content: driverID,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const CustomTextWidget(
                        content: "Cancelled : ",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black,
                      ),
                      CustomTextWidget(
                        content: cancelled,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        textColor: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),

            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomTextWidget(
                    content: "PickUp Location : ",
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    textColor: Colors.black,
                  ),
                  SizedBox(
                    width: AppDimension.getWidth(context) * .55,
                    child: CustomTextWidget(
                      content: pickUpLocation,
                      fontSize: 16,
                      maxline: 3,
                      fontWeight: FontWeight.w400,
                      textColor: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: naturalGreyColor.withOpacity(0.3)))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CustomTextWidget(
                          content: "Vehicle Details",
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const CustomTextWidget(
                              content: "Vehicle ID : ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black,
                            ),
                            SizedBox(
                              child: CustomTextWidget(
                                content: vehicleID,
                                fontSize: 16,
                                maxline: 3,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const CustomTextWidget(
                              content: "Year : ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black,
                            ),
                            SizedBox(
                              child: CustomTextWidget(
                                content: year,
                                fontSize: 16,
                                maxline: 3,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const CustomTextWidget(
                              content: "Car Name : ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black,
                            ),
                            SizedBox(
                              width: AppDimension.getWidth(context) * .35,
                              child: CustomTextWidget(
                                content: carName,
                                fontSize: 16,
                                maxline: 3,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const CustomTextWidget(
                              content: "Seat : ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black,
                            ),
                            SizedBox(
                              child: CustomTextWidget(
                                content: seat,
                                fontSize: 16,
                                maxline: 3,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CustomTextWidget(
                              content: "Fuel : ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black,
                            ),
                            SizedBox(
                              child: CustomTextWidget(
                                content: fuel,
                                fontSize: 16,
                                maxline: 3,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const CustomTextWidget(
                              content: "Brand : ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black,
                            ),
                            SizedBox(
                              child: CustomTextWidget(
                                content: brand,
                                fontSize: 16,
                                maxline: 3,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const CustomTextWidget(
                              content: "Vehicle No : ",
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              textColor: Colors.black,
                            ),
                            SizedBox(
                              child: CustomTextWidget(
                                content: vehicleNo,
                                fontSize: 16,
                                maxline: 3,
                                fontWeight: FontWeight.w400,
                                textColor: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      const CustomTextWidget(
                        content: "Model : ",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textColor: Colors.black,
                      ),
                      SizedBox(
                        child: CustomTextWidget(
                          content: model,
                          fontSize: 16,
                          maxline: 3,
                          fontWeight: FontWeight.w400,
                          textColor: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            ///Activity Details
            Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.symmetric(
                              horizontal: BorderSide(
                                  color: naturalGreyColor.withOpacity(0.3)))),
                      child: const Align(
                        alignment: Alignment.center,
                        child: CustomTextWidget(
                          content: "Activity Details",
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          textColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  /////////////////////ACTIVITY LIST CONTAINER///////////////////////////////////////
                  SizedBox(
                    height: AppDimension.getHeight(context) * .4,
                    child: ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          content: "Activity ID : ",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(
                                          child: CustomTextWidget(
                                            content: "",
                                            fontSize: 16,
                                            maxline: 3,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          content: "Country : ",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(
                                          child: CustomTextWidget(
                                            content: "",
                                            fontSize: 16,
                                            maxline: 3,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const CustomTextWidget(
                                          content: "State : ",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(
                                          width:
                                              AppDimension.getWidth(context) *
                                                  .3,
                                          child: const CustomTextWidget(
                                            content: "",
                                            fontSize: 16,
                                            maxline: 3,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        CustomTextWidget(
                                          content: "Hour : ",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(
                                          child: CustomTextWidget(
                                            content: "",
                                            fontSize: 16,
                                            maxline: 3,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          content: "Start Time : ",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(
                                          child: CustomTextWidget(
                                            content: "",
                                            fontSize: 16,
                                            maxline: 3,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          content: "End Time : ",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(
                                          child: CustomTextWidget(
                                            content: "",
                                            fontSize: 16,
                                            maxline: 3,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CustomTextWidget(
                                          content: "Best Time To Visit : ",
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          textColor: Colors.black,
                                        ),
                                        SizedBox(
                                          child: CustomTextWidget(
                                            content: "",
                                            fontSize: 16,
                                            maxline: 3,
                                            fontWeight: FontWeight.w400,
                                            textColor: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    CustomTextWidget(
                                      content: "City : ",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black,
                                    ),
                                    SizedBox(
                                      child: CustomTextWidget(
                                        content: "",
                                        fontSize: 16,
                                        maxline: 3,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    CustomTextWidget(
                                      content: "Address : ",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black,
                                    ),
                                    SizedBox(
                                      child: CustomTextWidget(
                                        content: "",
                                        fontSize: 16,
                                        maxline: 3,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomTextWidget(
                                      content: "Activity Name : ",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black,
                                    ),
                                    SizedBox(
                                      width:
                                          AppDimension.getWidth(context) * .55,
                                      child: const CustomTextWidget(
                                        content: "",
                                        fontSize: 16,
                                        maxline: 3,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    CustomTextWidget(
                                      content: "Price : ",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black,
                                    ),
                                    SizedBox(
                                      child: CustomTextWidget(
                                        content: "",
                                        fontSize: 16,
                                        maxline: 3,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  children: [
                                    const CustomTextWidget(
                                      content: "Description : ",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black,
                                    ),
                                    SizedBox(
                                      width:
                                          AppDimension.getWidth(context) * .55,
                                      child: const CustomTextWidget(
                                        content: "",
                                        fontSize: 16,
                                        maxline: 3,
                                        fontWeight: FontWeight.w400,
                                        textColor: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DriverPackageContainer extends StatefulWidget {
  final int index;
  final String pickUpLocation;
  final String driverId;
  final String activity;
  final List<String> activityName;
  final String date;
  final String total;
  final String driverAssign;
  final String dayStatus;
  final bool loader;
  final VoidCallback ontap;

  const DriverPackageContainer(
      {super.key,
      required this.index,
      required this.driverAssign,
      required this.pickUpLocation,
      required this.activity,
      required this.activityName,
      required this.driverId,
      required this.total,
      required this.date,
      required this.dayStatus,
      this.loader = false,
      required this.ontap});

  @override
  State<DriverPackageContainer> createState() => _DriverPackageContainerState();
}

class _DriverPackageContainerState extends State<DriverPackageContainer> {
  int currentIndex = 0;

  // Timer? timer;
  //
  @override
  void initState() {
    super.initState();
    widget.dayStatus;
    // timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
    //   setState(() {
    //     currentIndex = (currentIndex + 1) % widget.packageImg.length;
    //   });
    // });
  }

  @override
  void dispose() {
    // timer?.cancel();
    super.dispose();
  }

  // List<Datum>? packageList;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: SizedBox(
        child: Material(
          elevation: 0,
          color: background,
          borderRadius: BorderRadius.circular(5),
          child: InkWell(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Container(
                      //   // height: 40,
                      //   width: double.infinity,
                      //   decoration: const BoxDecoration(
                      //       // border: Border(bottom: BorderSide(color: greyColor1))
                      //   ),
                      //   child: Row(
                      //     mainAxisAlignment: MainAxisAlignment.start,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: [
                      //
                      //     ],
                      //   ),
                      // ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CustomTextWidget(
                                    content: "Driver Assign Id : ",
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    textColor: Colors.black),
                                SizedBox(
                                  // width: AppDimension.getWidth(context)*.65,
                                  child: CustomTextWidget(
                                      content: widget.driverAssign,
                                      // align: TextAlign.start,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      textColor: textColor),
                                ),
                                // Container(
                                //   margin: const EdgeInsets.only(right: 5),
                                //   child: const CustomTextWidget(content: "Driver Id : ",
                                //       fontSize: 16, fontWeight: FontWeight.w500, textColor: Colors.black),
                                // ),
                                // SizedBox(
                                //   width: AppDimension.getWidth(context) *.25,
                                //   child:CustomTextWidget(
                                //     content: widget.driverId.toUpperCase(),
                                //     fontSize: 15,
                                //     maxline: 2,
                                //     fontWeight: FontWeight.w400,
                                //     // align: TextAlign.start,
                                //     textColor: Colors.black,
                                //   ),
                                // ),
                                const Spacer(),
                                Container(
                                  margin: const EdgeInsets.only(right: 5),
                                  child: const CustomTextWidget(
                                      content: "Date : ",
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      textColor: Colors.black),
                                ),
                                SizedBox(
                                  width: AppDimension.getWidth(context) * .3,
                                  child: CustomTextWidget(
                                    content: widget.date.toUpperCase(),
                                    fontSize: 15,
                                    maxline: 2,
                                    fontWeight: FontWeight.w400,
                                    // align: TextAlign.start,
                                    textColor: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget.pickUpLocation.isNotEmpty
                              ? Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(right: 5),
                                        child: const CustomTextWidget(
                                            content: "PickUp Location : ",
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            textColor: Colors.black),
                                      ),
                                      SizedBox(
                                        // color: Colors.grey,
                                        width: AppDimension.getWidth(context) *
                                            .55,
                                        child: CustomTextWidget(
                                          content: widget.pickUpLocation,
                                          fontSize: 15,
                                          maxline: 10,
                                          // align: TextAlign.start,
                                          textColor: Colors.black,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                          widget.activityName.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(
                                      right: 5, bottom: 5),
                                  child: const CustomTextWidget(
                                      content: "Activities Name : ",
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      textColor: Colors.black),
                                )
                              : const SizedBox(),
                          Column(
                            children: List.generate(
                                widget.activityName.length,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(top: 2),
                                            child: Icon(
                                              Icons.check,
                                              color: greenColor,
                                              size: 13,
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 2),
                                              width: AppDimension.getWidth(
                                                      context) *
                                                  .8,
                                              // color: Colors.cyan,
                                              child: CustomTextWidget(
                                                content:
                                                    widget.activityName[index],
                                                textColor: greenColor,
                                                fontSize: 15,
                                                maxline: 2,
                                                fontWeight: FontWeight.w400,
                                                // align: TextAlign.start,
                                              ))
                                          // RichText(
                                          //     text: TextSpan(children: [
                                          //       TextSpan(
                                          //           text: "Activity : ",
                                          //           style: packagetextTextStyle),
                                          //       TextSpan(
                                          //           text: widget.activity,
                                          //           style: packagetextTextStyle),
                                          //     ])),
                                        ],
                                      ),
                                    )),
                          ),
                        ],
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 5, bottom: 5, right: 5),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          // color: greyColor1.withOpacity(.1),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 35,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  widget.dayStatus,
                                  style: TextStyle(color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            CustomButtonSmall(
                              width: AppDimension.getWidth(context) * .25,
                              height: 40,
                              loading: widget.loader,
                              btnHeading: "View",
                              onTap: widget.ontap,
                            ),
                            // RichText(
                            //     text: TextSpan(children: [
                            //       TextSpan(
                            //           text: "AED",
                            //           style: GoogleFonts.nunito(
                            //               color: Colors.black,
                            //               fontSize: 15,
                            //               fontWeight: FontWeight.w700)),
                            //       TextSpan(
                            //           text: " ${widget.total}".toUpperCase(),
                            //           style: GoogleFonts.nunito(
                            //               color: Colors.black,
                            //               fontSize: 15,
                            //               fontWeight: FontWeight.w700)),
                            //       TextSpan(
                            //           text: " / Person",
                            //           style: GoogleFonts.nunito(
                            //               color: greyColor1,
                            //               fontSize: 12,
                            //               fontWeight: FontWeight.w600)),
                            //     ])),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

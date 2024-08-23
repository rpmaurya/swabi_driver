import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driverBookingModel.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/view/dashboard/rental/history/allBookingPageData.dart';
import 'package:flutter_driver/view_model/driverBooking_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DriverHistoryManagment extends StatefulWidget {
  final String myID;

  const DriverHistoryManagment({super.key, required this.myID});

  @override
  State<DriverHistoryManagment> createState() => _DriverHistoryManagmentState();
}

class _DriverHistoryManagmentState extends State<DriverHistoryManagment> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        Provider.of<DriverGetBookingListViewModel>(context, listen: false)
            .fetchDriverGetBookingListViewModel({
          'driverId': widget.myID,
          'pageNumber': '0',
          'pageSize': '10',
          'bookingStatus': 'BOOKED',
        }, context);

        Provider.of<DriverGetBookingListViewModel>(context, listen: false)
            .fetchDriverGetBookingListViewModel1({
          'driverId': widget.myID,
          'pageNumber': '0',
          'pageSize': '10',
          'bookingStatus': 'ON_RUNNING'
        }, context);

        Provider.of<DriverGetBookingListViewModel>(context, listen: false)
            .fetchDriverGetBookingListViewModel2({
          'driverId': widget.myID,
          'pageNumber': '0',
          'pageSize': '10',
          'bookingStatus': 'COMPLETED'
        }, context);

        Provider.of<DriverGetBookingListViewModel>(context, listen: false)
            .fetchDriverGetBookingListViewModel3({
          'driverId': widget.myID,
          'pageNumber': '0',
          'pageSize': '10',
          'bookingStatus': 'CANCELLED'
        }, context);
      },
    );
  }

  List<Content> bookedData = [];
  List<Content> onRunningData = [];
  List<Content> completedData = [];
  List<Content> cancelledData = [];

  @override
  Widget build(BuildContext context) {
    String bookedStatus = context
        .watch<DriverGetBookingListViewModel>()
        .DataList
        .status
        .toString();
    String onRunningStatus = context
        .watch<DriverGetBookingListViewModel>()
        .DataList
        .status
        .toString();
    String completedStatus = context
        .watch<DriverGetBookingListViewModel>()
        .DataList
        .status
        .toString();
    String cancelledStatus = context
        .watch<DriverGetBookingListViewModel>()
        .DataList
        .status
        .toString();
    if (bookedStatus == "Status.completed") {
      bookedData = context
              .watch<DriverGetBookingListViewModel>()
              .DataList
              .data
              ?.data
              .content ??
          [];
    }
    if (onRunningStatus == "Status.completed") {
      onRunningData = context
              .watch<DriverGetBookingListViewModel>()
              .DataList1
              .data
              ?.data
              .content ??
          [];
    }
    if (completedStatus == "Status.completed") {
      completedData = context
              .watch<DriverGetBookingListViewModel>()
              .DataList2
              .data
              ?.data
              .content ??
          [];
    }
    if (cancelledStatus == "Status.completed") {
      cancelledData = context
              .watch<DriverGetBookingListViewModel>()
              .DataList3
              .data
              ?.data
              .content ??
          [];
    }

    return DefaultTabController(
      length: 4,
      // child: Scaffold(
      //   backgroundColor: bgGreyColor,
      //   appBar: AppBar(
      //     backgroundColor: background,
      //     title: const Text("Rental Booking"),
      //     centerTitle: true,
      //   ),
      //   body:
      // ),
      child: CustomPagelayout(
        appBarTitle: 'Rental Booking',
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: btnColor),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              child: TabBar(
                indicator: const BoxDecoration(
                    color: Colors.transparent,
                    border:
                        Border(bottom: BorderSide(width: 5, color: btnColor)),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
                splashBorderRadius: BorderRadius.circular(20),
                unselectedLabelColor: Colors.black87,
                labelColor: btnColor,
                indicatorColor: Colors.transparent,
                dividerColor: Colors.transparent,
                indicatorPadding: EdgeInsets.only(left: 5, right: 5),
                labelPadding: const EdgeInsets.symmetric(vertical: 5),
                tabAlignment: TabAlignment.fill,
                indicatorSize: TabBarIndicatorSize.tab,
                onTap: (value) {
                  WidgetsBinding.instance.addPostFrameCallback(
                    (timeStamp) {
                      if (value == 0) {
                        Provider.of<DriverGetBookingListViewModel>(context,
                                listen: false)
                            .fetchDriverGetBookingListViewModel({
                          'driverId': widget.myID,
                          'pageNumber': '0',
                          'pageSize': '10',
                          'bookingStatus': 'BOOKED',
                        }, context);
                      } else if (value == 1) {
                        Provider.of<DriverGetBookingListViewModel>(context,
                                listen: false)
                            .fetchDriverGetBookingListViewModel1({
                          'driverId': widget.myID,
                          'pageNumber': '0',
                          'pageSize': '10',
                          'bookingStatus': 'ON_RUNNING',
                        }, context);
                      } else if (value == 2) {
                        Provider.of<DriverGetBookingListViewModel>(context,
                                listen: false)
                            .fetchDriverGetBookingListViewModel2({
                          'driverId': widget.myID,
                          'pageNumber': '0',
                          'pageSize': '10',
                          'bookingStatus': 'COMPLETED',
                        }, context);
                      } else {
                        Provider.of<DriverGetBookingListViewModel>(context,
                                listen: false)
                            .fetchDriverGetBookingListViewModel3({
                          'driverId': widget.myID,
                          'pageNumber': '0',
                          'pageSize': '10',
                          'bookingStatus': 'CANCELLED',
                        }, context);
                      }
                    },
                  );
                },
                tabs: const [
                  Tab(text: "Booked"),
                  Tab(text: "Ongoing"),
                  Tab(text: "Completed"),
                  Tab(text: "Cancelled"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                buildTabView(
                    context, "Status.completed", bookedData, bookedStatus),
                buildTabView(context, "Status.completed", onRunningData,
                    onRunningStatus),
                buildTabView(context, "Status.completed", completedData,
                    completedStatus),
                buildTabView(context, "Status.completed", cancelledData,
                    cancelledStatus),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabView(BuildContext context, String status, List<dynamic> data,
      String currentStatus) {
    if (currentStatus == status) {
      if (data.isNotEmpty) {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: data.length,
          itemBuilder: (context, index) {
            // Safeguard to ensure index is within bounds
            if (index < 0 || index >= data.length) {
              return const SizedBox
                  .shrink(); // Return an empty widget if the index is out of bounds
            }
            final item = data[index];
            return HistoryDetailsContainer(
              onTapContainer: () {
                Provider.of<DriverGetBookingDetailsViewModel>(context,
                        listen: false)
                    .fetchDriverGetBookingDetailsViewModel({
                  "id": item.id.toString(),
                }, context, item.id.toString(), widget.myID).then((value) {});
              },
              seat: item.vehicle?.seats?.toString() ?? "",
              fuelType: item.vehicle?.fuelType?.toString() ?? "",
              carName: item.carType?.toString() ?? "",
              status: item.bookingStatus?.toString() ?? "",
              date: item.date?.toString() ?? "",
              rentalCharge: item.rentalCharge?.toString() ?? "",
            );
          },
        );
      } else {
        return Center(
          child: Container(
            decoration: const BoxDecoration(),
            child: Text(
              "No Data",
              style: GoogleFonts.lato(
                fontSize: 15,
                color: Colors.red,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.green,
        ),
      );
    }

    // String bookedStatus = context
    //     .watch<DriverGetBookingListViewModel>()
    //     .DataList
    //     .status
    //     .toString();
    // String onRunningStatus = context
    //     .watch<DriverGetBookingListViewModel>()
    //     .DataList
    //     .status
    //     .toString();
    // String completedStatus = context
    //     .watch<DriverGetBookingListViewModel>()
    //     .DataList
    //     .status
    //     .toString();
    // String cancelledStatus = context
    //     .watch<DriverGetBookingListViewModel>()
    //     .DataList
    //     .status
    //     .toString();
    // if (bookedStatus == "Status.completed") {
    //   bookedData = context
    //           .watch<DriverGetBookingListViewModel>()
    //           .DataList
    //           .data
    //           ?.data
    //           .content ??
    //       [];
    // }
    // if (onRunningStatus == "Status.completed") {
    //   onRunningData = context
    //           .watch<DriverGetBookingListViewModel>()
    //           .DataList1
    //           .data
    //           ?.data
    //           .content ??
    //       [];
    // }
    // if (completedStatus == "Status.completed") {
    //   completedData = context
    //           .watch<DriverGetBookingListViewModel>()
    //           .DataList2
    //           .data
    //           ?.data
    //           .content ??
    //       [];
    // }
    // if (cancelledStatus == "Status.completed") {
    //   cancelledData = context
    //           .watch<DriverGetBookingListViewModel>()
    //           .DataList3
    //           .data
    //           ?.data
    //           .content ??
    //       [];
    // }
    // return DefaultTabController(
    //   length: 4,
    //   child: PageLayout_Curve(
    //       appHeading: "Booking History",
    //       child: SizedBox(
    //         child: Column(
    //           children: [
    //             const SizedBox(height: 10),
    //             Material(
    //               elevation: 0,
    //               color: background,
    //               borderRadius: BorderRadius.circular(10),
    //               child: Container(
    //                 decoration: BoxDecoration(
    //                     color: background,
    //                     borderRadius: BorderRadius.circular(11),
    //                     border: Border.all(
    //                         color: naturalGreyColor.withOpacity(0.3))),
    //                 child: TabBar(
    //                     indicatorSize: TabBarIndicatorSize.tab,
    //                     labelPadding: const EdgeInsets.symmetric(vertical: 5),
    //                     tabAlignment: TabAlignment.fill,
    //                     // isScrollable: true,
    //                     indicator: BoxDecoration(
    //                         borderRadius: BorderRadius.circular(10),
    //                         color: btnColor),
    //                     labelColor: background,
    //                     dividerColor: Colors.transparent,
    //                     unselectedLabelColor: Colors.black,
    //                     tabs: [
    //                       Tab(
    //                           child: Text(
    //                         "Booked",
    //                         style: GoogleFonts.lato(
    //                             fontSize: 15, fontWeight: FontWeight.w700),
    //                       )),
    //                       Tab(
    //                           child: Text(
    //                         // "ON\nRunning",
    //                         'Ongoing',
    //                         style: GoogleFonts.lato(
    //                             fontSize: 15, fontWeight: FontWeight.w700),
    //                         textAlign: TextAlign.center,
    //                       )),
    //                       Tab(
    //                           child: Text("Completed",
    //                               textAlign: TextAlign.center,
    //                               style: GoogleFonts.lato(
    //                                   fontSize: 15,
    //                                   fontWeight: FontWeight.w700))),
    //                       Tab(
    //                           child: Text("Cancelled",
    //                               style: GoogleFonts.lato(
    //                                   fontSize: 15,
    //                                   fontWeight: FontWeight.w700))),
    //                     ]),
    //               ),
    //             ),
    //             const SizedBox(height: 10),
    //             Expanded(
    //               child: TabBarView(children: [
    //                 bookedStatus == "Status.completed"
    //                     ? bookedData.isNotEmpty
    //                         ? ListView.builder(
    //                             physics: const BouncingScrollPhysics(),
    //                             itemCount: bookedData.length,
    //                             itemBuilder: (context, index) =>
    //                                 HistoryDetailsContainer(
    //                                   onTapContainer: () {
    //                                     Provider.of<DriverGetBookingDetailsViewModel>(
    //                                             context,
    //                                             listen: false)
    //                                         .fetchDriverGetBookingDetailsViewModel(
    //                                             {
    //                                           "id": bookedData[index]
    //                                               .id
    //                                               .toString(),
    //                                         },
    //                                             context,
    //                                             bookedData[index].id.toString(),
    //                                             widget.myID);
    //                                   },
    //                                   // carImage: bookedData[index].vehicle.images.toString(),
    //                                   seat: bookedData[index]
    //                                           .vehicle!
    //                                           .seats
    //                                           ?.toString() ??
    //                                       "",
    //                                   fuelType: bookedData[index]
    //                                           .vehicle!
    //                                           .fuelType
    //                                           ?.toString() ??
    //                                       "",
    //                                   carName: bookedData[index]
    //                                           .carType
    //                                           ?.toString() ??
    //                                       "",
    //                                   status: bookedData[index]
    //                                           .bookingStatus
    //                                           ?.toString() ??
    //                                       "",
    //                                   date:
    //                                       bookedData[index].date?.toString() ??
    //                                           "",
    //                                   rentalCharge: bookedData[index]
    //                                           .rentalCharge
    //                                           ?.toString() ??
    //                                       "",
    //                                 ))
    //                         : Center(
    //                             child: Container(
    //                                 decoration: const BoxDecoration(),
    //                                 child: Text(
    //                                   "No Data",
    //                                   style: GoogleFonts.lato(
    //                                       fontSize: 15,
    //                                       color: redColor,
    //                                       fontWeight: FontWeight.w600),
    //                                 )
    //                                 // child: Image.asset(
    //                                 //   noData,
    //                                 //   height: 150,
    //                                 // ),
    //                                 ))
    //                     : const Center(
    //                         child: CircularProgressIndicator(
    //                           color: Colors.green,
    //                         ),
    //                       ),
    //                 onRunningStatus == "Status.completed"
    //                     ? onRunningData.isNotEmpty
    //                         ? ListView.builder(
    //                             physics: const BouncingScrollPhysics(),
    //                             itemCount: onRunningData.length,
    //                             itemBuilder: (context, index) =>
    //                                 HistoryDetailsContainer(
    //                                   onTapContainer: () {
    //                                     Provider.of<DriverGetBookingDetailsViewModel>(
    //                                             context,
    //                                             listen: false)
    //                                         .fetchDriverGetBookingDetailsViewModel(
    //                                             {
    //                                           "id": onRunningData[index]
    //                                               .id
    //                                               .toString(),
    //                                         },
    //                                             context,
    //                                             onRunningData[index]
    //                                                 .id
    //                                                 .toString(),
    //                                             widget.myID);
    //                                     setState(() {
    //                                       print(onRunningData[index]
    //                                           .id
    //                                           .toString());
    //                                     });
    //                                     // Provider.of<DriverOnRunningViewModel>(context,listen: false).
    //                                     // fetchDriverStartRideViewModel({
    //                                     //   "id": onRunningData[index].id.toString(),
    //                                     //   "bookingStatus":"ON_RUNNING"
    //                                     // },context,onRunningData[index].id.toString(),widget.myID);
    //                                   },
    //                                   seat: onRunningData[index]
    //                                           .vehicle!
    //                                           .seats
    //                                           ?.toString() ??
    //                                       "",
    //                                   fuelType: onRunningData[index]
    //                                           .vehicle!
    //                                           .fuelType
    //                                           ?.toString() ??
    //                                       "",
    //                                   carName: onRunningData[index]
    //                                           .carType
    //                                           ?.toString() ??
    //                                       "",
    //                                   status: onRunningData[index]
    //                                           .bookingStatus
    //                                           ?.toString() ??
    //                                       "",
    //                                   date: onRunningData[index]
    //                                           .date
    //                                           ?.toString() ??
    //                                       "",
    //                                   rentalCharge: onRunningData[index]
    //                                           .rentalCharge
    //                                           ?.toString() ??
    //                                       '',
    //                                 ))
    //                         : Center(
    //                             child: Container(
    //                                 decoration: const BoxDecoration(),
    //                                 child: Text(
    //                                   "No Data",
    //                                   style: GoogleFonts.lato(
    //                                       fontSize: 15,
    //                                       color: redColor,
    //                                       fontWeight: FontWeight.w600),
    //                                 )))
    //                     : const Center(
    //                         child: CircularProgressIndicator(
    //                           color: Colors.green,
    //                         ),
    //                       ),
    //                 completedStatus == "Status.completed"
    //                     ? completedData.isNotEmpty
    //                         ? ListView.builder(
    //                             physics: const BouncingScrollPhysics(),
    //                             itemCount: completedData.length,
    //                             itemBuilder: (context, index) =>
    //                                 HistoryDetailsContainer(
    //                                   onTapContainer: () {
    //                                     Provider.of<DriverGetBookingDetailsViewModel>(
    //                                             context,
    //                                             listen: false)
    //                                         .fetchDriverGetBookingDetailsViewModel(
    //                                             {
    //                                           "id": completedData[index]
    //                                               .id
    //                                               .toString(),
    //                                         },
    //                                             context,
    //                                             completedData[index]
    //                                                 .id
    //                                                 .toString(),
    //                                             widget.myID);
    //                                   },
    //                                   seat: completedData[index]
    //                                           .vehicle!
    //                                           .seats
    //                                           ?.toString() ??
    //                                       "",
    //                                   fuelType: completedData[index]
    //                                           .vehicle!
    //                                           .fuelType
    //                                           ?.toString() ??
    //                                       "",
    //                                   carName: completedData[index]
    //                                           .carType
    //                                           ?.toString() ??
    //                                       "",
    //                                   status: completedData[index]
    //                                           .bookingStatus
    //                                           ?.toString() ??
    //                                       "",
    //                                   date: completedData[index]
    //                                           .date
    //                                           ?.toString() ??
    //                                       "",
    //                                   rentalCharge: completedData[index]
    //                                           .rentalCharge
    //                                           ?.toString() ??
    //                                       "",
    //                                 ))
    //                         : Center(
    //                             child: Container(
    //                                 decoration: const BoxDecoration(),
    //                                 child: Text(
    //                                   "No Data",
    //                                   style: GoogleFonts.lato(
    //                                       fontSize: 15,
    //                                       color: redColor,
    //                                       fontWeight: FontWeight.w600),
    //                                 )))
    //                     : const Center(
    //                         child: CircularProgressIndicator(
    //                           color: Colors.green,
    //                         ),
    //                       ),
    //                 cancelledStatus == "Status.completed"
    //                     ? cancelledData.isNotEmpty
    //                         ? ListView.builder(
    //                             physics: const BouncingScrollPhysics(),
    //                             itemCount: cancelledData.length,
    //                             itemBuilder: (context, index) =>
    //                                 HistoryDetailsContainer(
    //                                   onTapContainer: () {
    //                                     Provider.of<DriverGetBookingDetailsViewModel>(
    //                                             context,
    //                                             listen: false)
    //                                         .fetchDriverGetBookingDetailsViewModel(
    //                                             {
    //                                           "id": cancelledData[index]
    //                                               .id
    //                                               .toString(),
    //                                         },
    //                                             context,
    //                                             cancelledData[index]
    //                                                 .id
    //                                                 .toString(),
    //                                             widget.myID);
    //                                   },
    //                                   seat: cancelledData[index]
    //                                           .vehicle!
    //                                           .seats
    //                                           ?.toString() ??
    //                                       "",
    //                                   fuelType: cancelledData[index]
    //                                           .vehicle!
    //                                           .fuelType
    //                                           ?.toString() ??
    //                                       "",
    //                                   carName: cancelledData[index]
    //                                           .carType
    //                                           ?.toString() ??
    //                                       "",
    //                                   status: cancelledData[index]
    //                                           .bookingStatus
    //                                           ?.toString() ??
    //                                       "",
    //                                   date: cancelledData[index]
    //                                           .date
    //                                           ?.toString() ??
    //                                       "",
    //                                   rentalCharge: cancelledData[index]
    //                                           .rentalCharge
    //                                           ?.toString() ??
    //                                       "",
    //                                 ))
    //                         : Center(
    //                             child: Container(
    //                                 decoration: const BoxDecoration(),
    //                                 child: Text(
    //                                   "No Data",
    //                                   style: GoogleFonts.lato(
    //                                       fontSize: 15,
    //                                       color: redColor,
    //                                       fontWeight: FontWeight.w600),
    //                                 )
    //                                 // Image.asset(
    //                                 //   noData,
    //                                 //   height: 150,
    //                                 // ),
    //                                 ))
    //                     : const Center(
    //                         child: CircularProgressIndicator(
    //                           color: Colors.green,
    //                         ),
    //                       ),
    //               ]),
    //             )
    //           ],
    //         ),
    //       )),
    // );
  }
}

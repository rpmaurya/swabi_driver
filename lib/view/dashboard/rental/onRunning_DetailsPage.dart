import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/driverBooking_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OnRunning_DetailsPage extends StatefulWidget {
  final String bookingId;
  final String dvrID;
  const OnRunning_DetailsPage({super.key, required this.bookingId, required this.dvrID});

  @override
  State<OnRunning_DetailsPage> createState() => _OnRunning_DetailsPageState();
}

class _OnRunning_DetailsPageState extends State<OnRunning_DetailsPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<DriverGetBookingDetailsViewModel>(context, listen: false)
        .fetchDriverGetBookingDetailsViewModel({
      "id": widget.bookingId,
    }, context, widget.bookingId,widget.dvrID);
  }
  final DriverCompletedBookingViewModel _completedBookingViewModel = DriverCompletedBookingViewModel();
  bool loader = false;
  var onRunningDetails, onRunningDetailsStatus;
  @override
  Widget build(BuildContext context) {
    onRunningDetailsStatus = context.watch<DriverGetBookingDetailsViewModel>().DataList.data?.data.bookingStatus;

    onRunningDetails = context.watch<DriverGetBookingDetailsViewModel>().DataList.data?.data;
    // var onRunningDetails = context.watch<DriverGetBookingDetailsViewModel>().DataList.data!.data;
    debugPrint("${widget.bookingId} Booking Id");
    debugPrint("$onRunningDetailsStatus Booking Status");
    return PageLayout_Curve(appHeading: "On Running Details",
        child: Container(
          child: Column(
            children: [
              onRunningDetailsStatus == 'ON_RUNNING' || onRunningDetailsStatus != "null" ?
              OnRunningContainer(
                carName: onRunningDetails.vehicle.carName,
                pickDate: onRunningDetails.date,
                hour: onRunningDetails.totalRentTime,
                carType:onRunningDetails.carType,
                carColor: onRunningDetails.vehicle.color,
                brand: onRunningDetails.vehicle.brandName,
                model: onRunningDetails.vehicle.modelNo,
                seats: onRunningDetails.vehicle.seats,
                vehicleId: onRunningDetails.vehicle.vehicleId,
                vehicleNo: onRunningDetails.vehicle.vehicleNumber,
                pickTime: onRunningDetails.pickupTime,
                fuelType: onRunningDetails.vehicle.fuelType,
                id: onRunningDetails.id,
                pickUPLocation: onRunningDetails.pickupLocation,
                kilometer: onRunningDetails.kilometers,
                status: onRunningDetails.bookingStatus,
                rentalCharge: onRunningDetails.rentalCharge,
                bookingId:onRunningDetails.rentalBookingId,
                pessName: onRunningDetails.user.firstName,
                pessLastName: onRunningDetails.user.lastName,
                pessContact: onRunningDetails.user.mobile,
                pessEmail: onRunningDetails.user.email,
                acceptBtnHeading: "Complete",
                loader: _completedBookingViewModel.loading,
                confirmTap: () {
                  // Provider.of<DriverCompletedBookingViewModel>(context,listen: false).fetchDriverBookingCompletedViewModel
                  //   ({
                  //   'id':onRunningDetails.id.toString(),
                  //   'bookingStatus':'COMPLETED'
                  // }, context,widget.dvrID);
                },
              ) :const Center(
                child: Text("No Booking"),
              ),
              // SizedBox(height: 40),
              // CustomSwipeButton()
            ],
          ),
        ));
  }
}

class OnRunningContainer extends StatelessWidget {
  final String carName;
  final String carType;
  final String brand;
  final String fuelType;
  final String vehicleId;
  final String vehicleNo;
  final String carColor;
  final String seats;
  final String model;
  final String pickDate;
  final String pickTime;
  final String hour;
  final String id;
  final String kilometer;
  final String status;
  final String rentalCharge;
  final String bookingId;
  final String acceptBtnHeading;
  final String pessName;
  final String pickUPLocation;
  final String pessLastName;
  final String pessEmail;
  final String pessContact;
  final VoidCallback confirmTap;
  final bool loader;

  const OnRunningContainer(
      {super.key,
        required this.carName,
        required this.carType,
        required this.brand,
        required this.pickDate,
        required this.pickUPLocation,
        required this.pickTime,
        required this.hour,
        required this.acceptBtnHeading,
        required this.id,
        required this.kilometer,
        required this.status,
        required this.rentalCharge,
        required this.bookingId,
        required this.confirmTap,
        required this.pessName,
        required this.pessLastName,
        required this.pessContact,
        required this.pessEmail,
        this.loader = false,
        required this.fuelType,
        required this.vehicleId,
        required this.vehicleNo,
        required this.carColor,
        required this.seats,
        required this.model,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: AppDimension.getHeight(context) * .5,
      // width: AppDimension.getWidth(context) * .9,
      // padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: background
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                color: btnColor,
                border: Border(bottom: BorderSide(color: greyColor))),
            child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Booking Details",
                  style: GoogleFonts.lato(
                      color: background,
                      fontSize: 18,
                      fontWeight: FontWeight.w700
                  ),
                )),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Vehicle Details",
                style: titleTextStyle,
              )),
          Container(
            // height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: greyColor))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                      Text("Car : ",
                      style: titleTextStyle,
                      ),
                        Text(carName,
                        style: titleTextStyle,
                        )
                      ],
                    ),
                    const SizedBox(height: 5),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Car Type : ",
                            style: titleTextStyle,
                          ),
                          TextSpan(
                            text: carType,
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ])),
                    const SizedBox(height: 5),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Brand : ",
                            style: titleTextStyle,
                          ),
                          TextSpan(
                            text: brand,
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ])),
                    const SizedBox(height: 5),
                    SizedBox(
                      // width: 120,
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Vehicle No. : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: vehicleNo,
                              style: GoogleFonts.lato(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ])),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Fuel : ",
                            style: titleTextStyle,
                          ),
                          TextSpan(
                            text: "$fuelType / AC",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ])),
                    const SizedBox(height: 5),
                    SizedBox(
                      // width: 120,
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Vehicle Id : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: vehicleId,
                              style: GoogleFonts.lato(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ])),
                    ),
                    const SizedBox(height: 5),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                            text: "Color : ",
                            style: titleTextStyle,
                          ),
                          TextSpan(
                            text: carColor,
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w400
                            ),
                          ),
                        ])),
                    const SizedBox(height: 5),
                    SizedBox(
                      // width: 110,
                      child: RichText(
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(children: [
                            TextSpan(
                              text: "Model : ",
                              style: titleTextStyle,
                            ),
                            TextSpan(
                              text: model,
                              style: GoogleFonts.lato(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400
                              ),
                            ),
                          ])),
                    ),
                  ],
                )
              ],
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Booking Details",
                style: titleTextStyle,
              )),
          ///3rd Container
          Container(
            // height: 100,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: greyColor))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Id : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: id,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                        const SizedBox(height: 5),
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Hour : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: hour,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                        const SizedBox(height: 5),
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Seats : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: seats,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                        const SizedBox(height: 5),
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Status : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: status,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Date : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: pickDate,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                        const SizedBox(height: 5),
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Time : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: pickTime,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                        const SizedBox(height: 5),
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Kilometer : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: kilometer,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                        const SizedBox(height: 5),
                        RichText(
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                text: "Rental Charge : ",
                                style: titleTextStyle,
                              ),
                              TextSpan(
                                text: rentalCharge,
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400
                                ),
                              ),
                            ])),
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 5),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "PickUp Location : ",
                        style: titleTextStyle,
                      ),
                      TextSpan(
                        text: pickUPLocation.toUpperCase(),
                        style: GoogleFonts.lato(
                            color: greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ])),
                const SizedBox(height: 5),
                SizedBox(
                  width: AppDimension.getWidth(context)*.9,
                  child: RichText(
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Booking ID : ",
                            style:titleTextStyle
                        ),
                        TextSpan(
                          text: bookingId,
                          style: GoogleFonts.lato(
                              color: greyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w400
                          ),
                        ),
                      ])),
                ),
                // RichText(
                //     overflow: TextOverflow.ellipsis,
                //     text: TextSpan(children: [
                //       TextSpan(
                //         text: "Booking ID : ",
                //         style: titleTextStyle,
                //       ),
                //       TextSpan(
                //         text: bookingId,
                //         style: GoogleFonts.lato(
                //             color: greyColor,
                //             fontSize: 14,
                //             fontWeight: FontWeight.w400
                //         ),
                //       ),
                //     ])),

              ],
            ),
          ),
          Align(
              alignment: Alignment.center,
              child: Text(
                "Passenger Details",
                style: titleTextStyle,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Passenger Name : ",
                        style: titleTextStyle,
                      ),
                      TextSpan(
                        text: "$pessName $pessLastName",
                        style: GoogleFonts.lato(
                            color: greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ])),
                const SizedBox(height: 5),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Contact : ",
                        style: titleTextStyle,
                      ),
                      TextSpan(
                        text: pessContact,
                        style: GoogleFonts.lato(
                            color: greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ])),
                const SizedBox(height: 5),
                RichText(
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Email : ",
                        style: titleTextStyle,
                      ),
                      TextSpan(
                        text: pessEmail,
                        style: GoogleFonts.lato(
                            color: greyColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ])),
                const SizedBox(height: 10),
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: CustomButtonSmall(
                  loading: loader,
                    width: AppDimension.getWidth(context)*.42,
                    btnHeading: acceptBtnHeading,
                    onTap: confirmTap),
              ),
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}

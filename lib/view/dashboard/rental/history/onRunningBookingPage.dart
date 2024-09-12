import 'package:flutter/material.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class OnRunningBooking extends StatefulWidget {
  final String carName;
  final String date;
  final String rentalCharge;
  final String status;
  final VoidCallback? onTapContainer;
  const OnRunningBooking(
      {super.key,
      this.onTapContainer,
      required this.carName,
      required this.date,
      required this.rentalCharge,
      required this.status});

  @override
  State<OnRunningBooking> createState() => _OnRunningBookingState();
}

class _OnRunningBookingState extends State<OnRunningBooking> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: widget.onTapContainer,
          child: Container(
            // height: AppDimension.getHeight(context)*.23,
            width: AppDimension.getWidth(context) * .9,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: curvePageColor)),
            child: Column(
              children: [
                ///First Line of Design
                Container(
                    decoration: const BoxDecoration(
                        border:
                            Border(bottom: BorderSide(color: curvePageColor))),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              car,
                              fit: BoxFit.cover,
                            )),
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.carName,
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "⭐ 4.8",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 11,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_month_outlined,
                                    size: 18),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.date,
                                  style: GoogleFonts.lato(
                                      color: greyColor1,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            "5 Seats",
                            style: GoogleFonts.lato(
                                color: greyColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    )),

                ///Second Line Design
                Container(
                  decoration: const BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: curvePageColor))),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    leading: SizedBox(
                      width: 40,
                      height: 40,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset(fuel),
                          )),
                    ),
                    title: Text(
                      "Fuel Type",
                      style: GoogleFonts.lato(
                          color: greyColor1,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          "Electric",
                          style: GoogleFonts.lato(
                              color: greyColor,
                              fontSize: 11,
                              fontWeight: FontWeight.w700),
                        ),
                        const Spacer(),
                      ],
                    ),
                    trailing: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      width: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // SizedBox(
                          //   width: 40,
                          //   height: 40,
                          //   child: ClipRRect(
                          //       borderRadius: BorderRadius.circular(50),
                          //       child: Padding(
                          //         padding: const EdgeInsets.all(10.0),
                          //         child: Image.asset(dollar),
                          //       )),
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Charges",
                                style: GoogleFonts.lato(
                                    color: greyColor1,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "AED ${widget.rentalCharge}",
                                style: GoogleFonts.lato(
                                    color: greyColor,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                ///Second Line Design
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: onRunningColor.withOpacity(.1),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.status,
                          style: GoogleFonts.lato(
                              color: onRunningColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

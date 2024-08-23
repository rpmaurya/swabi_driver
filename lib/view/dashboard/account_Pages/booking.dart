import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';

class MyBooking extends StatefulWidget {
  const MyBooking({super.key});

  @override
  State<MyBooking> createState() => _MyBookingState();
}

class _MyBookingState extends State<MyBooking> {
  @override
  Widget build(BuildContext context) {
    return const PageLayout_Curve(appHeading: "My Booking",
        child: Column(
          children: [

          ],
        ));
  }
}

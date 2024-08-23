import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/dimensions.dart';
import 'package:google_fonts/google_fonts.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    // return const PageLayout_Curve(appHeading: "Contact",
    //     child: Column(
    //       children: [
    //         SizedBox(height: 20),
    //          CustomContainer(
    //           img: email1,
    //           title: "Email",
    //           contect: "ev.support@example.com",
    //         ),
    //         SizedBox(height: 20),
    //         CustomContainer(
    //           img: phone1,
    //           title: "Call Us",
    //           contect: "(671) 555-0110",
    //         )
    //       ],
    //     ),

    //     );
    return const CustomPagelayout(
      appBarTitle: 'Contact',
      child: Column(
        children: [
          SizedBox(height: 20),
          CustomContainer(
            img: email1,
            title: "Email",
            contect: "ev.support@example.com",
          ),
          SizedBox(height: 20),
          CustomContainer(
            img: phone1,
            title: "Call Us",
            contect: "(671) 555-0110",
          )
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String img;
  final String title;
  final String contect;
  const CustomContainer(
      {super.key,
      required this.img,
      required this.title,
      required this.contect});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      borderRadius: BorderRadius.circular(10),
      color: background,
      child: Container(
        height: AppDimension.getHeight(context) * .2,
        width: AppDimension.getWidth(context) * .85,
        decoration: BoxDecoration(
            color: background,
            border: Border.all(
              color: naturalGreyColor.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.black, borderRadius: BorderRadius.circular(50)),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.asset(img),
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: GoogleFonts.lato(
                  color: greyColor, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 5),
            Text(
              contect,
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}

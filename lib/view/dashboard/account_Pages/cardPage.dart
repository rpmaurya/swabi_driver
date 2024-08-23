import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';

class CardPage extends StatefulWidget {
  const CardPage({super.key});

  @override
  State<CardPage> createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  @override
  Widget build(BuildContext context) {
    return const PageLayout_Curve(appHeading: "My Cards",

        child: Column(
          children: [

          ],
        ));
  }
}

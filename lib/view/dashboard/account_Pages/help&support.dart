import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/custom_ListTile.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:go_router/go_router.dart';

class HelpAndSupport extends StatelessWidget {
  const HelpAndSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
        appBarTitle: 'Help & Support',
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Custom_ListTile(
              img: rideIssue,
              heading: "Raised Issue",
              onTap: () => context.push("/getRaiseIssue"),
            ),
            Custom_ListTile(
              img: otherIssue,
              heading: "Other Issue",
              onTap: () => context.push("/termCondition"),
            ),
            Custom_ListTile(
              img: contact,
              heading: "Contact",
              onTap: () => context.push("/contact"),
            ),
            Custom_ListTile(
              img: privacyPolicy,
              heading: "Privacy & Policy",
              onTap: () => context.push("/termCondition"),
            ),
            Custom_ListTile(
              img: tnc,
              heading: "Term & Condition",
              onTap: () => context.push("/termCondition"),
            ),
          ],
        ));
  }
}
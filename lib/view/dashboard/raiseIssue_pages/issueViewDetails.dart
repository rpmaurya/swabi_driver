import 'package:flutter/material.dart';
import 'package:flutter_driver/model/IssueDetailModel.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';

import 'package:flutter_driver/res/customAppBar.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/raiseIssue_view_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Issueviewdetails extends StatefulWidget {
  const Issueviewdetails({super.key});

  @override
  State<Issueviewdetails> createState() => _IssueviewdetailsState();
}

class _IssueviewdetailsState extends State<Issueviewdetails> {
  Data? issueData;
  @override
  Widget build(BuildContext context) {
    issueData = context.watch<RaiseissueViewModel>().issueDetail.data?.data;
    return CustomPagelayout(
      appBarTitle: 'Issue Details',
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            width: double.infinity,
            decoration: BoxDecoration(
                color: background,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        itemtile(
                            lable: 'Issue Id',
                            vale: issueData?.issueId.toString() ?? ''),
                        itemtile(
                            lable: 'Booking Id',
                            vale: issueData?.bookingId.toString() ?? '')
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Status',
                              style: titleTextStyle,
                            ),
                            const SizedBox(width: 5),
                            Text(':'),
                            const SizedBox(width: 5),
                            Container(
                              height: 30,
                              // width: 120,
                              padding: EdgeInsets.only(left: 10, right: 10),
                              decoration: BoxDecoration(
                                  color: issueData?.issueStatus == 'OPEN'
                                      ? redColor
                                      : Colors.green,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                  child: Text(
                                issueData?.issueStatus.toString() ?? '',
                                style: TextStyle(color: background),
                              )),
                            )
                          ],
                        ),
                        itemtile(
                            lable: 'User Id',
                            vale: issueData?.raisedById.toString() ?? '')
                      ],
                    ),
                  ],
                ),
                itemText(
                    lable: 'Created Date',
                    value: DateFormat('dd-MM-yyyy').format(
                        DateTime.fromMillisecondsSinceEpoch(
                            issueData?.createdDate ?? 0))),
                itemText(
                    lable: 'Booking Type',
                    value: issueData?.bookingType.toString() ?? ''),
                itemText(
                    lable: 'Issue Description',
                    value: issueData?.issueDescription.toString() ?? ''),
                issueData?.resolutionDescription == null
                    ? const SizedBox()
                    : Text(
                        'Resolution Description :-',
                        style: titleTextStyle,
                      ),
                Text(
                  issueData?.resolutionDescription ?? '',
                  style: titleTextStyle,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  itemText({required String lable, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            lable,
            style: titleTextStyle,
          ),
        ),
        const SizedBox(width: 5),
        Text(':'),
        const SizedBox(width: 5),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: textStyle,
          ),
        )
      ],
    );
  }

  itemtile({required String lable, required String vale}) {
    return Row(children: [
      Text(
        lable,
        style: titleTextStyle,
      ),
      const SizedBox(width: 5),
      Text(':'),
      const SizedBox(width: 5),
      Text(
        vale,
        style: textStyle,
      )
    ]);
  }
}
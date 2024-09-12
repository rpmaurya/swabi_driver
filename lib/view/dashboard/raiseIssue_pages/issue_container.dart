import 'package:flutter/material.dart';

import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';

class IssueContainer extends StatelessWidget {
  final String issueId;
  final String bookingId;
  final String userId;
  final String status;
  final String issueDate;
  final String bookingType;
  final VoidCallback onTap;
  final bool loader;
  const IssueContainer(
      {super.key,
      required this.issueId,
      required this.bookingId,
      required this.userId,
      required this.status,
      required this.issueDate,
      required this.bookingType,
      required this.loader,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    print('loader..$loader');
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  itemtile(lable: 'Issue Id', vale: issueId),
                  itemtile(lable: 'Booking Id', vale: bookingId)
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
                            color: status == 'OPEN' ? redColor : Colors.green,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                            child: Text(
                          status,
                          style: TextStyle(color: background),
                        )),
                      )
                    ],
                  ),
                  itemtile(lable: 'User Id', vale: userId)
                ],
              ),
            ],
          ),
          itemText(lable: 'Issue Date', value: issueDate),
          itemText(lable: 'Booking Type', value: bookingType),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.bottomRight,
            child: CustomButtonSmall(
                loading: loader,
                height: 40,
                width: 80,
                btnHeading: 'View',
                onTap: onTap),
          )
        ],
      ),
    );
  }

  itemText({required String lable, required String value}) {
    return Row(
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
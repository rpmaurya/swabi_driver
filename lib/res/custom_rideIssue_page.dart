import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';

import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';

import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/raiseIssue_view_model.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CustomRideissuePage extends StatefulWidget {
  final String bookingId;
  final String bookingType;
  const CustomRideissuePage(
      {super.key, required this.bookingId, required this.bookingType});

  @override
  State<CustomRideissuePage> createState() => _CustomRideissuePageState();
}

class _CustomRideissuePageState extends State<CustomRideissuePage> {
  String? _selectedIssue;
  TextEditingController _descriptionController = TextEditingController();
  final List<String> _issueOptions = [
    'Expected a shorter wait time',
    'Unable to contact driver',
    'Driver denied duty',
    'Cab is not moving in my direction',
    'My reason is not listed',
  ];
  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
      appBarTitle: 'Ride Issue',
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text("Raise Help", style: titleTextStyle),
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Please Select Raise Issue',
                style: titleTextStyle,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: _issueOptions.map((issue) {
                  return RadioListTile<String>(
                    contentPadding: EdgeInsets.zero,
                    activeColor: btnColor,
                    title: Text(issue),
                    value: issue,
                    groupValue: _selectedIssue,
                    onChanged: (value) {
                      setState(() {
                        _selectedIssue = value;
                      });
                    },
                  );
                }).toList(),
              ),
              if (_selectedIssue == 'My reason is not listed')
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _descriptionController,
                        maxLength: 120,
                        maxLines: 3,
                        decoration: const InputDecoration(
                          hintText: "Description For Issue",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      // Align(
                      //   alignment: Alignment.centerRight,
                      //   child: Text(
                      //     '(${_descriptionController.text.length}/120)',
                      //     style: TextStyle(fontSize: 12),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              const SizedBox(height: 10),
              CustomButtonSmall(
                  height: 45,
                  width: double.infinity,
                  btnHeading: 'Submit',
                  onTap: () {
                    String? issueDescription =
                        _selectedIssue == 'My reason is not listed'
                            ? _descriptionController.text
                            : _selectedIssue;
                    Provider.of<RaiseissueViewModel>(context, listen: false)
                        .requestRaiseIssue(
                            context: context,
                            bookingId: widget.bookingId,
                            bookingType: widget.bookingType,
                            issueDescription: issueDescription ?? '');
                    context.pop();
                  })
            ],
          ),
        ),
      ),
    );
  }
}

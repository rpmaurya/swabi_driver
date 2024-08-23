import 'package:flutter/material.dart';
import 'package:flutter_driver/model/driver_profile_model.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
import 'package:flutter_driver/res/CustomTextFormfield.dart';
import 'package:flutter_driver/res/Custom_dropdown_button.dart';
import 'package:flutter_driver/res/custom_datePicker/common_textfield.dart';
import 'package:flutter_driver/utils/assets.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/utils/utils.dart';
import 'package:flutter_driver/view_model/driverProfile_view_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:google_places_autocomplete_text_field/model/prediction.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class EditProfiePage extends StatefulWidget {
  final String usrId;
  final String mobileNumber;
  const EditProfiePage(
      {super.key, required this.usrId, required this.mobileNumber});

  @override
  State<EditProfiePage> createState() => _EditProfiePageState();
}

class _EditProfiePageState extends State<EditProfiePage> {
  List<TextEditingController> controlers =
      List.generate(1, (index) => TextEditingController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  final String _googleApiKey = 'AIzaSyADRdiTbSYUR8oc6-ryM1F1NDNjkHDr0Yo';
  String? gengerName;
  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();

  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();

  String phoneNumber = '';
  String isoCode = '';
  String stateCode = '';
  String? cuntryCode;
  String? mobileNumber;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getUser();
    phoneNumberController.text = widget.mobileNumber;
  }

  getUser() async {
    Future.delayed(Duration(seconds: 2), () {
      Provider.of<DriverProfileViewModel>(context, listen: false)
          .fetchDriverDetailViewModelApi(
              context, {"driverId": widget.usrId}, widget.usrId);
    });
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  bool loader = false;
  DriverProfileData? data;
  @override
  Widget build(BuildContext context) {
    String status = context
        .watch<DriverProfileUpdateViewModel>()
        .DataList
        .status
        .toString();
    debugPrint(widget.usrId.toString());
    data = context.watch<DriverProfileViewModel>().DataList.data?.data;
    firstNameController.text = data?.firstName ?? '';
    lastNameController.text = data?.lastName ?? '';
    genderController.text = data?.gender ?? '';
    locationController.text = data?.driverAddress ?? '';
    return CustomPagelayout(
      appBarTitle: 'Edit Profile',
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("First Name", style: titleTextStyle),
                ),
                Customtextformfield(
                  focusNode: focusNode1,
                  controller: firstNameController,
                  prefixiconvisible: true,
                  img: user,
                  hintText: 'First Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required first name';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Last Name", style: titleTextStyle),
                ),
                Customtextformfield(
                  focusNode: focusNode2,
                  controller: lastNameController,
                  prefixiconvisible: true,
                  img: user,
                  hintText: 'Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required last name';
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Gender", style: titleTextStyle),
                ),
                CustomDropdown(
                    controller: genderController,
                    selectedBorderColor: btnColor,
                    prifixIconVisible: true,
                    img: gender,
                    fillColor: background,
                    hintText: 'Select Gender',
                    items: ['Male', 'Female'],
                    onChanged: (value) {}),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Text("Address", style: titleTextStyle),
                ),
                SizedBox(
                  child: GooglePlacesAutoCompleteTextFormField(
                      focusNode: focusNode4,
                      debounceTime: 800,
                      scrollPhysics: ScrollPhysics(),
                      textEditingController: locationController,
                      googleAPIKey: _googleApiKey,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCDCDCD),
                            // width: 2.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCDCDCD),
                            // width: 2.0,
                          ),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCDCDCD),
                            // width: 2.0,
                          ),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          borderSide: const BorderSide(
                            color: Color(0xFFCDCDCD),
                            // width: 2.0,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red)),
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Image.asset(
                            address,
                            width: 10,
                            height: 10,
                          ),
                        ),
                        fillColor: background,
                        filled: true,
                        hintText: 'Enter your address',
                        // labelText: 'Address',

                        labelStyle: const TextStyle(
                          color: Color(0xFFCDCDCD),
                        ),
                        // border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      // proxyURL: _yourProxyURL,
                      maxLines: 1,
                      overlayContainer: (child) => Material(
                            elevation: 1.0,
                            color: background,
                            borderRadius: BorderRadius.circular(5),
                            child: SingleChildScrollView(
                                physics: PageScrollPhysics(), child: child),
                          ),
                      getPlaceDetailWithLatLng: (prediction) {
                        print('placeDetails${prediction.lng}');
                      },
                      itmClick: (Prediction prediction) {
                        locationController.text = prediction.description!;
                        locationController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: locationController.text.length),
                        );
                      }),
                ),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 5),
                //   child: Text("Update Mobile Number", style: titleTextStyle),
                // ),
                // IntlPhoneField(
                //   style: titleTextStyle,
                //   showCountryFlag: true,
                //   dropdownTextStyle: titleTextStyle,
                //   dropdownIconPosition: IconPosition.trailing,
                //   dropdownDecoration: const BoxDecoration(
                //       borderRadius: BorderRadius.only(
                //           topLeft: Radius.circular(5),
                //           bottomLeft: Radius.circular(5))),
                //   initialCountryCode: 'AE',
                //   controller: phoneNumberController,
                //   pickerDialogStyle: PickerDialogStyle(
                //     // searchFieldCursorColor: blackColor,
                //     searchFieldInputDecoration: InputDecoration(
                //         contentPadding: const EdgeInsets.symmetric(
                //             vertical: 10, horizontal: 10),
                //         hintText: "Enter Country Code or Name",
                //         // fillColor: background,
                //         isDense: true,
                //         hintStyle: titleTextStyle,
                //         focusedBorder: UnderlineInputBorder(
                //             borderSide: BorderSide(
                //                 color: naturalGreyColor.withOpacity(0.3))),
                //         labelStyle: titleTextStyle,
                //         counterStyle: titleTextStyle,
                //         suffixStyle: titleTextStyle),
                //     countryCodeStyle: titleTextStyle,
                //     countryNameStyle: titleTextStyle,
                //     // backgroundColor: background,
                //   ),
                //   decoration: InputDecoration(
                //     filled: true,
                //     fillColor: background,
                //     helperStyle: titleTextStyle,
                //     errorStyle: GoogleFonts.lato(color: redColor),
                //     hintStyle: titleTextStyle,
                //     isDense: true,
                //     errorBorder: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: naturalGreyColor.withOpacity(0.3)),
                //     ),
                //     focusedBorder: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: naturalGreyColor.withOpacity(0.3)),
                //     ),
                //     border: OutlineInputBorder(
                //       borderSide:
                //           BorderSide(color: naturalGreyColor.withOpacity(0.3)),
                //       // borderSide: BorderSide.none,
                //     ),
                //     contentPadding: const EdgeInsets.only(bottom: 30),
                //     suffixStyle: titleTextStyle,
                //     focusedErrorBorder: const OutlineInputBorder(
                //         borderSide: BorderSide(color: redColor)),
                //     enabledBorder: OutlineInputBorder(
                //         borderSide:
                //             BorderSide(color: naturalGreyColor.withOpacity(0.3))),
                //   ),
                //   onChanged: (phone) {
                //     cuntryCode = phone.countryCode;
                //     mobileNumber = phone.number;
                //     debugPrint("${phone.number}Phone Number");
                //     debugPrint("${phone.countryCode}Phone Code");
                //   },
                // ),
                // const Spacer(),
                const SizedBox(
                  height: 20,
                ),
                CustomButtonBig(
                    loading: status == 'Status.loading' && loader,
                    btnHeading: "Save",
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        Provider.of<DriverProfileUpdateViewModel>(context,
                                listen: false)
                            .editProfile(
                                context: context,
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                location: locationController.text,
                                gender: genderController.text);
                      }
                      // Map<String, dynamic> data = {
                      //   "driverId": widget.usrId.toString(),
                      //   "countryCode": cuntryCode,
                      //   "mobile": phoneNumberController.text,

                      //   ///Name of Country
                      //   // "countryCode": isoCode.toString(),
                      // };
                      // setState(() {
                      //   debugPrint(data.toString());
                      //   debugPrint(phoneNumberController.toString());
                      //   debugPrint(widget.usrId.toString());
                      // });
                      // if (phoneNumberController.text.isEmpty ||
                      //     phoneNumberController.text.length <= 5) {
                      //   Utils.flushBarErrorMessage(
                      //       "Please enter your number first", context);
                      // } else {
                      //   loader = true;
                      //   Provider.of<DriverProfileUpdateViewModel>(context,
                      //       listen: false);
                      // }
                    }),
                const SizedBox(height: 500),
              ],
            ),
          ),
        ),
      ),
    );
    // return PageLayout_Curve(
    //   appHeading: "Update Information",
    //   child:
    // );
  }
}

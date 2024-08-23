import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/res/customTextWidget.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/utils/text_styles.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Packagedetailpage extends StatefulWidget {
  const Packagedetailpage({super.key});

  @override
  State<Packagedetailpage> createState() => _PackagedetailpageState();
}

class _PackagedetailpageState extends State<Packagedetailpage> {
  bool btn = false;
  String? dateFormat;
  String _timeZone = 'unknown';
  String formattedTodayDate = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTimezone();
    final date = DateTime.now();
    setState(() {
      dateFormat = DateFormat('dd-MM-yyyy').format(date);
    });
    formattedTodayDate = dateFormat.toString();
  }

  Future<void> getTimezone() async {
    String timezone;

    try {
      timezone = await FlutterTimezone.getLocalTimezone();
      print('hgjhjhj.............$timezone');
      if (!mounted) return;

      setState(() {
        _timeZone = timezone;
      });
    } catch (e) {
      print('Could not get the local timezone');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
      appBarTitle: 'Package Details',
      child:
          Consumer<DriverPackageViewModel>(builder: (context, viewData, child) {
        if (viewData.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (viewData.driverPackageDetailModel == null) {
          return const Center(child: Text('No packages available'));
        } else {
          var package = viewData.driverPackageDetailModel?.data;
          print('daystatus......${package?.dayStatus}');
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black12),
                              borderRadius: BorderRadius.circular(10)),
                          width: 80,
                          height: 80,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              package?.vehicle?.images?[0] ?? '',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                package?.vehicle?.carName ?? '',
                                style: pageHeadingTextStyle,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                    '${package?.vehicle?.brandName} / ${package?.vehicle?.carType}'),
                                const SizedBox(
                                    height: 15, child: VerticalDivider()),
                                Text(package?.vehicle?.fuelType ?? '')
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${package?.vehicle?.vehicleNumber}',
                                  style: textStyle,
                                ),
                                const SizedBox(
                                    height: 15,
                                    child: VerticalDivider(
                                      color: Colors.black,
                                      thickness: 1.5,
                                    )),
                                Text(
                                  '${package?.vehicle?.seats} Seats',
                                  style: textStyle,
                                )
                              ],
                            )
                          ],
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                "⭐ 4.8",
                                style: GoogleFonts.lato(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                ' ',
                                style: titleTextStyle,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  containerItem(
                      context,
                      180,
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 165,
                            child: VerticalDivider(
                              width: 3,
                              thickness: 3,
                              color: btnColor,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10),
                                  child: Text(
                                    'Package Booking ID : ${package?.packageBookingId}',
                                    style: textTextStyle1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15, bottom: 10),
                                  child: Text(
                                    'Status : ${package?.dayStatus}',
                                    style: textTextStyle1,
                                  ),
                                ),
                                Container(
                                  width: 115,
                                  decoration: const BoxDecoration(
                                      color: background,
                                      border: Border(
                                          top:
                                              BorderSide(color: Colors.black26),
                                          right:
                                              BorderSide(color: Colors.black26),
                                          bottom: BorderSide(
                                              color: Colors.black26)),
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10))),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 28, vertical: 3),
                                    child: Center(
                                        child: Text(
                                      'Pick Up',
                                      style: textTextStyle1,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 10, bottom: 8, top: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on_outlined),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Flexible(
                                        child: Text(
                                          '${package?.pickupLocation}',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: textTextStyle1,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 12,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.calendar_month_outlined,
                                          size: 20),
                                      Text(
                                        '${package?.date ?? 'N/A'}',
                                        style: textTextStyle1,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                        child: VerticalDivider(),
                                      ),
                                      const Icon(
                                        Icons.timer_outlined,
                                        size: 18,
                                      ),
                                      Text(
                                        '${package?.pickupTime ?? 'N/A'}',
                                        style: textTextStyle1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Text(
                      'Passenger Details',
                      style: titleTextStyle,
                    ),
                  ),
                  containerItem(
                      context,
                      null,
                      Column(
                        children: [
                          InfoRow(
                              label: 'Passenger Name',
                              value:
                                  '${package?.user?.firstName} ${package?.user?.lastName}'),
                          const SizedBox(
                            height: 5,
                          ),
                          InfoRow(
                              label: 'Contact No',
                              value: '${package?.user?.mobile}'),
                          const SizedBox(
                            height: 5,
                          ),
                          InfoRow(
                              label: 'Email', value: '${package?.user?.email}'),
                        ],
                      )),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                    child: Text(
                      'Activity Details',
                      style: titleTextStyle,
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: package?.activityList?.length,
                      itemBuilder: (context, index) {
                        var activity = package?.activityList?[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: containerItem(
                            context,
                            null,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                      color: btnColor,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    'Activity:${index + 1}',
                                    style: const TextStyle(
                                        color: background,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  '${activity?.activityName}',
                                  maxLines: 3,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InfoRow(
                                        label: 'Activity Hours',
                                        value: '${activity?.activityHours}'),
                                    InfoRow(
                                        label: 'Time To Visit ',
                                        value: '${activity?.bestTimeToVisit}'),
                                    InfoRow(
                                        label: 'Opening Time',
                                        value: '${activity?.startTime}'),
                                    InfoRow(
                                        label: 'Closing Time',
                                        value: ' ${activity?.endTime}'),
                                  ],
                                ),
                                InfoRow(
                                    label: 'Location',
                                    value: '${activity?.address}')
                                // textItem(
                                //     title: 'Location',
                                //     titleValue: '${activity?.address}')
                              ],
                            ),
                          ),
                        );
                      }),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        package?.dayStatus == 'PENDING'
                            ? CustomButtonSmall(
                                width: 170,
                                height: 40,
                                btnHeading: 'Activity Start',
                                isEnabled: formattedTodayDate == package?.date
                                    ? btn = true
                                    : false,
                                onTap: btn != true
                                    ? null
                                    : () {
                                        setState(() {
                                          viewData.isLoading = true;
                                        });
                                        viewData.activityStart(
                                            context: context,
                                            packageBookingId:
                                                package?.packageBookingId,
                                            date: package?.date,
                                            zoneId: _timeZone);
                                        setState(() {
                                          viewData.isLoading = false;
                                        });
                                        if (!viewData.isLoading) {
                                          Provider.of<DriverPackageViewModel>(
                                                  context,
                                                  listen: false)
                                              .updateDayStatus('ONGOING');
                                        }
                                      })
                            : Container(),
                        package?.dayStatus == 'ONGOING'
                            ? CustomButtonSmall(
                                width: 170,
                                height: 40,
                                btnHeading: 'Activity Complete',
                                isEnabled: formattedTodayDate == package?.date
                                    ? btn = true
                                    : false,
                                onTap: btn != true
                                    ? null
                                    : () {
                                        setState(() {
                                          viewData.isLoading = true;
                                        });
                                        Provider.of<DriverPackageViewModel>(
                                                context,
                                                listen: false)
                                            .activityComplete(
                                                context: context,
                                                packageBookingId:
                                                    package?.packageBookingId,
                                                date: package?.date,
                                                zoneId: _timeZone);
                                        setState(() {
                                          viewData.isLoading = false;
                                        });
                                        if (!viewData.isLoading) {
                                          Provider.of<DriverPackageViewModel>(
                                                  context,
                                                  listen: false)
                                              .updateDayStatus('COMPLETED');
                                          context.pop('update');
                                        }
                                      })
                            : Container()
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      }),
    );
    // return Scaffold(
    //   backgroundColor: bgGreyColor,
    //   appBar: AppBar(
    //     backgroundColor: background,
    //     title: Text('PageView'),
    //     centerTitle: true,
    //   ),
    //   body:

    // );
  }

  Widget containerItem(
    BuildContext context,
    double? height,
    Widget child,
  ) {
    return Container(
      width: double.infinity,
      height: height,
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: bgGreyColor, borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String value;

  InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            '$label',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Text(
          ':',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 4,
          child: Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

textItem({required String title, required String titleValue}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '$title :',
        style: titleTextStyle,
      ),
      const SizedBox(
        width: 5,
      ),
      Expanded(
        child: Text(
          titleValue,
          style: textStyle,
        ),
      )
    ],
  );
}

completedTextItem() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.green, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        const Icon(
          Icons.check_circle_outline,
          color: Colors.white,
        ),
        Text(
          'Journey Completed',
          style: btnTextStyle,
        )
      ],
    ),
  );
}

ongoingTextItem() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.blue, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        const Icon(
          Icons.car_rental_outlined,
          color: Colors.white,
        ),
        Text(
          'Journey Ongoing',
          style: btnTextStyle,
        )
      ],
    ),
  );
}

pendingTextItem() {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    decoration: BoxDecoration(
        color: Colors.yellow, borderRadius: BorderRadius.circular(5)),
    child: Row(
      children: [
        const Icon(
          Icons.access_time_outlined,
          color: Colors.white,
        ),
        Text(
          'Journey Pending',
          style: btnTextStyle,
        )
      ],
    ),
  );
}
// }

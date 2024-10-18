import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/view/dashboard/package/history_packageBooking.dart';
import 'package:flutter_driver/view/dashboard/package/upcomming_packageBooking.dart';
import 'package:flutter_driver/view_model/driver_package_view_model.dart';
import 'package:provider/provider.dart';

class PackageManagementScreen extends StatefulWidget {
  const PackageManagementScreen({super.key});

  @override
  State<PackageManagementScreen> createState() =>
      _PackageManagementScreenState();
}

class _PackageManagementScreenState extends State<PackageManagementScreen>
    with TickerProviderStateMixin {
  int intialIndex = 0;
  int hoveredIndex = -1;
  TabController? _tabcontroller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabcontroller = TabController(length: 2, vsync: this);
    getPackageList();
    _tabcontroller?.addListener(() {
      intialIndex = _tabcontroller?.index ?? 0;

      getPackageList();
      print({'gfgfgfgh': _tabcontroller?.index});
    });
  }

  Future<void> getPackageList() async {
    if (intialIndex == 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<DriverPackageViewModel>(context, listen: false)
            .getPackageBookingList(
          context: context,
        );
      });
    } else if (intialIndex == 1) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Provider.of<DriverPackageViewModel>(context, listen: false)
            .getPackageBookingHistoryList(context: context);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabcontroller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPagelayout(
      appBarTitle: 'Package Management',
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(color: btnColor),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10)),
            child: TabBar(
              controller: _tabcontroller,
              onTap: (value) {
                setState(() {
                  intialIndex = value;
                });
                getPackageList();
                print({"valueIndex": intialIndex});
              },
              indicator: const BoxDecoration(
                  color: Colors.transparent,
                  border: Border(bottom: BorderSide(width: 5, color: btnColor)),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15))),
              splashBorderRadius: BorderRadius.circular(20),
              unselectedLabelColor: Colors.black87,
              labelColor: btnColor,
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              indicatorPadding: const EdgeInsets.only(left: 10, right: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: [Tab(text: "UP COMING"), Tab(text: "HISTORY")],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabcontroller, children: const [
              UpcommingPackagebooking(),
              HistoryPackagebooking()
            ]),
          ),
        ],
      ),
    );
  }
}

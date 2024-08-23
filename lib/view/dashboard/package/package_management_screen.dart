import 'package:flutter/material.dart';
import 'package:flutter_driver/res/Custom%20Page%20Layout/custom_pageLayout.dart';
import 'package:flutter_driver/utils/color.dart';
import 'package:flutter_driver/view/dashboard/package/history_packageBooking.dart';
import 'package:flutter_driver/view/dashboard/package/upcomming_packageBooking.dart';

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
    _tabcontroller?.addListener(() {
      setState(() {
        intialIndex = _tabcontroller?.index ?? 0;
      });
      print({'gfgfgfgh': _tabcontroller?.index});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabcontroller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   backgroundColor: bgGreyColor,
    //   appBar: AppBar(
    //     backgroundColor: background,
    //     title: Text('Package '),
    //     centerTitle: true,
    //   ),
    //   body:
    // );
    return CustomPagelayout(
      appBarTitle: 'Package',
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
              indicatorPadding: EdgeInsets.only(left: 10, right: 10),
              indicatorSize: TabBarIndicatorSize.tab,
              // tabs: List.generate(2, (index) {
              //   return MouseRegion(
              //     onEnter: (_) {
              //       setState(() {
              //         hoveredIndex = index;
              //       });
              //     },
              //     onExit: (_) {
              //       setState(() {
              //         hoveredIndex = -1;
              //       });
              //     },
              //     child: Tab(
              //       child: Container(
              //         decoration: BoxDecoration(
              //           border: Border(
              //             bottom: BorderSide(
              //               width: 5,
              //               color: hoveredIndex == index
              //                   ? Colors.red // Change to desired hover color
              //                   : Colors.transparent,
              //             ),
              //           ),
              //         ),
              //         child: Center(
              //           child: Text(index == 0 ? "UP COMMING" : "HISTORY"),
              //         ),
              //       ),
              //     ),
              //   );
              // }),

              tabs: [Tab(text: "UP COMMING"), Tab(text: "HISTORY")],
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

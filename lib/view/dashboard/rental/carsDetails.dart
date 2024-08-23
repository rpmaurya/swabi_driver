// import 'package:flutter/material.dart';
// import 'package:flutter_driver/res/Custom%20%20Button/custom_btn.dart';
// import 'package:flutter_driver/res/Custom%20Page%20Layout/pageLayout_curve.dart';
// import 'package:flutter_driver/utils/assets.dart';
// import 'package:flutter_driver/utils/color.dart';
// import 'package:flutter_driver/utils/dimensions.dart';
// import 'package:flutter_driver/utils/text_styles.dart';
// import 'package:flutter_driver/view_model/rental_view_model.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
//
// // class RentalData{
// //   final String pickupLocation;
// //   final String noOfSeat;
// //   final String pickUpTime;
// //   final String pickUpDate;
// //   final String hours;
// //   final String kilometer;
// //   RentalData({
// //     required this.pickupLocation,
// //     this.kilometer = "",
// //     required this.hours,
// //     required this.noOfSeat,
// //     required this.pickUpDate,
// //     required this.pickUpTime,
// // });
// // }
//
// class CarsDetailsAvailable extends StatefulWidget {
//   // final Datum data;
//   const CarsDetailsAvailable({super.key,
//     // required this.data
//   });
//
//   @override
//   State<CarsDetailsAvailable> createState() => _CarsDetailsAvailableState();
// }
//
// class _CarsDetailsAvailableState extends State<CarsDetailsAvailable> {
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // Provider.of<RentalViewModel>(context,listen: false).fetchRentalViewModelApi(context, {
//     //   "date": "12-04-2024",
//     //   "pickupTime":"12%3A00",
//     //   "seat":"4",
//     //   "hours":"5",
//     //   "kilometers":"50",
//     //   "pickUpLocation":"Noida%20Sector%2063"
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return PageLayout_Curve(
//         appHeading: "Cars Available",
//         child: Container(
//           child: ListView.builder(
//             shrinkWrap: true,
//               itemCount: rentalData.length,
//               itemBuilder: (context, index) => TransContainer(
//                 carName: rentalData[index].carType,
//                 pickTime: rentalData[index].pickupTime,
//                 price: rentalData[index].price,
//                 pickDate: rentalData[index].date,
//                 totalPrice: rentalData[index].totalPrice,
//                 hour: rentalData[index].hours,
//                 kilometers: rentalData[index].kilometers,
//                 pickUpLocation: rentalData[index].pickUpLocation,
//                 onTap: () {
//                   // Map<String, dynamic> data = [
//                   //   "date":"15-04-2024",
//                   //   "pickupTime":"13:45",
//                   //   "userId":1,
//                   //   "locationLatitude":1.0,
//                   //   "locationLongitude":2.0,
//                   //   "carType":"Ford Fusion",
//                   //   "kilometers": 50,
//                   //   "hours": 6,
//                   //   "price":550.0
//                   // ];
//                   Provider.of<RentalBookingViewModel>(context,listen: false).
//                   fetchRentalViewModelApi(context,{
//                     "date":rentalData[index].date,
//                     "pickupTime":rentalData[index].pickupTime.toString(),
//                     "userId":"1",
//                     "locationLatitude":"1.0",
//                     "locationLongitude":"2.0",
//                     "carType":rentalData[index].carType.toString(),
//                     "kilometers": rentalData[index].kilometers.toString(),
//                     "hours": rentalData[index].hours.toString(),
//                     "price":rentalData[index].totalPrice.toString()
//                   });
//                   // context.push('/rentalForm/rentalCarBooking');
//
//                 },
//               ))
//         ));
//   }
// }
//
//
// class TransContainer extends StatelessWidget {
//   final String carName;
//   final String pickTime;
//   final String pickDate;
//   final String price;
//   final String hour;
//   final String totalPrice;
//   final String kilometers;
//   final String pickUpLocation;
//   final VoidCallback onTap;
//   const TransContainer({
//     this.carName = "",
//     this.pickTime = "",
//     this.pickDate = "",
//     this.hour = "",
//     this.price = "",
//     this.totalPrice = "",
//     this.kilometers = "",
//     this.pickUpLocation = "",
//     required this.onTap,
//     super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(padding: const EdgeInsets.symmetric(vertical: 5),
//       child: Material(
//         elevation: 5,
//         borderRadius: BorderRadius.circular(10),
//         child: InkWell(
//           borderRadius: BorderRadius.circular(10),
//           child: Container(
//             // height: AppDimension.getHeight(context)*.25,
//             width: AppDimension.getWidth(context)*.9,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(color: curvePageColor)
//             ),
//             child: Column(
//               children: [
//                 ///First Line of Design
//                 Container(
//                     decoration: const BoxDecoration(
//                         border: Border(bottom: BorderSide(color: curvePageColor))
//                     ),
//                     child: ListTile(
//                       leading: SizedBox(
//                         width: 60,
//                         height: 60,
//                         child: ClipRRect(
//                             borderRadius: BorderRadius.circular(10),
//                             child: Image.asset(car,fit: BoxFit.cover,)),
//                       ),
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(carName,style: GoogleFonts.lato(
//                               color: greyColor,
//                               fontSize: 16,
//                               fontWeight: FontWeight.w600
//                           ),),
//                           Text("Date : $pickDate",style: GoogleFonts.lato(
//                               color: greyColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600
//                           ),),
//
//                           // Text("⭐ 4.8",style: GoogleFonts.lato(
//                           //     color: greyColor,
//                           //     fontSize: 14,
//                           //     fontWeight: FontWeight.w600
//                           // ),),
//                         ],
//                       ),
//                       subtitle: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text("Hour : $hour",style: GoogleFonts.lato(
//                               color: greyColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600
//                           ),),
//                           Text("Timing : $pickTime",style: GoogleFonts.lato(
//                               color: greyColor,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600
//                           ),),
//                         ],
//                       ),
//                     )
//                 ),
//                 ///Second Line Design
//                 Container(
//                   decoration: const BoxDecoration(
//                       border: Border(bottom: BorderSide(color: curvePageColor))
//                   ),
//                   child: ListTile(
//                     contentPadding: const EdgeInsets.symmetric(horizontal: 10),
//                     // leading: Container(
//                     //   width: 40,
//                     //   height: 40,
//                     //   child: ClipRRect(
//                     //       borderRadius: BorderRadius.circular(50),
//                     //       child: Image.asset(image,fit: BoxFit.cover,)),
//                     // ),
//                     title:  Row(
//                       children: [
//                         SizedBox(
//                           width: 40,
//                           height: 40,
//                           child: ClipRRect(
//                               borderRadius: BorderRadius.circular(50),
//                               child: Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Image.asset(fuel,),
//                               )),
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text("Fuel Type",style: GoogleFonts.lato(
//                                 color: greyColor,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w700
//                             ),),
//                             Text("Petrol / AC",style: GoogleFonts.lato(
//                                 color: greyColor,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w700
//                             ),),
//                           ],
//                         ),
//                       ],
//                     ),
//                     trailing: SizedBox(
//                       width: 100,
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: 40,
//                             height: 40,
//                             child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(50),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(12.0),
//                                   child: Image.asset(dollar,),
//                                 )),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text("Price",style: GoogleFonts.lato(
//                                   color: greyColor,
//                                   fontSize: 14,
//                                   fontWeight: FontWeight.w700
//                               ),),
//                               Text(price,style: GoogleFonts.lato(
//                                   color: greyColor,
//                                   fontSize: 11,
//                                   fontWeight: FontWeight.w700
//                               ),),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 ///Second Line Design
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 5),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           RichText(text: TextSpan(
//                             children: [
//                               TextSpan(
//                                 text: "Kilometers : ",style: titleTextStyle,
//                               ),
//                               TextSpan(
//                                 text: kilometers,style: loginTextStyle,
//                               ),
//                             ]
//                           )),
//                           const SizedBox(height: 10),
//                           // RichText(text: TextSpan(
//                           //     children: [
//                           //       TextSpan(
//                           //         text: "PickUp Location : ",style: titleTextStyle,
//                           //       ),
//                           //       TextSpan(
//                           //         text: "100",style: loginTextStyle,
//                           //       ),
//                           //     ]
//                           // )),
//                           // Text("Kilometers",style: titleTextStyle,),
//                           Text("PickUp Location :-",style: titleTextStyle,),
//                           const SizedBox(height: 5),
//                           Text(pickUpLocation,style: infoTextStyle,),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Text("₹ $totalPrice",style: appbarTextStyle,),
//                           Text("Inclusive of GST",style: titleTextStyle,),
//                           CustomButtonSmall(
//                             width: AppDimension.getWidth(context)*.32,
//                             btnHeading: "Book Ride",
//                               onTap: onTap,),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

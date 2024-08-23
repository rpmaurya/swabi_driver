// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
//
// class CustomDropDownWidget extends StatefulWidget {
//   final List<String> items;
//   final String initialize;
//   final String hint;
//
//   const CustomDropDownWidget({super.key, required this.items, required this.initialize, required this.hint});
//
//   @override
//   State<CustomDropDownWidget> createState() => _CustomDropDownWidgetState();
// }
//
// class _CustomDropDownWidgetState extends State<CustomDropDownWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButtonHideUnderline(
//       child: DropdownButton2<String>(
//         isExpanded: true,
//         hint: Text(
//           widget.hint,
//           style: TextStyle(
//             fontSize: 14,
//             color: Theme.of(context).hintColor,
//           ),
//         ),
//         items: widget.items
//             .map((String item) => DropdownMenuItem<String>(
//           value: item,
//           child: Text(
//             item,
//             style: const TextStyle(
//               fontSize: 14,
//             ),
//           ),
//         ))
//             .toList(),
//         value: widget.initialize,
//         onChanged: (String? value) {
//           setState(() {
//             widget.initialize = value;
//           });
//         },
//         buttonStyleData: const ButtonStyleData(
//           padding: EdgeInsets.symmetric(horizontal: 16),
//           height: 40,
//           width: 140,
//         ),
//         menuItemStyleData: const MenuItemStyleData(
//           height: 40,
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

class Customtextformfield extends StatefulWidget {
  final String hintText;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final bool? prefixiconvisible;
  final Widget? prefixIcon;
  final String? img;
  final TextInputType? textInputType;
  final int? maxLines;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  const Customtextformfield(
      {super.key,
      required this.hintText,
      this.focusNode,
      this.controller,
      this.prefixiconvisible,
      this.prefixIcon,
      this.img,
      this.maxLines,
      this.textInputType,
      this.onChanged,
      this.validator});

  @override
  State<Customtextformfield> createState() => _CustomtextformfieldState();
}

class _CustomtextformfieldState extends State<Customtextformfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: widget.maxLines ?? 1,
      focusNode: widget.focusNode,
      controller: widget.controller,
      keyboardType: widget.textInputType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        filled: true,
        fillColor: Colors.white,
        prefixIcon: widget.prefixiconvisible == true
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  widget.img ?? '',
                  width: 15,
                  height: 15,
                ),
              )
            : widget.prefixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: InputBorder.none,
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
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}

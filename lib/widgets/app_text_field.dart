import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    Key? key,
    required this.hint,
    required this.prefixIcon,
    required this.keyboardType,
    required this.textEditingController,
    this.focusedBorderColor = Colors.grey,
    this.obscure = false,
    this.suffixIcon,
  }) : super(key: key);

  final String hint;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final TextEditingController textEditingController;
  final Color focusedBorderColor;
  final Widget? suffixIcon;
  final bool obscure;

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      controller: textEditingController,
      obscureText: obscure,
      style: GoogleFonts.cairo(),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.zero,
        hintText: hint,
        hintStyle: GoogleFonts.cairo(fontSize: 13.sp),
        hintMaxLines: 1,
        prefixIcon: Icon(prefixIcon),
        enabledBorder: buildOutlineInputBorder(),
        focusedErrorBorder: buildOutlineInputBorder(color: focusedBorderColor),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder({Color? color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide(color: color ?? Colors.grey),
    );
  }
}

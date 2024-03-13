import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class PopUpRowWidget extends StatelessWidget {
  PopUpRowWidget({
    super.key,
    required this.heading,
    required this.subheading,
  });
  String heading;
  String subheading;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          heading,
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.black),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          ":",
          style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 10.w,
        ),
        Text(
          subheading,
          style: GoogleFonts.inter(fontSize: 14.sp, color: Colors.black),
        )
      ],
    );
  }
}

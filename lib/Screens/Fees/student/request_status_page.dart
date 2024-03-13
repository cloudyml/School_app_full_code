import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/constants/route_constant.dart';
import 'package:school_management_system/constants/style.dart';

class RequestStatusPage extends StatelessWidget {
  // static const route = RouteConstants.parentChildrenviewFees;

  const RequestStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [lightBlue, deepBlue]),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 32.sp,
                      ),
                    ),
                    SizedBox(
                      width: 0.1.sw,
                    ),
                    Text(
                      "Payment Request",
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(4, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.r),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  // gradient: LinearGradient(colors: [
                                  //   Color.fromARGB(255, 122, 233, 203)
                                  //       .withOpacity(0.3),
                                  //   Color.fromARGB(255, 5, 235, 173)
                                  //       .withOpacity(0.3),
                                  // ]),
                                  border: Border.all(color: Colors.grey)),
                              child: Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Name: Harsh",
                                          style: GoogleFonts.inter(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Roll Number: 32",
                                          style: GoogleFonts.inter(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Amount : 50000",
                                          style: GoogleFonts.inter(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Date: 12/02/2024",
                                          style: GoogleFonts.inter(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Spacer(),
                                  Container(
                                      color: Colors.red,
                                      width: 0.2.sw,
                                      height: 200,
                                      child: Center(
                                          child: RotatedBox(
                                              quarterTurns: 3,
                                              child: Text(
                                                "Pending",
                                                style: TextStyle(
                                                    fontSize: 22.sp,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ))))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Attendance/Student/Week_attendance_student.dart';
import 'package:school_management_system/Screens/Attendance/Student/month_year_choose.dart';
import 'package:school_management_system/Screens/Dashboard.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:school_management_system/widget/switchStudentParentControl/switchChildRole.dart';
import '../../../constants/style.dart';



class StuChooseAttendance extends StatelessWidget {
  // static const route = RouteConstants.parentChildrenviewattendance;
  const StuChooseAttendance({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        
        body: Container(
          height: 1.0.sh,
          width: 1.0.sw,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [lightBlue, deepBlue])),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.0, top: 20.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                            return const Dashboard();
                          },));

                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: 32.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 0.05.sw,
                      ),
                      Image(
                        image: const AssetImage(
                          "assets/attendance_appbar.png",
                        ),
                        height: 30.h,
                      ),
                      SizedBox(
                        width: 0.02.sw,
                      ),
                      Text(
                        "Attendance",
                        style: GoogleFonts.inter(
                            fontSize: 24.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 10.h),
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SharedServiceParentChildren.loginDetails()
                                            ?.data
                                            ?.data
                                            ?.role ==
                                        "parent" &&
                                    (SharedServiceParentChildren.loginDetails()!
                                            .data!
                                            .data!
                                            .childrens!
                                            .length >
                                        1)
                                ? const SwitchChildOptionForParent()
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25.h,
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(10),
                  width: 1.0.sw,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r))),
                  child: Center(
                    child: Column(
                      children: [
                        const Text(
                          "Select one to move forward",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const ThisWeek()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.16,
                              decoration: BoxDecoration(
                                  border: Border.all(color: deepBlue),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey,
                                      offset: Offset(0, 3),
                                      //  spreadRadius: 3,
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.14,
                                      child: Image.asset(
                                          "assets/checking-attendance.png")),
                                  Text(
                                    "This Week",
                                    style: GoogleFonts.inter(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const MonthYearSelectForSeeingAttendance()));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: MediaQuery.of(context).size.height * 0.16,
                              decoration: BoxDecoration(
                                  border: Border.all(color: deepBlue),
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      color: Colors.grey,
                                      offset: Offset(0, 3),
                                      //  spreadRadius: 3,
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width: MediaQuery.of(context).size.width *
                                        0.14,
                                    child: Image.asset(
                                        "assets/checking-attendance.png"),
                                  ),
                                  Text(
                                    "Month Wise",
                                    style: GoogleFonts.inter(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
              ],
            ),
          ),
        ));
  }
}

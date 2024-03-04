import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/Models/Student/Exam/exam_routine_response_model.dart';
import 'package:school_management_system/Screens/Exam/parent/table_for_timetable.dart';
import 'package:school_management_system/Services/api_services/api_services.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:school_management_system/widget/switchStudentParentControl/switchChildRole.dart';
import '../../../constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class ParentSeeExamRoutine extends StatelessWidget {
  final String testType;
  const ParentSeeExamRoutine({super.key, required this.testType});

  @override
  Widget build(BuildContext context) {
    // double containerSize = MediaQuery.of(context).size.width / 8;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.3,
        ),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.19,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: appbar(
            "assets/flaticon/_exam.png",
            "Exam Routine",
            context,
            () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.h),
              child: Container(
                width: 0.95.sw,
                height: 0.1.sh,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.4), blurRadius: 5.r)
                    ]),
                child: Center(
                  child: Text(testType,
                      style: GoogleFonts.inter(
                          color: Colors.black,
                          letterSpacing: 1.0,
                          fontSize: 28.sp,
                          fontWeight: FontWeight.w500)),
                ),
              ),
            ),
            Text(
              "$testType Timetable",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  letterSpacing: 1.0,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
             
            FutureBuilder(
                future: ApiServices.viewExamRoutineParentStudent(
                    SharedServiceParentChildren.loginDetails()!.data!.data!.role.toString(),
                    testType),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data?.data?.examDetails?.length == null ||
                      snapshot.data?.data?.examDetails?.length == 0) {
                    return const Text('No result found.');
                  } else {
                    ExamRoutineResponseModel? timetable = snapshot.data;
                    log("Message= ${timetable!.message.toString()}");
                    log("Status= ${timetable.status.toString()}");

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Table(
                            border: TableBorder.all(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(2.r),
                            ),
                            columnWidths: const <int, TableColumnWidth>{
                              0: FlexColumnWidth(1.5), // Subject
                              1: FlexColumnWidth(1), // Date
                              2: FlexColumnWidth(1), // Time
                            },
                            children: [
                              TableRow(
                                children: [
                                  SizedBox(
                                    height: 0.05.sh,
                                    child: Center(
                                      child: Text(
                                        'Subject',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            letterSpacing: 1.0,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.05.sh,
                                    child: Center(
                                      child: Text(
                                        'Date',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            letterSpacing: 1.0,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 0.05.sh,
                                    child: Center(
                                      child: Text(
                                        'Time',
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            letterSpacing: 1.0,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                              children: List.generate(
                                  timetable.data!.examDetails!.length, (index) {
                            String formatDateTime(String date) {
                              // Assuming the input date is in "yyyy-MM-dd" format
                              final inputFormat = DateFormat("yyyy-MM-dd");
                              final outputFormat = DateFormat(
                                  "yyyy-MM-dd"); // Change this to your desired format
                              final parsedDate = inputFormat.parse(date);
                              return outputFormat.format(parsedDate);
                            }

                            return TimeTableParentStudent(
                              time: timetable.data!.examDetails![index].time
                                  .toString(),
                              date: formatDateTime(timetable
                                  .data!.examDetails![index].date
                                  .toString()),
                              subjectName: timetable
                                  .data!.examDetails![index].subject
                                  .toString(),
                              index: index,
                            );
                          })),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                        ],
                      ),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}

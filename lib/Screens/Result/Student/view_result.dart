import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Student/Result/student_see_result_model.dart';
import 'package:school_management_system/Screens/Result/Student/pdf_Result_data.dart';
import 'package:school_management_system/Screens/Result/Student/table_result.dart';
import 'package:school_management_system/Services/shared_services.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';

import '../../../Services/api_services/api_services.dart';
import '../../../constants/style.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

// String pathm = "";
// import 'package:flutter/material.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class SeeOwnResult extends StatelessWidget {
  final String testType;

  const SeeOwnResult({super.key, required this.testType});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    StudentResultResponseModel? result;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.3,
        ),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.20,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.07, left: height * 0.03),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.055, left: height * 0.02),
                child: Row(
                  children: [
                    Container(
                      width: height * 0.2,
                      height: height * 0.1,
                      child: Image.asset("assets/flaticon/result4.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: height * 0.005,
                        child: Text("",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
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
              "$testType Result",
              style: GoogleFonts.inter(
                  color: Colors.black,
                  letterSpacing: 1.0,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500),
            ),
            FutureBuilder(
                future: ApiServices.studentParentSeeResult(
                    SharedService.loginDetails()!.data!.data!.role.toString(),
                    testType),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator(); // Show loading indicator
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (!snapshot.hasData ||
                      snapshot.data == null ||
                      snapshot.data?.data?.data?.subjects?.length == null ||
                      snapshot.data?.data?.data?.subjects?.length == 0) {
                    return const Text('No result found.');
                  } else {
                    result = snapshot.data;
                    log("Message= ${result!.message.toString()}");
                    log("Status= ${result!.status.toString()}");

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
                              1: FlexColumnWidth(1), // Marks
                              2: FlexColumnWidth(1), // Grade
                              3: FlexColumnWidth(2), // Comment
                            },
                            children: [
                              TableRow(
                                // decoration: BoxDecoration(
                                //   gradient: Style.primaryGradient
                                // ),
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
                                        'Marks',
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
                                        'Grade',
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
                                        'Comment',
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
                            result!.data!.data!.subjects!.length,
                            (index) => TestResultsTable(
                              comment: result!
                                  .data!.data!.subjects![index].comments
                                  .toString(),
                              grade: result!.data!.data!.subjects![index].grades
                                  .toString(),
                              marks: result!.data!.data!.subjects![index].marks
                                  .toString(),
                              subjectName: result!
                                  .data!.data!.subjects![index].subject
                                  .toString(),
                              index: index,
                            ),
                          )),
                          SizedBox(
                            height: 10.h,
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Marks Obtained : ",
                                  ),
                                  Text(result!.data!.result!.totalMarks
                                          .toString() +
                                      "/" +
                                      result!.data!.result!.totalOutOffMarks
                                          .toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Grade Obtained : ",
                                  ),
                                  Text(result!.data!.result!.overAllGrades
                                      .toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Percentage Obtained : ",
                                  ),
                                  Text(result!.data!.result!.percentage
                                      .toString()),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Remark From Teacher : ",
                                  ),
                                  Text(result!.data!.result!.overAllComments
                                      .toString()),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }
                })
          ],
        ),
      ),
      floatingActionButton: MyElevatedButton(
          gradient: LinearGradient(colors: [
            deepBlue,
            lightBlue,
          ]),
          borderRadius: BorderRadius.circular(5.r),
          onPressed: () async {
            MakeOfPdf().makePdf(context, result!, testType);
          },
          child: Text(
            "Download Pdf",
            style: GoogleFonts.inter(
                color: Colors.white,
                letterSpacing: 1.0,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

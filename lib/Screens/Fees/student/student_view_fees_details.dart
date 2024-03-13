import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Fees/student/request_status_page.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:school_management_system/constants/route_constant.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

import '../../../Models/Student/Fees/student_fee_response_model.dart';
import '../../../Services/api_services/api_services.dart';
import '../../../constants/style.dart';

class StudentSeeFees extends StatefulWidget {
  const StudentSeeFees({super.key});

  @override
  State<StudentSeeFees> createState() => _StudentSeeFeesState();
}

class _StudentSeeFeesState extends State<StudentSeeFees> {
  TextEditingController amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            extra: appbar("assets/flaticon/_fees.png", " Fees", context, () {
              Navigator.pop(context);
            }),
          ),
        ),
        body: FutureBuilder<StudentFeesDetailsModel>(
          future: ApiServices.viewFees(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No data found"));
            } else {
              StudentFeesDetailsModel fees = snapshot.data!;

              return fees.data?.length == null
                  ? const Center(
                      child: Text("No Data found"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: List.generate(fees.data!.length, (index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // border: Border.all(color: deepBlue),
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 10.r,
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    offset: Offset(3, 5),
                                  )
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(10),
                                title: Text(
                                  "Class: ${fees.data![index].datumClass}",
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.sp),
                                ),
                                subtitle: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Admission Fees: ",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          "${fees.data![index].admissionFees}",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Tuition Fees: ",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          "${fees.data![index].tuitionFees}",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Library Deposit: ",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          "${fees.data![index].libraryFees}",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Transport Fees: ",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          "${fees.data![index].transportFees}",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Exam Fees: ",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          "${fees.data![index].examinationFees}",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Miscellaneous Fees: ",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                        Text(
                                          "${fees.data![index].miscellaneousFees}",
                                          style: GoogleFonts.inter(
                                              fontSize: 14.sp),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Fees ",
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${fees.data![index].totalFees?.toInt()}",
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Dicount ",
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          fees.data![index]
                                                      .discountPercentage ==
                                                  null
                                              ? "No Discount"
                                              : "${fees.data![index].discountPercentage?.toStringAsPrecision(4)} %",
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: fees.data![index]
                                                          .discountPercentage ==
                                                      null
                                                  ? Colors.red
                                                  : Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${fees.data![index].discountAmount?.toInt()}",
                                          style: GoogleFonts.inter(
                                              fontSize: 16,
                                              color: Colors.green,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Total Payable ",
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "${fees.data![index].discountedFees?.toInt()}",
                                          style: GoogleFonts.inter(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return RequestStatusPage();
                },
              ));
            },
            child: Text(
              "₹",
              style: TextStyle(fontSize: 22.sp),
            )));
  }
}

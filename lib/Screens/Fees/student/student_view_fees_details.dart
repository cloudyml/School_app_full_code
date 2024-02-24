import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Fees/student/pop_up_row_widget.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
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
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                      Text(
                                        "${fees.data![index].admissionFees}",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Tuition Fees: ",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                      Text(
                                        "${fees.data![index].tuitionFees}",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Library Deposit: ",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                      Text(
                                        "${fees.data![index].libraryFees}",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Transport Fees: ",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                      Text(
                                        "${fees.data![index].transportFees}",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Exam Fees: ",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                      Text(
                                        "${fees.data![index].examinationFees}",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Miscellaneous Fees: ",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
                                      ),
                                      Text(
                                        "${fees.data![index].miscellaneousFees}",
                                        style:
                                            GoogleFonts.inter(fontSize: 14.sp),
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
                                        fees.data![index].discountPercentage ==
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
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: SharedServiceParentChildren.type() == "student"
          ? Container()
          : ExpandableFab(
              overlayStyle: ExpandableFabOverlayStyle(blur: 5.r),
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                fabSize: ExpandableFabSize.regular,
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(5.r)),
                child: Text("₹"),
                foregroundColor: Colors.white,
                backgroundColor: deepBlue,
              ),
              closeButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const Icon(Icons.close),
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepOrange,
              ),
              children: [
                FloatingActionButton.large(
                  backgroundColor: lightBlue,
                  heroTag: null,
                  child: Text(
                    "Raise payment request",
                    style:
                        GoogleFonts.inter(color: Colors.white, fontSize: 14.sp),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          shape: BeveledRectangleBorder(
                              borderRadius: BorderRadius.circular(0.r)),
                          contentPadding: EdgeInsets.all(0),
                          content: Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 5.h),
                                  color: deepBlue,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Raise payment request",
                                        style: GoogleFonts.inter(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.black),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5.h, horizontal: 10.w),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      PopUpRowWidget(
                                          heading: "Name",
                                          subheading:
                                              "${SharedServiceParentChildren.childDetails()?.data?.data?.name}"),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      PopUpRowWidget(
                                          heading: "Roll No",
                                          subheading:
                                              "${SharedServiceParentChildren.childDetails()?.data?.data?.rollNumber}"),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      PopUpRowWidget(
                                          heading: "Class",
                                          subheading:
                                              "${SharedServiceParentChildren.childDetails()?.data?.data?.dataClass}"),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      PopUpRowWidget(
                                          heading: "section",
                                          subheading:
                                              "${SharedServiceParentChildren.childDetails()?.data?.data?.section}"),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      PopUpRowWidget(
                                          heading: "School Name",
                                          subheading:
                                              "${SharedServiceParentChildren.childDetails()?.data?.data?.schoolName}"),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      TextFormField(
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                          ),
                                          hintText: "Enter Amount",
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                    ],
                                  ),
                                ),
                                MyElevatedButton(
                                    height: 50.h,
                                    width: 0.25.sw,
                                    borderRadius: BorderRadius.circular(10.r),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Send",
                                      style: GoogleFonts.inter(
                                          fontSize: 14.sp,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                SizedBox(
                                  height: 10.h,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                FloatingActionButton.large(
                  backgroundColor: lightBlue,
                  heroTag: null,
                  child: Text(
                    "Track Request",
                    style:
                        GoogleFonts.inter(color: Colors.white, fontSize: 16.sp),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
    );
  }
}

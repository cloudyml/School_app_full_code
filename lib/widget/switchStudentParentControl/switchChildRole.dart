import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/fetched_children_model.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:school_management_system/constants/constants.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';

class SwitchChildOptionForParent extends StatefulWidget {
  const SwitchChildOptionForParent({super.key});

  @override
  State<SwitchChildOptionForParent> createState() =>
      _SwitchChildOptionForParentState();
}

class _SwitchChildOptionForParentState
    extends State<SwitchChildOptionForParent> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            List<FetchedChildrenModel> childrenDetailsList = [];
            final String? encodedData =
                preferences?.getString("all_child_info");
            if (encodedData != null) {
              final List<dynamic> decodedList = jsonDecode(encodedData);
              log(decodedList.toString());
              childrenDetailsList = decodedList
                  .map((data) => FetchedChildrenModel.fromJson(data))
                  .toList();
            } else {
              []; // Return empty list if data not found
            }
            log(childrenDetailsList.toString());

            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              content: Container(
                // height: 100.h,
                decoration: BoxDecoration(
                    // color: Colors.pink,
                    borderRadius: BorderRadius.circular(10.r)),
                padding: EdgeInsets.all(10.w),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children:
                        List.generate(childrenDetailsList.length, (index) {
                      return Container(
                        // height: 50.h,
                        // color: Colors.amberAccent,
                        child: Padding(
                          padding: EdgeInsets.all(8.h),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                child: Icon(Icons.person),
                              ),
                              SizedBox(
                                width: 10.w,
                              ),
                              Container(
                                // height: 50.h,
                                width: 0.5.sw,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      "${childrenDetailsList[index].data?.data?.name}",
                                      style: GoogleFonts.inter(
                                          color: Colors.black, fontSize: 12.sp),
                                    ),
                                    Text(
                                      "${childrenDetailsList[index].data?.data?.schoolName}",
                                      style: GoogleFonts.inter(
                                          color: Colors.black, fontSize: 12.sp),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Class : ${childrenDetailsList[index].data?.data?.dataClass}",
                                              style: GoogleFonts.inter(
                                                  color: Colors.black,
                                                  fontSize: 12.sp),
                                            ),
                                            Text(
                                              "Section : ${childrenDetailsList[index].data?.data?.section}",
                                              style: GoogleFonts.inter(
                                                  color: Colors.black,
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                        MyElevatedButton(
                                            gradient: LinearGradient(
                                                colors: [lightBlue, deepBlue]),
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            onPressed: () {
                                              setState(() {
                                                SharedServiceParentChildren
                                                        .setDetailsOfFetchedChild(
                                                            childrenDetailsList[
                                                                index])
                                                    .whenComplete(() {
                                                  Navigator.pop(context);
                                                });
                                              });
                                              setState(() {
                                                
                                              });
                                            },
                                            child: Text(
                                              "Select",
                                              style: GoogleFonts.inter(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600),
                                            ))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: 0.43.sw,
        decoration: BoxDecoration(
          // color: Colors.white,
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(
            50.r,
          ),
        ),
        child: Row(
          children: [
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: Colors.white,
                  ),
                ),
                child: const Icon(
                  Icons.person_3_sharp,
                  color: Colors.white,
                )),
            SizedBox(
              width: 10.w,
            ),
            Text(
              "${SharedServiceParentChildren.childDetails()?.data?.data?.name}",
              overflow: TextOverflow.clip,
              style: GoogleFonts.inter(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              width: 5.w,
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
              size: 26.sp,
            ),
          ],
        ),
      ),
    );
  }
}

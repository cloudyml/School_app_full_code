import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/fetched_children_model.dart';
import 'package:school_management_system/constants/constants.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import '../../../Services/shared_services.dart';
import '../../../constants/style.dart';
import '../../../widget/Role_Control/dashboard_gridview_data.dart';
import '../../Splash/splashScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<HomeScreen> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      // backgroundColor: const Color.fromARGB(255, 238, 238, 238),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [lightBlue, deepBlue])),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 15.w),
              child: Column(
                children: [
                  Container(
                    width: 1.0.sw,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Hi, ${SharedService.loginDetails()?.data!.data?.name}",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontSize: height * 0.03,
                          ),
                        ),
                        SharedService.loginDetails()?.data?.data?.role ==
                                    "parent" &&
                                (SharedService.loginDetails()!
                                        .data!
                                        .data!
                                        .childrens!
                                        .length >
                                    1)
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      List<FetchedChildrenModel>
                                          childrenDetailsList = [];
                                      final String? encodedData = preferences
                                          ?.getString("all_child_info");
                                      if (encodedData != null) {
                                        final List<dynamic> decodedList =
                                            jsonDecode(encodedData);
                                        log(decodedList.toString());
                                        childrenDetailsList = decodedList
                                            .map((data) =>
                                                FetchedChildrenModel.fromJson(
                                                    data))
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
                                              borderRadius:
                                                  BorderRadius.circular(10.r)),
                                          padding: EdgeInsets.all(10.h),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: List.generate(
                                                  childrenDetailsList.length,
                                                  (index) {
                                                return Container(
                                                  // height: 50.h,
                                                  // color: Colors.amberAccent,
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.h),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const CircleAvatar(
                                                          child: Icon(
                                                              Icons.person),
                                                        ),
                                                        Container(
                                                          // height: 50.h,
                                                          width: 0.5.sw,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              Text(
                                                                "${childrenDetailsList[index].data?.data?.name}",
                                                                style: GoogleFonts.inter(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
                                                              Text(
                                                                "${childrenDetailsList[index].data?.data?.schoolName}",
                                                                style: GoogleFonts.inter(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        12.sp),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        "Class : ${childrenDetailsList[index].data?.data?.dataClass}",
                                                                        style: GoogleFonts.inter(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12.sp),
                                                                      ),
                                                                      Text(
                                                                        "Section : ${childrenDetailsList[index].data?.data?.section}",
                                                                        style: GoogleFonts.inter(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize: 12.sp),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  MyElevatedButton(
                                                                      gradient:
                                                                          LinearGradient(
                                                                              colors: [
                                                                            lightBlue,
                                                                            deepBlue
                                                                          ]),
                                                                      borderRadius:
                                                                          BorderRadius.circular(5
                                                                              .r),
                                                                      onPressed:
                                                                          () {
                                                                       setState(() {
                                                                          SharedService.setDetailsOfFetchedChild(
                                                                            childrenDetailsList[index]).whenComplete(() {
                                                                              Navigator.pop(context);
                                                                            });
                                                                       });
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        "Select",
                                                                        style: GoogleFonts.inter(
                                                                            color:
                                                                                Colors.white,
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
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius:
                                          BorderRadius.circular(10.r)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 2.h, horizontal: 5.w),
                                  child: Row(
                                    children: [
                                      Text(
                                        "${SharedService.childDetails()?.data?.data?.name}",
                                        overflow: TextOverflow.clip,
                                        style: GoogleFonts.inter(
                                            color: Colors.black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      CircleAvatar(
                                        radius: 15.r,
                                        child: const Icon(Icons.person),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : IconButton(
                                icon: const Icon(
                                  Icons.logout_outlined,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                onPressed: () {
                                  SharedService.logout().then((value) {
                                    if (value == true) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const SplashScreen()),
                                          (Route<dynamic> route) => false);
                                    }
                                  });
                                },
                                // child: const Text('LOGOUT'),
                              ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.height * 0.4,
                        child: SharedService.loginDetails()?.data?.data?.role ==
                                "parent"
                            ? Text(
                                SharedService.childDetails()
                                            ?.data
                                            ?.data
                                            ?.schoolName ==
                                        null
                                    ? "Loading"
                                    : "${SharedService.childDetails()?.data?.data?.schoolName}",
                                softWrap: true,
                                maxLines: 10,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    //  letterSpacing: 1.0,
                                    fontSize: height * 0.04,
                                    fontWeight: FontWeight.bold))
                            : Text(
                                "${SharedService.loginDetails()?.data?.data?.school}",
                                softWrap: true,
                                maxLines: 10,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    //  letterSpacing: 1.0,
                                    fontSize: height * 0.04,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ],
              ),
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
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      child: Row(children: <Widget>[
                        Expanded(child: Divider()),
                        Text(
                          "  Dashboard  ",
                          style: TextStyle(fontSize: 25),
                        ),
                        Expanded(child: Divider()),
                      ]),
                    ),
                    Expanded(
                      // Wrap the Column with Expanded
                      child: GridView.builder(
                        itemCount: categoryList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 8.0,
                        ),
                        itemBuilder: (context, index) {
                          CategoryData category = categoryList[index];
                          return CategoryBox(
                            data: category,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

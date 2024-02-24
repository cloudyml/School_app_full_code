import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:school_management_system/Services/teacher_shared_service.dart';
import 'package:school_management_system/widget/switchStudentParentControl/switchChildRole.dart';

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
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [lightBlue, deepBlue])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 1.0.sw,
                    // color: Colors.amber,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          SharedServiceParentChildren.type() == "teacher"
                              ? "Hi, ${TeacherSharedServices.loginDetails()?.data!.data?.name}"
                              : "Hi, ${SharedServiceParentChildren.loginDetails()?.data!.data?.name}",
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            letterSpacing: 1.0,
                            fontSize: height * 0.03,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.logout_outlined,
                            color: Colors.black,
                            size: 30,
                          ),
                          onPressed: () {
                            SharedServiceParentChildren.type() == "teacher"
                                ? TeacherSharedServices.logout().then((value) {
                                    if (value == true) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const SplashScreen()),
                                          (Route<dynamic> route) => false);
                                    }
                                  })
                                : SharedServiceParentChildren.logout()
                                    .then((value) {
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
                        child: SharedServiceParentChildren.type() == "parent"
                            ? Text(
                                SharedServiceParentChildren.childDetails()
                                            ?.data
                                            ?.data
                                            ?.schoolName ==
                                        null
                                    ? "Loading"
                                    : "${SharedServiceParentChildren.childDetails()?.data?.data?.schoolName}",
                                softWrap: true,
                                maxLines: 10,
                                overflow: TextOverflow.fade,
                                style: GoogleFonts.inter(
                                    color: Colors.white,
                                    //  letterSpacing: 1.0,
                                    fontSize: height * 0.04,
                                    fontWeight: FontWeight.bold))
                            : Text(
                                SharedServiceParentChildren.type() == "teacher"
                                    ? "${TeacherSharedServices.loginDetails()?.data?.data?.schoolName}"
                                    : "${SharedServiceParentChildren.loginDetails()?.data?.data?.schoolName}",
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
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: 0.5.sw,
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
                  )
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
                    SizedBox(
                      height: 15.h,
                    ),
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

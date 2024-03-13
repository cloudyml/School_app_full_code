import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Events/teacher/View/view_events_teacher.dart';
import 'package:school_management_system/Screens/Navbar/About/view_about_school.dart';
import 'package:school_management_system/Screens/Navbar/Account/Teacher/Coaching/add_student_before_page.dart';
import 'package:school_management_system/Screens/Navbar/Notice/Teacher/view_notice_teacher.dart';
import 'package:school_management_system/Services/teacher_shared_service.dart';
import 'package:school_management_system/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../Splash/splashScreen.dart';
import '../Teacher/Edit_Teacher/teacher_edit_own_details.dart';

class TeacherMyAccount extends StatelessWidget {
  const TeacherMyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecorativeAppBar(
              barHeight: MediaQuery.of(context).size.height * 0.21,
              barPad: MediaQuery.of(context).size.height * 0.16,
              radii: 20,
              background: Colors.white,
              gradient1: lightBlue,
              gradient2: deepBlue,
              extra: Container(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.07, left: height * 0.03),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: height * 0.07, left: height * 0.02),
                    child: Row(
                      children: [
                        Container(
                          width: 35,
                          height: 35,
                          child:
                              Image.asset("assets/My_account/my_account.png"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text(" My Account",
                              style: GoogleFonts.inter(
                                  color: Colors.white,
                                  letterSpacing: 1.0,
                                  fontSize: height * 0.03,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.16,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        border: Border.all(color: deepBlue),
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 5,
                            //  blurStyle: BlurStyle.inner,
                            color: Colors.grey,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.03, right: width * 0.12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: deepBlue,
                              child: Align(
                                alignment: Alignment.center,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/My_account/avatar.png",
                                    width: 50,
                                    height: 80,
                                    //   fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${TeacherSharedServices.loginDetails()!.data!.data!.name.toString()}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 22),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                SizedBox(
                                  width: width *
                                      0.45, // Set a width that fits your text without overflow
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        Text(
                                          "${TeacherSharedServices.loginDetails()!.data!.data!.email.toString()}",
                                          maxLines:
                                              1, // Display only one line of text
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                    "+${91} ${TeacherSharedServices.loginDetails()!.data!.data!.phoneNumber.toString()}"),
                                const SizedBox(
                                  height: 3,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      TeacherSharedServices.loginDetails()!
                                          .data!
                                          .data!
                                          .gender
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      right: 2,
                      top: 5,
                      child: IconButton(
                          onPressed: () {
                            if (TeacherSharedServices.loginDetails()
                                    ?.data!
                                    .data!
                                    .role ==
                                "teacher") {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const EditTeacherAccountDetails()));
                            }
                          },
                          icon: const Icon(Icons.edit)),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),

                /// Below Button is For Coaching.......... ////////////////////////

                TeacherSharedServices.loginDetails()?.data!.data!.role ==
                        "coaching"
                    ? InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddStudentCoaching()));
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            //  border: Border.all(color: deepBlue),
                            borderRadius: BorderRadius.circular(18),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: width * 0.09, right: width * 0.1),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: deepBlue,
                                    child: ClipOval(
                                      child: Image.asset(
                                        "assets/upload.png",
                                        color: Colors.white,
                                        //  fit: BoxFit.cover,
                                        width: 60,
                                        height: height * 0.04,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width *
                                            0.5, // Set a width that fits your text without overflow
                                        child: const SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Add a student",
                                                style: TextStyle(fontSize: 20),

                                                maxLines:
                                                    1, // Display only one line of text
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width *
                                            0.5, // Set a width that fits your text without overflow
                                        child: const SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                "Register a new student",

                                                maxLines:
                                                    1, // Display only one line of text
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => TeacherViewEvents()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: deepBlue),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.09, right: width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: deepBlue,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/My_account/my_events.png",
                                    //  fit: BoxFit.cover,
                                    width: 60,
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Event Enrolled",
                                            style: TextStyle(fontSize: 20),

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Enrolled students list in events",

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ViewAboutSchool()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: deepBlue),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.09, right: width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: deepBlue,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/My_account/about_us.png",
                                    //  fit: BoxFit.cover,
                                    width: 60,
                                    height: 20,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "About Us",
                                            style: TextStyle(fontSize: 20),

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Know about our mission and vision",

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    log("Support");
                    String? encodeQueryParameters(Map<String, String> params) {
                      return params.entries
                          .map((MapEntry<String, String> e) =>
                              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                          .join('&');
                    }

                    final Uri emailUrl = Uri(
                      scheme: 'mailto',
                      path: 'kalpita@cloudyml.com',
                      query: encodeQueryParameters(<String, String>{
                        'subject': "School app problems",
                        'body': "g"
                      }),
                    );
                    if (await canLaunchUrl(emailUrl)) {
                      launchUrl(emailUrl);
                    } else {
                      throw Exception('Could not launch $emailUrl');
                    }
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: deepBlue),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.09, right: width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: deepBlue,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/My_account/support.png",
                                    //  fit: BoxFit.cover,
                                    width: 60,
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Support",
                                            style: TextStyle(fontSize: 20),

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Email us for any help",

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const TeacherViewNoticeScreen()));
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      //  border: Border.all(color: deepBlue),
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: width * 0.09, right: width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: deepBlue,
                                child: ClipOval(
                                  child: Image.asset(
                                    "assets/My_account/notifications.png",
                                    //  fit: BoxFit.cover,
                                    width: 60,
                                    height: 30,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "Notifications",
                                            style: TextStyle(fontSize: 20),

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width *
                                        0.5, // Set a width that fits your text without overflow
                                    child: const SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          Text(
                                            "See all related notifications",

                                            maxLines:
                                                1, // Display only one line of text
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () async {
                    preferences?.clear();
                    log("This  is the data in the pref ---------> ${preferences?.get("login_details")}");
                    await TeacherSharedServices.logout().then((value) {
                      if (value == true) {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SplashScreen()),
                            (Route<dynamic> route) => false);

                        log(TeacherSharedServices.isLoggedIn().toString());
                        log(TeacherSharedServices.loginDetails().toString());
                      }
                    });
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.11,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      gradient: LinearGradient(
                        colors: [
                          lightBlue,
                          deepBlue
                        ], // Specify your gradient colors here
                        begin: Alignment
                            .centerLeft, // Adjust the gradient begin alignment
                        end: Alignment
                            .centerRight, // Adjust the gradient end alignment
                      ),
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.09,
                        right: width * 0.1,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundColor: deepBlue,
                            child: ClipOval(
                              child: Image.asset(
                                "assets/My_account/logout.png",
                                width: 60,
                                height: 20,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                "Logout",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22),
                              ),
                              SizedBox(
                                width: width * 0.2,
                              ),
                              const Icon(
                                Icons.logout,
                                color: Colors.white,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

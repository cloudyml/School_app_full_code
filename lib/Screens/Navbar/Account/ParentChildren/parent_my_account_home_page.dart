
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Events/parent/child_enrolled_event.dart';
import 'package:school_management_system/Screens/Navbar/About/parent_about_school_view.dart';
import 'package:school_management_system/Screens/Navbar/Account/ParentChildren/edit_parent/parent_edit_details.dart';
import 'package:school_management_system/Screens/Navbar/Account/ParentChildren/optionTile.dart';
import 'package:school_management_system/Screens/Navbar/Notice/Student/student_notice_screen.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../Splash/splashScreen.dart';

class ParentMyAccount extends StatelessWidget {
  const ParentMyAccount({super.key});

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
                Container(
                  width: 0.9.sw,
                  decoration: BoxDecoration(
                    border: Border.all(color: deepBlue),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                        SizedBox(
                          width: 5.w,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              SharedServiceParentChildren.loginDetails()!
                                  .data!
                                  .data!
                                  .name
                                  .toString(),
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
                                      SharedServiceParentChildren
                                              .loginDetails()!
                                          .data!
                                          .data!
                                          .email
                                          .toString(),

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
                                "+${91} ${SharedServiceParentChildren.loginDetails()?.data?.data?.phoneNumber.toString()}"),
                            const SizedBox(
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${SharedServiceParentChildren.loginDetails()?.data?.data?.gender}",
                                ),
                              ],
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const EditParentAccountDetails()));
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ParentViewChildEnrolledEvents()));
                    },
                    child: OptionTileWidgetAccount(
                        heading: "My Enrolled Events",
                        subheading: "School events enrolled list",
                        imageIcon: "assets/My_account/my_events.png")),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ParentViewAboutSchool(),
                        ),
                      );
                    },
                    child: OptionTileWidgetAccount(
                        heading: "About Us",
                        subheading: "Know about our mission and vision",
                        imageIcon: "assets/My_account/about_us.png")),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () async {
                      log("Support");
                      String? encodeQueryParameters(
                          Map<String, String> params) {
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
                          'body': "Dear sir/madam"
                        }),
                      );
                      if (await canLaunchUrl(emailUrl)) {
                        launchUrl(emailUrl);
                      } else {
                        throw Exception('Could not launch $emailUrl');
                      }
                    },
                    child: OptionTileWidgetAccount(
                        heading: "App Support",
                        subheading: "Email the tech team for any help",
                        imageIcon: "assets/My_account/support.png")),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const ViewNoticeScreen()));
                    },
                    child: OptionTileWidgetAccount(
                        heading: "Notifications",
                        subheading: "See all related notifications",
                        imageIcon: "assets/My_account/notifications.png")),
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    SharedServiceParentChildren.logout().then((value) {
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
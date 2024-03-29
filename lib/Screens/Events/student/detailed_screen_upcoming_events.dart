import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Events/student/register_events.dart';
import 'package:school_management_system/Services/api_services/api_services.dart';
import '../../../constants/style.dart';
import '../../../widget/Button/my_elevatedbutton.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class UpcomingDetailsEventScreen extends StatefulWidget {
  final String imglink;
  final String des;
  final String eligibleClass;
  final String time;
  final String date;
  final List<String> eventPics;
  // final String remark;
  final String heading;
  final String eventID;
  const UpcomingDetailsEventScreen({
    super.key,
    required this.imglink,
    required this.des,
    required this.eligibleClass,
    required this.time,
    required this.date,
    required this.eventPics,
    // required this.remark,
    required this.heading,
    required this.eventID,
  });

  @override
  State<UpcomingDetailsEventScreen> createState() => _DetailsEventScreenState();
}

class _DetailsEventScreenState extends State<UpcomingDetailsEventScreen> {
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            DecorativeAppBar(
              barHeight: MediaQuery.of(context).size.height * 0.24,
              barPad: MediaQuery.of(context).size.height * 0.19,
              radii: 30,
              background: Colors.white,
              gradient1: lightBlue,
              gradient2: deepBlue,
              extra: appbar("assets/add_events.png", " Events", context, () {
                Navigator.pop(context);
              }),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: Container(
                height: height * 0.24,
                width: width * 0.93,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13),
                    boxShadow: const [
                      BoxShadow(
                          color: const Color.fromARGB(255, 118, 118, 118),
                          blurRadius: 8)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(13),
                  child: Image.network(
                    widget.imglink,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: width * 0.93,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: Text(
                        widget.heading,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: const Color.fromARGB(255, 48, 48, 48),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: Text(
                        "Description :",
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 48, 48, 48),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: Text(
                        widget.des,
                        style: GoogleFonts.inter(
                            fontSize: 13,
                            // fontWeight: FontWeight.w700,
                            color: const Color.fromARGB(255, 58, 58, 58)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Eligible class : ",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 48, 48, 48)),
                          ),
                          Text(
                            widget.eligibleClass,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                // fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 63, 63, 63)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Time : ",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 48, 48, 48)),
                          ),
                          Text(
                            widget.time,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                // fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 63, 63, 63)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: Row(
                        children: [
                          Text(
                            "Date : ",
                            style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 48, 48, 48)),
                          ),
                          Text(
                            widget.date,
                            style: GoogleFonts.inter(
                                fontSize: 13,
                                // fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(255, 63, 63, 63)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, left: 8),
                      child: Text(
                        "Event Pictures :",
                        style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: const Color.fromARGB(255, 48, 48, 48)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8, top: 8, bottom: 4),
                      child: Container(
                        height: 90,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, i) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 4.0),
                              child: Container(
                                  height: 70,
                                  width: 90,
                                  child: Image.network(
                                    widget.eventPics[i],
                                    fit: BoxFit.cover,
                                  )),
                            );
                          },
                          itemCount: widget.eventPics.length,
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5.0, left: 8),
                    //   child: Text(
                    //     "Remark :",
                    //     style: GoogleFonts.inter(
                    //         fontSize: 15,
                    //         fontWeight: FontWeight.w600,
                    //         color: const Color.fromARGB(255, 48, 48, 48)),
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 10.0, left: 8),
                    //   child: Text(
                    //     widget.remark,
                    //     style: GoogleFonts.inter(
                    //         fontSize: 13,
                    //         // fontWeight: FontWeight.w700,
                    //         color: const Color.fromARGB(255, 58, 58, 58)),
                    //   ),
                    // ),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyElevatedButton(
                          width: width * 5,
                          height: height * 0.07,
                          onPressed: () async {
                            log("Event ID= ${widget.eventID}");
                            if (isClicked == false) {
                              setState(() {
                                isClicked = true;
                              });
                              log("Hello");
                              await ApiServices
                                      .studentEligibilityCheckForEnrollEvents(
                                          widget.eventID)
                                  .then((value) {
                                log("Message: ${value.message.toString()}");
                                if (value.status == true) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StudentRegisterEvents(
                                        eventHeading: widget.heading,
                                        eventID: widget.eventID,
                                      ),
                                    ),
                                  ).whenComplete(() {
                                    setState(() {
                                      isClicked = false;
                                    });
                                  });
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "Not eligible",
                                        ),
                                        content: const Text(
                                            "Either You are not eligible for this event or You have already registered"),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              "OK",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the alert dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  ).whenComplete(() {
                                    setState(() {
                                      isClicked = false;
                                    });
                                  });
                                }
                              });
                            }
                          },
                          child: Text(
                            "Register Now",
                            style: GoogleFonts.inter(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}

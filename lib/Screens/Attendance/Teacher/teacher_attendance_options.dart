import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Attendance/Teacher/upload/choose_class_section.dart';
import 'package:school_management_system/Screens/Attendance/Teacher/view/choose_class_section_date_for_view_attendance.dart';
import 'package:school_management_system/constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';
import '../../Dashboard.dart';

class TeacherAttendanceOptions extends StatefulWidget {
  const TeacherAttendanceOptions({Key? key}) : super(key: key);

  @override
  State<TeacherAttendanceOptions> createState() => _UploadGalleryState();
}

class _UploadGalleryState extends State<TeacherAttendanceOptions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(400),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.19,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: appbar(
              "assets/attendance_appbar.png", "View Attendance", context, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
            const Text(
              "Select one to move forward",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ChooseClassForTakeAttendance()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  height: MediaQuery.of(context).size.height * 0.16,
                  decoration: BoxDecoration(
                      border: Border.all(color: deepBlue),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          //  spreadRadius: 3,
                        ),
                      ]),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.14,
                        child: Image.asset("assets/upload.png"),
                      ),
                      Text(
                        "Take Attendance",
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ChooseClassForViewAttendance()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.47,
                  height: MediaQuery.of(context).size.height * 0.16,
                  decoration: BoxDecoration(
                      border: Border.all(color: deepBlue),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          //  spreadRadius: 3,
                        ),
                      ]),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.14,
                        child: Image.asset("assets/view.png"),
                      ),
                      Text(
                        "View Attendance",
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:school_management_system/Services/api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class TeacherViewAttendanceDayWise extends StatelessWidget {
  final String selectedClass;
  final String selectedSection;
  final String selectedDate;
  const TeacherViewAttendanceDayWise(
      {super.key,
      required this.selectedClass,
      required this.selectedSection,
      required this.selectedDate});

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
          extra: appbar(
              "assets/attendance_appbar.png", "View Attendance", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text("Student Name"), Text('Attendance')],
          ),
          FutureBuilder(
              future: ApiServices.teacherSeeAttendanceOfWholeClassOfAday(
                  selectedClass, selectedSection, selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Center(child: Text("Error..."));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text("No data found"));
                } else {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider(
                          color: Bg,
                          thickness: 1,
                        );
                      },
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return const ListTile(
                          title: Text("data"),
                          trailing: Text("data"),
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}

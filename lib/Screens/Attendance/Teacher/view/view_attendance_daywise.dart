// import 'package:flutter/material.dart';
// import 'package:school_management_system/Models/Teacher/Attendance/view_attendance_of_class_response_model.dart';
// import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
// import 'package:school_management_system/constants/style.dart';
// import 'package:school_management_system/widget/appBar/appbar_widget.dart';
// import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

// class TeacherViewAttendanceDayWise extends StatefulWidget {
//   final String selectedClass;
//   final String selectedSection;
//   final String selectedDate;
//   const TeacherViewAttendanceDayWise(
//       {super.key,
//       required this.selectedClass,
//       required this.selectedSection,
//       required this.selectedDate});

//   @override
//   State<TeacherViewAttendanceDayWise> createState() =>
//       _TeacherViewAttendanceDayWiseState();
// }

// class _TeacherViewAttendanceDayWiseState
//     extends State<TeacherViewAttendanceDayWise> {
//   @override
//   void initState() async {
//     super.initState();
//     TeacherViewAttendanceOfClassResponseModel initData =
//         await TeacherApiServices.teacherSeeAttendanceOfWholeClassOfAday(
//             widget.selectedClass, widget.selectedSection, widget.selectedDate);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(
//           MediaQuery.of(context).size.height * 0.3,
//         ),
//         child: DecorativeAppBar(
//           barHeight: MediaQuery.of(context).size.height * 0.24,
//           barPad: MediaQuery.of(context).size.height * 0.19,
//           radii: 30,
//           background: Colors.white,
//           gradient1: lightBlue,
//           gradient2: deepBlue,
//           extra: appbar(
//               "assets/attendance_appbar.png", "View Attendance", context, () {
//             Navigator.pop(context);
//           }),
//         ),
//       ),
//       body: Column(
//         children: [
//           const Padding(
//             padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   "Student Name",
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22),
//                 ),
//                 Text(
//                   'Attendance',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontWeight: FontWeight.bold,
//                       fontSize: 22),
//                 )
//               ],
//             ),
//           ),
//           FutureBuilder(
//               future: TeacherApiServices.teacherSeeAttendanceOfWholeClassOfAday(
//                   widget.selectedClass,
//                   widget.selectedSection,
//                   widget.selectedDate),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 } else if (snapshot.hasError) {
//                   return const Center(child: Text("Error..."));
//                 } else if (snapshot.data?.data == null) {
//                   return const Center(child: Text("No data found"));
//                 } else {
//                   return Expanded(
//                     child: ListView.separated(
//                       separatorBuilder: (context, index) {
//                         return Divider(
//                           color: Bg,
//                           thickness: 1,
//                         );
//                       },
//                       itemCount: snapshot.data!.data!.data!.data!.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         TeacherViewAttendanceOfClassResponseModel? data =
//                             snapshot.data;
//                         return Padding(
//                           padding: const EdgeInsets.only(right: 20),
//                           child: ListTile(
//                             title: Text(
//                                 data!.data!.data!.data![index].name.toString()),
//                             trailing: data.data!.data!.data![index].attendance
//                                         .toString() ==
//                                     "present"
//                                 ? const Text(
//                                     "P",
//                                     style: TextStyle(
//                                         color: Colors.green, fontSize: 24),
//                                   )
//                                 : const Text("A",
//                                     style: TextStyle(
//                                         color: Colors.red, fontSize: 24)),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               }),
//         ],
//       ),
//     );
//   }
// }

//............. Above one is using Future Builder........................................................................

import 'package:flutter/material.dart';
import 'package:school_management_system/Models/Teacher/Attendance/view_attendance_of_class_response_model.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class TeacherViewAttendanceDayWise extends StatefulWidget {
  final String selectedClass;
  final String selectedSection;
  final String selectedDate;

  const TeacherViewAttendanceDayWise({
    Key? key,
    required this.selectedClass,
    required this.selectedSection,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<TeacherViewAttendanceDayWise> createState() =>
      _TeacherViewAttendanceDayWiseState();
}

class _TeacherViewAttendanceDayWiseState
    extends State<TeacherViewAttendanceDayWise> {
  late TeacherViewAttendanceOfClassResponseModel _attendanceData;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    final attendanceData =
        await TeacherApiServices.teacherSeeAttendanceOfWholeClassOfAday(
            widget.selectedClass, widget.selectedSection, widget.selectedDate);
    setState(() {
      _attendanceData = attendanceData;
      _isLoading = false;
    });
  }

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
            "assets/attendance_appbar.png",
            "View Attendance",
            context,
            () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: !_isLoading && _attendanceData.data != null,
                  child: const Text(
                    "Student Name",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Visibility(
                  visible: !_isLoading && _attendanceData.data != null,
                  child: const Text(
                    'Attendance',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _attendanceData.data == null
                  ? const Center(child: Text("No data found"))
                  : Expanded(
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return Divider(
                            color: Bg,
                            thickness: 1,
                          );
                        },
                        itemCount: _attendanceData.data!.data!.data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: ListTile(
                              title: Text(_attendanceData
                                  .data!.data!.data![index].name
                                  .toString()),
                              trailing: _attendanceData
                                          .data!.data!.data![index].attendance
                                          .toString() ==
                                      "present"
                                  ? const Text(
                                      "P",
                                      style: TextStyle(
                                          color: Colors.green, fontSize: 24),
                                    )
                                  : const Text("A",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 24)),
                            ),
                          );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}

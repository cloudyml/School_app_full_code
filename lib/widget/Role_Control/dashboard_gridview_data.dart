import 'package:flutter/material.dart';
import 'package:school_management_system/Screens/Attendance/Teacher/teacher_attendance_options.dart';

import 'package:school_management_system/Screens/Events/parent/parent_view_event.dart';
import 'package:school_management_system/Screens/Exam/Student/student_choose_examtype.dart';
import 'package:school_management_system/Screens/Exam/parent/parent_select_exam_type.dart';
import 'package:school_management_system/Screens/Fees/student/student_view_fees_details.dart';
import 'package:school_management_system/Screens/Gallery/parent/parents_view_school_gallery.dart';
import 'package:school_management_system/Screens/Result/Student/select_resulttype.dart';
import 'package:school_management_system/Screens/routine/teacher/choose_view_or_upload_timetable.dart';
import 'package:school_management_system/constants/style.dart';
import '../../Screens/Homework/Student/assignment_start_page.dart';
import '../../Screens/Homework/Teacher/upload_view_homework_options.dart';
import '../../Screens/Attendance/Student/choose_attendance.dart';
import '../../Screens/Awards/student/student_view_awards.dart';
import '../../Screens/Awards/teacher/first_page_select_award_options.dart';
import '../../Screens/Events/teacher/select_event_options.dart';
import '../../Screens/Events/student/student_view_events.dart';
import '../../Screens/Exam/Teacher/choose_view_or_upload_exam.dart';
import '../../Screens/Fees/teacher/teacher_view_fees.dart';
import '../../Screens/Gallery/student/view_gallery_student.dart';
import '../../Screens/Gallery/teacher/select_gallery_options.dart';
import '../../Screens/Result/Teacher/first_page_select_result_options.dart';
import '../../Screens/Routine/student/days_routine.dart';
import '../../Services/shared_services.dart';

class CategoryData {
  final String image;
  final String name;
  final Widget screen;

  CategoryData({required this.image, required this.name, required this.screen});
}

Widget getAttendanceScreen() {
  if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    // log("Teacher");
    return const TeacherAttendanceOptions();
  } else {
    return const StuChooseAttendance();
  }
}

Widget getAssignmentScreen() {
  if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    return const TeacherAssignmentFirstPage();
  } else {
    return const StudentAssignmentChoose();
  }
}

Widget getAwardstScreen() {
  if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    return const TeacherAwardOptions();
  } else {
    return const StudentViewAwards();
  }
}

Widget getGalleryScreen() {
  if (SharedService.loginDetails()?.data?.data?.role == "student") {
    // log("student");
    return const ViewGallery();
  } else if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    // log("Teacher");
    return const TeacherGalleryOptions();
  } else {
    // log("parent");
    return const ParentViewGallery();
  }
}

Widget getEventsScreen() {
  if (SharedService.loginDetails()?.data!.data?.role == "student") {
    // log("student");
    return const StudentsViewEvents();
  } else if (SharedService.loginDetails()?.data!.data?.role == "parent") {
    return const ParentsViewEvents();
  } else {
    //  log("Teacher");
    return const TeacherEventOptions();
  }
}

Widget Routine() {
  if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    return const TeacherTimetableOptions();
  } else {
    // log("Teacher");
    return const DayRoutine();
  }
}

Widget feeDetails() {
  if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    return const TeacherSeeFees();
  } else {
    return const StudentSeeFees();
  }
}

Widget examination() {
  if (SharedService.loginDetails()?.data?.data?.role == "student") {
    return const SelectExamType();
  } else if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    return const TeacherExamOptions();
  } else {
    return const ParentSelectExamType();
  }
}

Widget result() {
  if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
    return const TeacherResultOptions();
  } else {
    return const SelectResultType();
  }
}

List<CategoryData> categoryList = [
  CategoryData(
    image: 'assets/events_dashboard.png',
    name: 'Events',
    screen: getEventsScreen(),
  ),
  CategoryData(
    image: 'assets/exam.png',
    name: 'Examination',
    screen: examination(),
  ),
  CategoryData(
    image: 'assets/fees.png',
    name: 'Admission Fees',
    screen: feeDetails(),
  ),
  CategoryData(
    image: 'assets/gallery.png',
    name: 'Gallery',
    screen: getGalleryScreen(),
  ),
  CategoryData(
    image: 'assets/routine.png',
    name: 'Timetable',
    screen: Routine(),
  ),
  CategoryData(
    image: 'assets/checking-attendance.png',
    name: 'Attendance',
    screen: getAttendanceScreen(),
    // screen: Dashboard(),
  ),
  CategoryData(
    image: 'assets/_assignment.png',
    name: 'Homework',
    screen: getAssignmentScreen(),
  ),
  CategoryData(
    image: 'assets/result.png',
    name: 'Results',
    screen: result(),
  ),
  CategoryData(
    image: 'assets/awards.png',
    name: 'Awards',
    screen: getAwardstScreen(),
  ),
];

class CategoryBox extends StatelessWidget {
  final CategoryData data;

  CategoryBox({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => data.screen));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: deepBlue),
            // gradient: LinearGradient(
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            //   colors: [
            //     Colors.blue.shade300, // Lighter color on top
            //     Colors.blue.shade500, // Darker color on bottom
            //   ],
            // ),
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // Offset in the Y direction
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                data.image,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 8.0),
              Text(
                data.name,
                style: const TextStyle(
                  fontFamily: 'UbuntuMedium',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Text color
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

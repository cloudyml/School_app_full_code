import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Attendance/Student/choose_attendance.dart';
import 'package:school_management_system/Screens/Attendance/Teacher/teacher_attendance_options.dart';
import 'package:school_management_system/Screens/Awards/student/student_view_awards.dart';
import 'package:school_management_system/Screens/Awards/teacher/first_page_select_award_options.dart';
import 'package:school_management_system/Screens/Events/parent/parent_view_event.dart';
import 'package:school_management_system/Screens/Events/student/student_view_events.dart';
import 'package:school_management_system/Screens/Events/teacher/select_event_options.dart';
import 'package:school_management_system/Screens/Exam/Student/student_choose_examtype.dart';
import 'package:school_management_system/Screens/Exam/Teacher/choose_view_or_upload_exam.dart';
import 'package:school_management_system/Screens/Exam/parent/parent_select_exam_type.dart';
import 'package:school_management_system/Screens/Fees/student/student_view_fees_details.dart';
import 'package:school_management_system/Screens/Fees/teacher/teacher_view_fees.dart';
import 'package:school_management_system/Screens/Gallery/parent/parents_view_school_gallery.dart';
import 'package:school_management_system/Screens/Gallery/student/view_gallery_student.dart';
import 'package:school_management_system/Screens/Gallery/teacher/select_gallery_options.dart';
import 'package:school_management_system/Screens/Homework/Student/assignment_start_page.dart';
import 'package:school_management_system/Screens/Homework/Teacher/upload_view_homework_options.dart';
import 'package:school_management_system/Screens/Result/Student/select_resulttype.dart';
import 'package:school_management_system/Screens/Result/Teacher/first_page_select_result_options.dart';
import 'package:school_management_system/Screens/Routine/student/days_routine.dart';
import 'package:school_management_system/Screens/routine/teacher/choose_view_or_upload_timetable.dart';
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
  late List<Widget> categoryList; // Declare categoryList

  @override
  void initState() {
    super.initState();
    categoryList = [
      getEventsScreen(),
      examination(),
      feeDetails(),
      getGalleryScreen(),
      routine(),
      getAttendanceScreen(),
      getAssignmentScreen(),
      result(),
      getAwardstScreen()
    ];
  }

  Widget getAttendanceScreen() {
    if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherAttendanceOptions();
    } else {
      return const StuChooseAttendance();
    }
  }

  Widget getAssignmentScreen() {
    if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherAssignmentFirstPage();
    } else {
      return const StudentAssignmentChoose();
    }
  }

  Widget getAwardstScreen() {
    if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherAwardOptions();
    } else {
      return const StudentViewAwards();
    }
  }

  Widget getGalleryScreen() {
    if (SharedServiceParentChildren.type() == "student") {
      return const ViewGallery();
    } else if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherGalleryOptions();
    } else {
      return const ParentViewGallery();
    }
  }

  Widget getEventsScreen() {
    if (SharedServiceParentChildren.type() == "student") {
      return const StudentsViewEvents();
    } else if (SharedServiceParentChildren.type() == "parent") {
      return const ParentsViewEvents();
    } else {
      return const TeacherEventOptions();
    }
  }

  Widget routine() {
    if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherTimetableOptions();
    } else {
      return const DayRoutine();
    }
  }

  Widget feeDetails() {
    if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherSeeFees();
    } else {
      return const StudentSeeFees();
    }
  }

  Widget examination() {
    if (SharedServiceParentChildren.type() == "student") {
      return const SelectExamType();
    } else if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherExamOptions();
    } else {
      return const ParentSelectExamType();
    }
  }

  Widget result() {
    if (SharedServiceParentChildren.type() == "teacher") {
      return const TeacherResultOptions();
    } else {
      return const SelectResultType();
    }
  }

  List dashboardImages = [
    'assets/events_dashboard.png',
    'assets/exam.png',
    'assets/fees.png',
    'assets/gallery.png',
    'assets/routine.png',
    'assets/checking-attendance.png',
    'assets/_assignment.png',
    'assets/result.png',
    'assets/awards.png',
  ];

  List dashboardNames = [
    "Events",
    "Examination",
    "Fees",
    "Gallery",
    "Timetable",
    "Attendance",
    "Assignments",
    "Results",
    "Awards"
  ];
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
                          // CategoryData category = categoryList[index];

                          return CategoryBox(
                              data: CategoryData(
                                  image: dashboardImages[index],
                                  name: dashboardNames[index],
                                  screen: categoryList[index]));
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

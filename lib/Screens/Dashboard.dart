import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:school_management_system/Screens/Navbar/About/parent_about_school_view.dart';
import 'package:school_management_system/Screens/Navbar/Account/Parent/parent_my_account_home_page.dart';
import 'package:school_management_system/Services/shared_services.dart';
import '../constants/style.dart';
import 'Navbar/About/view_about_school.dart';
import 'Navbar/Account/Teacher/teacher_my_account_home_page.dart';
import 'Navbar/Home/home_screen.dart';
import 'Navbar/About/teacher_about_school_upload_view_options.dart';
import 'Navbar/Notice/Student/student_notice_screen.dart';
import 'Navbar/Notice/Teacher/choose_notice_options.dart';
import 'Navbar/Notice/parent_view_notice_screen.dart';
import 'Navbar/Account/Student/student_my_acccount_home_page.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  Widget _myAccountScreen() {
    if (SharedService.loginDetails()?.data?.data?.role == "student") {
      // log("Student");
      return const StudentMyAccount();
    } else if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
      // log("Teacher");
      return const TeacherMyAccount();
    } else {
      // print("PArent");
      // log("Parent");
      return const ParentMyAccount();
    }
  }

  Widget _noticeScreen() {
    if (SharedService.loginDetails()?.data?.data?.role == "student") {
      // log("Student");
      return const ViewNoticeScreen();
    } else if (SharedService.loginDetails()?.data?.data?.role == "teacher") {
      // log("Teacher");
      return const TeacherNoticeOptions();
    } else {
      // log("Parent");
      return const ParentViewNoticeScreen();
    }
  }

  Widget _AboutSchool() {
    if (SharedService.loginDetails()?.data?.data?.role == "student") {
      // log("Student");
      return const ViewAboutSchool();
    } else if (SharedService.loginDetails()?.data?.data?.role == "parent") {
      // log("Parent");
      return const ParentViewAboutSchool();
    } else {
      // log("Teacher");
      return const TeacherAboutSchoolOptions();
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const HomeScreen(),
      _AboutSchool(),
      _noticeScreen(),
      _myAccountScreen(),
    ];

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 149, 148, 148),
              spreadRadius: 5,
              blurRadius: 15,
              offset: Offset(0, 0), // Offset in the Y direction
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },

          backgroundColor: Colors.white, // Set the background color to blue
          selectedItemColor: deepBlue,
          unselectedItemColor: const Color.fromARGB(255, 178, 177, 177),

          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_border_outlined),
              label: 'About',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement_outlined),
              label: 'Notice',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
            ),
          ],
        ),
      ),
      body: screens[_currentIndex],
    );
  }
}

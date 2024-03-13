import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Login/login_screen.dart';
import '../../constants/style.dart';
import '../../widget/appBar/decorative_apbar_widget.dart';

class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreen();
}

class _RoleSelectScreen extends State<RoleSelectScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: 1.0.sw,
        height: 1.0.sh,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              lightBlue,
              deepBlue,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 0.2.sh,
                padding: EdgeInsets.only(top: 0.1.sh),
                child: Text(
                  "Select Your Role",
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    letterSpacing: 1.0,
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 0.8.sh,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.r),
                    topRight: Radius.circular(25.r),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewLoginScreen(
                              role: 'student',
                            ),
                          ),
                        );
                      },
                      child: roleContainer(
                          "assets/Role/student.png", "Student", context),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewLoginScreen(
                              role: 'teacher',
                            ),
                          ),
                        );
                      },
                      child: roleContainer(
                        "assets/Role/teacher.png",
                        "Teacher",
                        context,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => NewLoginScreen(
                              role: 'parent',
                            ),
                          ),
                        );
                      },
                      child: roleContainer(
                        "assets/Role/parent.png",
                        "Parent",
                        context,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget roleContainer(String imglink, String text, BuildContext context) {
  double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.only(left: 40.0, right: 40, bottom: 35),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          border: Border.all(color: deepBlue, width: 2),
          boxShadow: const [
            BoxShadow(color: Color.fromARGB(255, 199, 198, 198), blurRadius: 20)
          ]),
      height: height * 0.18,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
                width: width * 0.4,
                child: Image.asset(
                  imglink,
                  fit: BoxFit.fitHeight,
                )),
          ),
        ],
      ),
    ),
  );
}

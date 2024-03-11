import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Dashboard.dart';
import 'package:school_management_system/Screens/Homework/Student/type_of_assignments.dart';
import 'package:school_management_system/constants/route_constant.dart';

import '../../../constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class StudentAssignmentChooseAssignmentType extends StatelessWidget {
  static const route = RouteConstants.parentstudentviewassignment;
  const StudentAssignmentChooseAssignmentType({super.key});

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
              "assets/flaticon/_assignments.png", " Homework", context, () {
            Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) {
                return const Dashboard();
              },
            ));
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
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
                        builder: (context) => ChooseHomeWorkType(
                          typeOfAssignment: "getPendingAssignment",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
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
                          child: Image.asset("assets/_assignment.png"),
                        ),
                        Text(
                          "Pending Homework",
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
                        builder: (context) => ChooseHomeWorkType(
                          typeOfAssignment: "studentseeSubmittedAssignment",
                          // typeOfAssignment: "Text",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.7,
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
                          width: MediaQuery.of(context).size.width * 0.16,
                          child: Image.asset("assets/_assignment.png"),
                        ),
                        Text(
                          "Submitted Homework",
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
            ],
          ),
        ),
      ),
    );
  }
}

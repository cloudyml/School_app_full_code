import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:school_management_system/Models/Student/student_tex_assignment_submitted_model.dart';
import 'package:school_management_system/Models/Student/student_text_assignmrnt_model.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

import '../../../Services/Url_launcher.dart/method.dart';

class SubmittedAsignmentDetailScreen extends StatelessWidget {
  SubmittedAsignmentDetailScreen({super.key, required this.assignmentdata});
  List<SubmittedStudentIdTextAssignmentList>? assignmentdata;

  @override
  Widget build(BuildContext context) {
    LaunceToWeb Launceweb = LaunceToWeb();
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
              Navigator.pop(context);
            }),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(assignmentdata!.length, (index) {
            return Container(
              padding: EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Q${index + 1}. ${assignmentdata![index].question}",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500)),
                  Text("Answer : ${assignmentdata![index].answer}",
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 21,
                          fontWeight: FontWeight.w400)),
                ],
              ),
            );
          }),
        )));
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';
import 'package:school_management_system/widget/teacher/Assignments/file_not_submitted_students_list_card.dart';
import '../../../../widget/teacher/Assignments/file_submitted_students_list_card.dart';

class TeacherSeeAllNotSubmittedStudentsFileAssignment extends StatelessWidget {
  String wclass;
  String section;
  String assID;
  String questionFile;
  List submittedStudentList;
  List notS1ubmittedStudentList;
  TeacherSeeAllNotSubmittedStudentsFileAssignment({
    super.key,
    required this.assID,
    required this.wclass,
    required this.section,
    required this.questionFile,
    required this.submittedStudentList,
    required this.notS1ubmittedStudentList,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.19,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: appbar(
              "assets/flaticon/_assignments.png", "Assignments", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: ListView.builder(
        itemCount: notS1ubmittedStudentList.length,
        itemBuilder: (context, index) {
          return TeacherFileNotSubmittedAssignmentCard(
            roll: notS1ubmittedStudentList[index].rollNumber.toString(),

            name: notS1ubmittedStudentList[index].name.toString(),

            questionPaper: questionFile, // Use the formatted date
          );
        },
      ),
    );
  }
}

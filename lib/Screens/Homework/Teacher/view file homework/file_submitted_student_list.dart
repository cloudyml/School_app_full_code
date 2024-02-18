import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';
import '../../../../widget/teacher/Assignments/file_submitted_students_list_card.dart';

class TeacherSeeAllSubmittedStudentsAssignment extends StatelessWidget {
  String wclass;
  String section;
  String assID;
  String questionFile;
  List submittedStudentList;
  List notS1ubmittedStudentList;
  TeacherSeeAllSubmittedStudentsAssignment({
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
        body: submittedStudentList.isNotEmpty
            ? ListView.builder(
                itemCount: submittedStudentList.length,
                itemBuilder: (context, index) {
                  String formattedDate = DateFormat('dd-MM-yy').format(
                      DateTime.parse(
                          submittedStudentList[index].submitDate.toString()));
                  return TeacherSubmittedAssignmentCard(
                    file: submittedStudentList[index]
                            .uploadedImage
                            ?.link
                            .toString() ??
                        "",

                    roll: submittedStudentList[index].rollNumber.toString(),

                    name: submittedStudentList[index].studentName.toString(),
                    fileLink: submittedStudentList[index]
                            .uploadedImage
                            ?.link
                            .toString() ??
                        "",
                    SubmitDate: formattedDate,
                    questionPaper: questionFile, // Use the formatted date
                  );
                },
              )
            : const Center(child: Text("No-one has submitted yet")));
  }
}

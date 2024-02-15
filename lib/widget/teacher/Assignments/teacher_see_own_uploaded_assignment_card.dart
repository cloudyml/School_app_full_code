import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import '../../../Screens/Homework/Teacher/view file homework/file_not_submitted_student_list.dart';
import '../../../Screens/Homework/Teacher/view file homework/file_submitted_student_list.dart';
import '../../../Screens/Homework/Teacher/view text homework/text_submitted_student_list.dart';
import '../../../Screens/Homework/Teacher/view text homework/view_text_homework_not_submitted_student_list.dart';
import '../../../Services/Url_launcher.dart/method.dart';

class TeacherSeeOwnUploadedAssignmentCard extends StatelessWidget {
  final String subject;
  final String topic;
  final String givenDate;
  final String submitDate;
  final String assignmentID;
  final String section;
  final String wclass;
  final String questionFile;
  List submittedStudentList;
  List notSubmittedStudentList;

  TeacherSeeOwnUploadedAssignmentCard({
    super.key,
    required this.subject,
    required this.topic,
    required this.givenDate,
    required this.submitDate,
    required this.assignmentID,
    required this.section,
    required this.wclass,
    required this.questionFile,
    required this.submittedStudentList,
    required this.notSubmittedStudentList,
  });

  @override
  Widget build(BuildContext context) {
    LaunceToWeb Launceweb = LaunceToWeb();
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
              spreadRadius: 2,
              offset: Offset(2, 8))
        ],
        color: Colors.white,
        border: Border.all(color: deepBlue),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Given Date : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold)),
                    Text(givenDate,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text("Submit Date : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold)),
                    Text(submitDate,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Text(
                "Subject : ",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(5, 5, 4, 1),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                subject,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              const Text(
                "Topic : ",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(5, 5, 4, 1),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                topic,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyElevatedButton(
                width: MediaQuery.of(context).size.width * 0.65,
                onPressed: () {
                  if (questionFile == "") {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TextSubmittedStudentList(
                        assID: assignmentID,
                        section: section,
                        wclass: wclass,
                        submittedStudentList: submittedStudentList,
                        notSubmittedStudentList: notSubmittedStudentList,
                      ),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          TeacherSeeAllSubmittedStudentsAssignment(
                        assID: assignmentID,
                        section: section,
                        wclass: wclass,
                        questionFile: questionFile,
                        submittedStudentList: submittedStudentList,
                        notS1ubmittedStudentList: notSubmittedStudentList,
                      ),
                    ));
                  }
                },
                child: const Text(
                  'View Submitted Students',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MyElevatedButton(
                width: MediaQuery.of(context).size.width * 0.65,
                onPressed: () {
                  if (questionFile == "") {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => TextNotSubmittedStudentList(
                        assID: assignmentID,
                        section: section,
                        wclass: wclass,
                        notSubmittedStudentList: notSubmittedStudentList,
                      ),
                    ));
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            TeacherSeeAllNotSubmittedStudentsFileAssignment(
                          assID: assignmentID,
                          section: section,
                          wclass: wclass,
                          questionFile: questionFile,
                          submittedStudentList: submittedStudentList,
                          notS1ubmittedStudentList: notSubmittedStudentList,
                        ),
                      ),
                    );
                  }
                },
                child: const Text(
                  'View Not Submitted Students',
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:school_management_system/Models/Student/student_text_assignmrnt_model.dart';
import 'package:school_management_system/Screens/Homework/Student/show_detail_homework_screen.dart';
import 'package:school_management_system/Services/api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';
import 'package:school_management_system/widget/student/Assignments/pending_assignment_card.dart';

import '../../../Models/Student/assignment_view_model.dart';
import '../../../Services/Url_launcher.dart/method.dart';

class PendingAssignmentText extends StatelessWidget {
  PendingAssignmentText({super.key, required this.type, required this.form});
  String type;
  String form;

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
        body: FutureBuilder<TextAssignmentStudentModel>(
          future: ApiServices.studentSeeAssignmentText(type, form),
          builder: (BuildContext context,
              AsyncSnapshot<TextAssignmentStudentModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error.."));
            } else if (!snapshot.hasData ||
                snapshot.data?.data?.length == null ||
                snapshot.data?.data?.length == 0) {
              return const Center(
                child: Text("No Assignment available"),
              ); // Handle the case where there is no data
            } else {
              // todo THERE IS WRONG NULL CHECK ABOVE FOR TEXT ASSIGNMENTS
              TextAssignmentStudentModel studentAssignment = snapshot.data!;

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children:
                        List.generate(studentAssignment.data!.length, (index) {
                      String formattedGivenDate = DateFormat('dd-MM-yy').format(
                        DateTime.parse(
                          studentAssignment.data![index].givenDate.toString(),
                        ),
                      );
                      String formattedSubmitDate =
                          DateFormat('dd-MM-yy').format(
                        DateTime.parse(
                          studentAssignment.data![index].lastDateOfSubmit
                              .toString(),
                        ),
                      );

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  blurRadius: 5,
                                  color: Colors.grey,
                                  spreadRadius: 2,
                                  offset: Offset(2, 8))
                            ],
                            border: Border.all(color: deepBlue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Text("Given Date : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold)),
                                  Text(formattedGivenDate,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Submit Date : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold)),
                                  Text(formattedSubmitDate,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Subject : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      studentAssignment.data![index].subject
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              Row(
                                children: [
                                  const Text("Topic : ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color.fromRGBO(0, 0, 0, 1),
                                          fontWeight: FontWeight.bold)),
                                  Text(
                                      studentAssignment.data![index].topic
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              MyElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShowDetailHomeworkScreen(
                                        listOfquestions: studentAssignment
                                                .data![index].textAssignmentList
                                            as List<dynamic>,
                                      ),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Submit',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
              );
            }
          },
        ));
  }
}

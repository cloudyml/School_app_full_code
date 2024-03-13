import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class TextNotSubmittedStudentList extends StatelessWidget {
  final String assID;
  final String section;
  final String wclass;
  final List notSubmittedStudentList;

  const TextNotSubmittedStudentList({
    super.key,
    required this.assID,
    required this.section,
    required this.wclass,
    required this.notSubmittedStudentList,
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
      body: notSubmittedStudentList.length != 0
          ? ListView.builder(
              itemCount: notSubmittedStudentList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: deepBlue),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 5,
                              blurStyle: BlurStyle.normal,
                              color: Colors.grey,
                              offset: Offset(3, 3),
                              spreadRadius: 1)
                        ]),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "Student Name : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${notSubmittedStudentList[index].name.toString()}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "Student Roll : ",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "${notSubmittedStudentList[index].rollNumber.toString()}",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(child: Text("Everyone Has Submited the assignment")),
    );
  }
}

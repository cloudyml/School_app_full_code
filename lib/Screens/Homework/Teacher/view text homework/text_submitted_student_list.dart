import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class TextSubmittedStudentList extends StatelessWidget {
  final String assID;
  final String section;
  final String wclass;
  final List submittedStudentList;
  final List notSubmittedStudentList;

  const TextSubmittedStudentList({
    super.key,
    required this.assID,
    required this.section,
    required this.wclass,
    required this.submittedStudentList,
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
        body: submittedStudentList.length != 0
            ? ListView.builder(
                itemCount: submittedStudentList.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ExpansionTile(
                        leading: Text(
                          (index + 1).toString() + ".",
                          style: const TextStyle(fontSize: 20),
                        ),
                        trailing: const Icon(
                          Icons.visibility,
                          size: 22,
                        ),
                        title: Column(
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Name : ",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.height * 0.26,
                                  child: Text(
                                    submittedStudentList[index]
                                        .studentName
                                        .toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.grey),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Roll : ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  submittedStudentList[index]
                                      .rollNumber
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey),
                                ),
                              ],
                            ),
                          ],
                        ),
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 1, right: 1),
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: deepBlue)),
                                height:
                                    MediaQuery.of(context).size.height * 0.5,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: submittedStudentList[index]
                                      .textAssignmentList
                                      .length,
                                  itemBuilder: (context, index1) {
                                    return Padding(
                                      padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.height *
                                                0.07,
                                        top: 20,
                                        right:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Question :",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                submittedStudentList[index]
                                                    .textAssignmentList[index1]
                                                    .question,
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              )
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Answer :",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(submittedStudentList[index]
                                                      .textAssignmentList[
                                                          index1]
                                                      .answer ??
                                                  ""),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      //  Divider(),
                    ],
                  );
                },
              )
            : const Center(child: Text("Noone has submitted the assignment")));
  }
}

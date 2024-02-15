import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:school_management_system/Models/Teacher/Result/Post%20Result/post_result_data_model.dart';
import 'package:school_management_system/Models/Teacher/Result/Get%20models/get_students_list_response_model.dart';
import 'package:school_management_system/Screens/Result/Teacher/Upload/get_students_list_and_upload_result.dart';

class TestResultsTable extends StatefulWidget {
  TestResultsTable({
    super.key,
    // required this.comment,

    required this.rollNumber,
    required this.marksObained,
    required this.studentName,
    required this.index,
    // required this.gradingCriteria,
    // required this.resultData
  });
  String studentName;
  String rollNumber;
  String marksObained;
  // List resultData;

  //String comment;
  int index;
  // List<GradingCriterion> gradingCriteria;
  @override
  State<TestResultsTable> createState() => _TestResultsTableState();
}

class _TestResultsTableState extends State<TestResultsTable> {
  int showmarksObained = 0;
  String finalGrade = "";
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: Table(
          border: TableBorder.all(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(2.r),
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.5), // Subject
            1: FlexColumnWidth(1), // Marks
            2: FlexColumnWidth(1), // marksObained
            3: FlexColumnWidth(2), // Comment
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: widget.index % 2 == 0 ? Colors.white : Colors.grey[100],
                border: Border.all(),
              ),
              children: [
                SizedBox(
                    height: 0.2.sh,
                    child: Center(child: Text(widget.studentName))),
                SizedBox(
                    height: 0.2.sh,
                    child: Center(child: Text(widget.rollNumber))),
                SizedBox(
                    height: 0.2.sh,
                    child: Center(
                        child: TextFormField(
                      initialValue: widget.marksObained,
                      onChanged: (value) {
                        Future.delayed(
                          Duration(seconds: 1),
                          () {
                            setState(() {
                              showmarksObained = int.parse(value);
                            });

                            // for (int i = 0;
                            //     i <= widget.gradingCriteria.length;
                            //     i++) {
                            //   if (showmarksObained >=
                            //           widget
                            //               .gradingCriteria[i].marksRange![0] &&
                            //       showmarksObained <=
                            //           widget
                            //               .gradingCriteria[i].marksRange![1]) {
                            //     setState(() {
                            //       finalGrade = widget.gradingCriteria[i].grades
                            //           .toString();
                            //     });
                            //   }
                            // }
                          },
                        );
                        // setState(() {
                        //   widget
                        //       .resultData[widget.index]
                        //       .studentList?[widget.index]
                        //       .marks = showmarksObained;
                        // });
                        // log(widget.resultData[widget.index]
                        //     .studentList![widget.index].marks
                        //     .toString());
                      },
                    ))),
                SizedBox(
                    height: 0.2.sh, child: Center(child: Text(finalGrade))),
              ],
            ),
          ]),
    );
  }
}

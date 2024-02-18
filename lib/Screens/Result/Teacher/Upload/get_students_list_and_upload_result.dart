// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:school_management_system/Models/Teacher/Result/new%20ui/Post%20Result/post_result_data_model.dart';
// import 'package:school_management_system/Models/Teacher/Result/new%20ui/get_students_list_response_model.dart';
// import 'package:school_management_system/Screens/Result/Teacher/Upload/New%20UI/result_table.dart';
// import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
// import 'package:school_management_system/constants/style.dart';
// import 'package:school_management_system/widget/Button/rectangle_elevatedbutton_card.dart';
// import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

// String grade = "A";
// String comment = "Good";
// int studentCount = 0;

// class ViewStudentsListForEnterResult extends StatefulWidget {
//   final String selectedClass;
//   final String selectedSection;
//   final String selectedExamtypes;
//   ViewStudentsListForEnterResult(
//       {super.key,
//       required this.selectedClass,
//       required this.selectedSection,
//       required this.selectedExamtypes});

//   @override
//   _ViewStudentsListForEnterResultState createState() =>
//       _ViewStudentsListForEnterResultState();
// }

// class _ViewStudentsListForEnterResultState
//     extends State<ViewStudentsListForEnterResult> {
//   List resultData = [];
//   dynamic numberOfStudents = 0;

//   String selectedSubject = 'Subject';
//   GetStudentListForResultResponseModel studentListFuture =
//       GetStudentListForResultResponseModel();

//   setDataInto() async {
//     studentListFuture =
//         await TeacherApiServices.StudentListForResult().whenComplete(() {
//       Future.delayed(Duration(seconds: 3), () {
//         for (int i = 0; i < studentListFuture.data!.studentList!.length; i++) {
//           resultData[i] = "";
//           log("index------->>" + i.toString());

//           //  log("Result Data" + resultData[i].studentList![0].name.toString());
//         }
//         log("Result Data" + resultData.length.toString());
//       });

//       // setState(() {
//       //   numberOfStudents = studentListFuture.data?.studentList?.length;
//       // });
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     setDataInto();
//     log("Cunt=====" +
//         "${studentListFuture.data?.studentList?.length.toString()}");
//   }

//   @override
//   Widget build(BuildContext context) {
//     // List<PostResultModel> answerControllers =
//     //     studentListFuture..map((_) => PostResultModel()).toList();
//     var height = MediaQuery.of(context).size.height;
//     double containerSize = MediaQuery.of(context).size.width / 8;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(
//           MediaQuery.of(context).size.height * 0.3,
//         ),
//         child: DecorativeAppBar(
//           barHeight: MediaQuery.of(context).size.height * 0.24,
//           barPad: MediaQuery.of(context).size.height * 0.20,
//           radii: 30,
//           background: Colors.white,
//           gradient1: lightBlue,
//           gradient2: deepBlue,
//           extra: Container(
//             child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//               Padding(
//                 padding:
//                     EdgeInsets.only(top: height * 0.07, left: height * 0.03),
//                 child: InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(
//                     Icons.arrow_back,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding:
//                     EdgeInsets.only(top: height * 0.055, left: height * 0.02),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: height * 0.2,
//                       height: height * 0.1,
//                       child: Image.asset("assets/flaticon/result4.png"),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 10.0),
//                       child: SizedBox(
//                         width: height * 0.005,
//                         child: Text("",
//                             style: GoogleFonts.inter(
//                                 color: Colors.white,
//                                 letterSpacing: 1.0,
//                                 fontSize: height * 0.03,
//                                 fontWeight: FontWeight.w500)),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
//           child: Column(
//             children: [
//               Table(
//                 border: TableBorder.all(
//                   color: Colors.grey,
//                   borderRadius: BorderRadius.circular(2.r),
//                 ),
//                 columnWidths: const <int, TableColumnWidth>{
//                   0: FlexColumnWidth(1.5), // Subject
//                   1: FlexColumnWidth(1), // Marks
//                   2: FlexColumnWidth(1.5), // Grade
//                   3: FlexColumnWidth(1), // Comment
//                 },
//                 children: [
//                   TableRow(
//                     // decoration: BoxDecoration(
//                     //   gradient: Style.primaryGradient
//                     // ),
//                     children: [
//                       SizedBox(
//                           height: 0.05.sh,
//                           child: const Center(child: Text('Name'))),
//                       SizedBox(
//                           height: 0.05.sh,
//                           child: const Center(child: Text('Roll'))),
//                       SizedBox(
//                           height: 0.06.sh,
//                           child: DropdownButtonFormField<String>(
//                             //value: studentList?.data?.subjects!.first,
//                             alignment: AlignmentDirectional.center,
//                             onChanged: (value) {
//                               setState(() {
//                                 selectedSubject = value!;
//                               });
//                               log("Subject==" + selectedSubject);
//                             },
//                             items: studentListFuture.data?.subjects
//                                 ?.map<DropdownMenuItem<String>>((String value) {
//                               return DropdownMenuItem<String>(
//                                 alignment: AlignmentDirectional.center,
//                                 value: value,
//                                 child: Center(
//                                   child: Text(
//                                     value.substring(0, 1).toUpperCase() +
//                                         value.substring(1),
//                                   ),
//                                 ),
//                               );
//                             }).toList(),
//                             decoration: const InputDecoration(
//                               hintText: "Subject",
//                               focusedBorder: UnderlineInputBorder(),
//                             ),
//                           )),
//                       SizedBox(
//                           height: 0.05.sh,
//                           child: const Center(child: Text('Grade'))),
//                     ],
//                   )
//                 ],
//               ),
//               Column(
//                   children: studentListFuture.data?.studentList?.length == null
//                       ? []
//                       : List.generate(
//                           studentListFuture.data!.studentList!.length, (index) {
//                           return TestResultsTable(
//                             // comment: ,
//                             marksObained: "",
//                             rollNumber: studentListFuture
//                                 .data!.studentList![index].rollNumber
//                                 .toString(),
//                             studentName: studentListFuture
//                                 .data!.studentList![index].name
//                                 .toString(),
//                             index: index,
//                             // gradingCriteria: studentListFuture
//                             //     .data!
//                             //     .defaultData!
//                             //     .gradingCriteria as List<GradingCriterion>,
//                             // resultData: resultData,
//                           );
//                         })),
//             ],
//           ),
//         ),
//       ),
//       persistentFooterButtons: [
//         RecElevatedButton(
//           onPressed: () {
//             // if (studentCount != resultData.length) {
//             //   _showSnackbar(context, "Please fill all the marks");
//             // } else {
//             //   TeacherApiServices.uploadResultAllStudents(
//             //     resultData,
//             //     widget.selectedClass,
//             //     widget.selectedSection,
//             //     widget.selectedExamtypes,
//             //     selectedSubject,
//             //   ).then((value) {
//             //     if (value == true) {
//             //       _showSuccessSnackbar(
//             //           context, "Result submitted successfully");
//             //       Navigator.pop(context);
//             //     } else {
//             //       _showSnackbar(context,
//             //           "Failed to submit result or Result has submitted for the subject");
//             //     }
//             //   });
//             // }
//           },
//           child: const Text(
//             "SUBMIT",
//             style: TextStyle(color: Colors.white, fontSize: 25),
//           ),
//         )
//       ],
//     );
//   }

//   void _showSuccessSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.green,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }

//   void _showSnackbar(BuildContext context, String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(
//         content: Text(message),
//         backgroundColor: Colors.red,
//         duration: Duration(seconds: 2),
//       ),
//     );
//   }
// }

//..................Above one is Harsh wala experiment...............................

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Teacher/Result/Get%20models/get_students_list_response_model.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/rectangle_elevatedbutton_card.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

String grade = "A";
String comment = "Good";
int studentCount = 0;

class ViewStudentsListForEnterResult extends StatefulWidget {
  final String selectedClass;
  final String selectedSection;
  final String selectedExamtypes;
  ViewStudentsListForEnterResult(
      {super.key,
      required this.selectedClass,
      required this.selectedSection,
      required this.selectedExamtypes});

  @override
  _ViewStudentsListForEnterResultState createState() =>
      _ViewStudentsListForEnterResultState();
}

class _ViewStudentsListForEnterResultState
    extends State<ViewStudentsListForEnterResult> {
  List<Map<String, dynamic>?> marks = [];
  String selectedSubject = 'Subject';
  late Future<GetStudentListForResultResponseModel> _studentListFuture;

  @override
  void initState() {
    super.initState();
    _studentListFuture = TeacherApiServices.StudentListForResult(
        widget.selectedClass, widget.selectedSection);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    double containerSize = MediaQuery.of(context).size.width / 8;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.3,
        ),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.20,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.07, left: height * 0.03),
                child: InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.only(top: height * 0.055, left: height * 0.02),
                child: Row(
                  children: [
                    Container(
                      width: height * 0.2,
                      height: height * 0.1,
                      child: Image.asset("assets/flaticon/result4.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: height * 0.005,
                        child: Text("",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
      body: Column(
        children: [
          FutureBuilder<GetStudentListForResultResponseModel>(
            future: _studentListFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: Container());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (snapshot.data!.data == null) {
                return const Text("");
              }
              GetStudentListForResultResponseModel? studentList = snapshot.data;

              return Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: const Color.fromARGB(255, 186, 185, 185),
                        ),
                        height: containerSize,
                        width: containerSize,
                        child: const Center(
                          child: Text(
                            "Name",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 186, 185, 185)),
                        height: containerSize,
                        width: containerSize,
                        child: const Center(
                          child: Text(
                            "Roll",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: const Color.fromARGB(255, 186, 185, 185)),
                        child: DropdownButtonFormField<String>(
                          //value: studentList?.data?.subjects!.first,
                          onChanged: (value) {
                            setState(() {
                              selectedSubject = value!;
                            });
                            log("Subject==" + selectedSubject);
                          },
                          items: studentList?.data?.subjects
                              ?.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  value.substring(0, 1).toUpperCase() +
                                      value.substring(1),
                                ),
                              ),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            hintText: "Subject",
                            focusedBorder: UnderlineInputBorder(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            child: FutureBuilder<GetStudentListForResultResponseModel>(
              future: _studentListFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.data!.data == null) {
                  return Center(child: Text("No data Found"));
                }
                GetStudentListForResultResponseModel? studentList =
                    snapshot.data;
                studentCount = studentList!.data!.studentList!.length;
                return ListView.builder(
                  itemCount: studentList!.data!.studentList!.length,
                  itemBuilder: (context, index) {
                    return ResultData(
                      onMarkChanged: (int? mark) {
                        if (marks.length <= index) {
                          marks.add({
                            "_id": studentList.data!.studentList![index].id
                                .toString(),
                            "rollNumber": studentList
                                .data!.studentList![index].rollNumber
                                .toString(),
                            "name": studentList.data!.studentList![index].name
                                .toString(),
                            "subject": selectedSubject,
                            "marks": mark,
                            "outOffMarks": studentList
                                .data!.defaultData!.marksList!.outOffMarks
                                .toString(),
                            "passingMarks": studentList
                                .data!.defaultData!.marksList!.passingMarks
                                .toString(),
                            "grades": grade,
                            "comments": comment,
                          });
                        } else {
                          marks[index] = {
                            "_id": studentList.data!.studentList![index].id
                                .toString(),
                            "rollNumber": studentList
                                .data!.studentList![index].rollNumber
                                .toString(),
                            "name": studentList.data!.studentList![index].name
                                .toString(),
                            "subject": selectedSubject,
                            "marks": mark,
                            "outOffMarks": studentList
                                .data!.defaultData!.marksList!.outOffMarks
                                .toString(),
                            "passingMarks": studentList
                                .data!.defaultData!.marksList!.passingMarks
                                .toString(),
                            "grades": grade,
                            "comments": comment,
                          };
                        }

                        for (var i = 0;
                            i <
                                studentList
                                    .data!.defaultData!.gradingCriteria!.length;
                            i++) {
                          if (marks[index]!['marks'] >=
                                  studentList.data!.defaultData!
                                      .gradingCriteria![i].marksRange![0] &&
                              marks[index]!['marks'] <=
                                  studentList.data!.defaultData!
                                      .gradingCriteria![i].marksRange![1]) {
                            grade = studentList.data?.defaultData!
                                    .gradingCriteria?[i].grades
                                    .toString() ??
                                "Default";

                            comment = studentList.data?.defaultData!
                                    .gradingCriteria?[i].comments
                                    .toString() ??
                                "Good";
                          }

                          log(grade);

                          marks[index] = {
                            "_id": studentList.data!.studentList![index].id
                                .toString(),
                            "rollNumber": studentList
                                .data!.studentList![index].rollNumber
                                .toString(),
                            "name": studentList.data!.studentList![index].name
                                .toString(),
                            "subject": selectedSubject,
                            "marks": mark,
                            "outOffMarks": studentList
                                .data!.defaultData!.marksList!.outOffMarks
                                .toString(),
                            "passingMarks": studentList
                                .data!.defaultData!.marksList!.passingMarks
                                .toString(),
                            "grades": grade,
                            "comments": comment,
                          };
                        }
                      },
                      name:
                          studentList.data!.studentList![index].name.toString(),
                      roll: studentList.data!.studentList![index].rollNumber
                          .toString(),
                      grade: grade,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        RecElevatedButton(
          onPressed: () {
            if (studentCount != marks.length) {
              _showSnackbar(context, "Please fill all the marks");
            } else {
              TeacherApiServices.uploadResultAllStudents(
                marks,
                widget.selectedClass,
                widget.selectedSection,
                widget.selectedExamtypes,
                selectedSubject,
              ).then((value) {
                if (value == true) {
                  _showSuccessSnackbar(
                      context, "Result submitted successfully");
                  Navigator.pop(context);
                } else {
                  _showSnackbar(context,
                      "Failed to submit result or Result has submitted for the subject");
                }
              });
            }
          },
          child: const Text(
            "SUBMIT",
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        )
      ],
    );
  }

  void _showSuccessSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class ResultData extends StatelessWidget {
  final Function(int?)? onMarkChanged;
  final String name;
  final String roll;
  final String grade;

  ResultData({
    this.onMarkChanged,
    required this.name,
    required this.roll,
    required this.grade,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(), color: Colors.white),
              height: 50,
              child: Center(child: Text(name)),
            ),
          ),
          Expanded(
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(), color: Colors.white),
              height: 50,
              child: Center(child: Text(roll)),
            ),
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration:
                  BoxDecoration(border: Border.all(), color: Colors.white),
              child: Center(
                child: TextField(
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "Marks",
                    contentPadding: EdgeInsets.all(10),
                  ),
                  onChanged: (value) {
                    if (onMarkChanged != null) {
                      onMarkChanged!(int.tryParse(value));
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

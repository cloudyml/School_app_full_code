// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:school_management_system/Models/Teacher/Result/Get%20models/get_students_list_response_model.dart';
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
//   List<Map<String, dynamic>?> marks = [];
//   String selectedSubject = 'Subject';

//   late Future<GetStudentListForResultResponseModel> _studentListFuture;

//   @override
//   void initState() {
//     super.initState();
//     _studentListFuture = TeacherApiServices.StudentListForResult(
//         widget.selectedClass, widget.selectedSection);
//   }

//   @override
//   Widget build(BuildContext context) {
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
//       body: Column(
//         children: [
//           FutureBuilder<GetStudentListForResultResponseModel>(
//             future: _studentListFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return Center(child: Container());
//               }

//               if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               }
//               if (snapshot.data!.data == null) {
//                 return const Text("");
//               }
//               GetStudentListForResultResponseModel? studentList = snapshot.data;

//               return Padding(
//                 padding: const EdgeInsets.only(left: 8, right: 8),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                           border: Border.all(),
//                           color: const Color.fromARGB(255, 186, 185, 185),
//                         ),
//                         height: containerSize,
//                         width: containerSize,
//                         child: const Center(
//                           child: Text(
//                             "Name",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(),
//                             color: const Color.fromARGB(255, 186, 185, 185)),
//                         height: containerSize,
//                         width: containerSize,
//                         child: const Center(
//                           child: Text(
//                             "Roll",
//                             style: TextStyle(color: Colors.black, fontSize: 20),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         decoration: BoxDecoration(
//                             border: Border.all(),
//                             color: const Color.fromARGB(255, 186, 185, 185)),
//                         child: DropdownButtonFormField<String>(
//                           //value: studentList?.data?.subjects!.first,
//                           onChanged: (value) {
//                             setState(() {
//                               selectedSubject = value!;
//                             });
//                             log("Subject==" + selectedSubject);
//                           },
//                           items: studentList?.data?.subjects
//                               ?.map<DropdownMenuItem<String>>((String value) {
//                             return DropdownMenuItem<String>(
//                               value: value,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 10),
//                                 child: Text(
//                                   value.substring(0, 1).toUpperCase() +
//                                       value.substring(1),
//                                 ),
//                               ),
//                             );
//                           }).toList(),
//                           decoration: const InputDecoration(
//                             hintText: "Subject",
//                             focusedBorder: UnderlineInputBorder(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//           Expanded(
//             child: FutureBuilder<GetStudentListForResultResponseModel>(
//               future: _studentListFuture,
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (snapshot.data!.data == null) {
//                   return Center(child: Text("No data Found"));
//                 }
//                 GetStudentListForResultResponseModel? studentList =
//                     snapshot.data;
//                 studentCount = studentList!.data!.studentList!.length;
//                 return ListView.builder(
//                   itemCount: studentList!.data!.studentList!.length,
//                   itemBuilder: (context, index) {
//                     return ResultData(
//                       onMarkChanged: (int? mark) {
//                         if (marks.length <= index) {
//                           marks.add({
//                             "_id": studentList.data!.studentList![index].id
//                                 .toString(),
//                             "rollNumber": studentList
//                                 .data!.studentList![index].rollNumber
//                                 .toString(),
//                             "name": studentList.data!.studentList![index].name
//                                 .toString(),
//                             "subject": selectedSubject,
//                             "marks": mark,
//                             "outOffMarks": studentList
//                                 .data!.defaultData!.marksList!.outOffMarks
//                                 .toString(),
//                             "passingMarks": studentList
//                                 .data!.defaultData!.marksList!.passingMarks
//                                 .toString(),
//                             "grades": grade,
//                             "comments": comment,
//                           });
//                         } else {
//                           marks[index] = {
//                             "_id": studentList.data!.studentList![index].id
//                                 .toString(),
//                             "rollNumber": studentList
//                                 .data!.studentList![index].rollNumber
//                                 .toString(),
//                             "name": studentList.data!.studentList![index].name
//                                 .toString(),
//                             "subject": selectedSubject,
//                             "marks": mark,
//                             "outOffMarks": studentList
//                                 .data!.defaultData!.marksList!.outOffMarks
//                                 .toString(),
//                             "passingMarks": studentList
//                                 .data!.defaultData!.marksList!.passingMarks
//                                 .toString(),
//                             "grades": grade,
//                             "comments": comment,
//                           };
//                         }

//                         for (var i = 0;
//                             i <
//                                 studentList
//                                     .data!.defaultData!.gradingCriteria!.length;
//                             i++) {
//                           if (marks[index]!['marks'] >=
//                                   studentList.data!.defaultData!
//                                       .gradingCriteria![i].marksRange![0] &&
//                               marks[index]!['marks'] <=
//                                   studentList.data!.defaultData!
//                                       .gradingCriteria![i].marksRange![1]) {
//                             grade = studentList.data?.defaultData!
//                                     .gradingCriteria?[i].grades
//                                     .toString() ??
//                                 "Default";

//                             comment = studentList.data?.defaultData!
//                                     .gradingCriteria?[i].comments
//                                     .toString() ??
//                                 "Good";
//                           }

//                           log(grade);

//                           marks[index] = {
//                             "_id": studentList.data!.studentList![index].id
//                                 .toString(),
//                             "rollNumber": studentList
//                                 .data!.studentList![index].rollNumber
//                                 .toString(),
//                             "name": studentList.data!.studentList![index].name
//                                 .toString(),
//                             "subject": selectedSubject,
//                             "marks": mark,
//                             "outOffMarks": studentList
//                                 .data!.defaultData!.marksList!.outOffMarks
//                                 .toString(),
//                             "passingMarks": studentList
//                                 .data!.defaultData!.marksList!.passingMarks
//                                 .toString(),
//                             "grades": grade,
//                             "comments": comment,
//                           };
//                         }
//                       },
//                       name:
//                           studentList.data!.studentList![index].name.toString(),
//                       roll: studentList.data!.studentList![index].rollNumber
//                           .toString(),
//                       grade: grade,
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//       persistentFooterButtons: [
//         RecElevatedButton(
//           onPressed: () {
//             if (studentCount != marks.length) {
//               _showSnackbar(context, "Please fill all the marks");
//             } else {
//               TeacherApiServices.uploadResultAllStudents(
//                 marks,
//                 widget.selectedClass,
//                 widget.selectedSection,
//                 widget.selectedExamtypes,
//                 selectedSubject,
//               ).then((value) {
//                 if (value == true) {
//                   _showSuccessSnackbar(
//                       context, "Result submitted successfully");
//                   Navigator.pop(context);
//                 } else {
//                   _showSnackbar(context,
//                       "Failed to submit result or Result has submitted for the subject");
//                 }
//               });
//             }
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

// class ResultData extends StatelessWidget {
//   final Function(int?)? onMarkChanged;
//   final String name;
//   final String roll;
//   final String grade;

//   ResultData({
//     this.onMarkChanged,
//     required this.name,
//     required this.roll,
//     required this.grade,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 8, right: 8),
//       child: Row(
//         children: [
//           Expanded(
//             child: Container(
//               decoration:
//                   BoxDecoration(border: Border.all(), color: Colors.white),
//               height: 50,
//               child: Center(child: Text(name)),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               decoration:
//                   BoxDecoration(border: Border.all(), color: Colors.white),
//               height: 50,
//               child: Center(child: Text(roll)),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               height: 50,
//               decoration:
//                   BoxDecoration(border: Border.all(), color: Colors.white),
//               child: Center(
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//                   decoration: const InputDecoration(
//                     hintText: "Marks",
//                     contentPadding: EdgeInsets.all(10),
//                   ),
//                   onChanged: (value) {
//                     if (onMarkChanged != null) {
//                       onMarkChanged!(int.tryParse(value));
//                     }
//                   },
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//............... Above is working, used hand written JSON, below one is using POST Model to Upload result........

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Teacher/Result/Get%20models/get_students_list_response_model.dart';
import 'package:school_management_system/Models/Teacher/Result/Post%20Result/result_post_model.dart'
    as postModel;
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
  List<postModel.StudentList> marks = [];
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
                  return const Center(child: Text("No data Found"));
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
                          marks.addAll({
                            postModel.StudentList(
                              id: studentList.data!.studentList![index].id
                                  .toString(),
                              rollNumber: studentList
                                  .data!.studentList![index].rollNumber,
                              name: studentList.data!.studentList![index].name
                                  .toString(),
                              subject: selectedSubject,
                              marks: mark,
                              outOffMarks: studentList
                                  .data!.defaultData!.marksList!.outOffMarks,
                              passingMarks: studentList
                                  .data!.defaultData!.marksList!.passingMarks,
                              grades: grade,
                              comments: comment,
                            ),
                          });
                        } else {
                          marks[index] = postModel.StudentList(
                            id: studentList.data!.studentList![index].id
                                .toString(),
                            rollNumber: studentList
                                .data!.studentList![index].rollNumber,
                            name: studentList.data!.studentList![index].name
                                .toString(),
                            subject: selectedSubject,
                            marks: mark,
                            outOffMarks: studentList
                                .data!.defaultData!.marksList!.outOffMarks,
                            passingMarks: studentList
                                .data!.defaultData!.marksList!.passingMarks,
                            grades: grade,
                            comments: comment,
                          );
                        }

                        for (var i = 0;
                            i <
                                studentList
                                    .data!.defaultData!.gradingCriteria!.length;
                            i++) {
                          if (marks[index].marks! >=
                                  studentList.data!.defaultData!
                                      .gradingCriteria![i].marksRange![0] &&
                              marks[index].marks! <=
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

                          marks[index] = postModel.StudentList(
                            id: studentList.data!.studentList![index].id
                                .toString(),
                            rollNumber: studentList
                                .data!.studentList![index].rollNumber,
                            name: studentList.data!.studentList![index].name
                                .toString(),
                            subject: selectedSubject,
                            marks: mark,
                            outOffMarks: studentList
                                .data!.defaultData!.marksList!.outOffMarks,
                            passingMarks: studentList
                                .data!.defaultData!.marksList!.passingMarks,
                            grades: grade,
                            comments: comment,
                          );
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
              final postModel.PostresultSubmitModel postresultSubmitModel =
                  postModel.PostresultSubmitModel();
              postresultSubmitModel.studentList = marks;

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
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}

class ResultData extends StatelessWidget {
  final Function(int?)? onMarkChanged;
  final String name;
  final String roll;
  final String grade;

  const ResultData({
    super.key,
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

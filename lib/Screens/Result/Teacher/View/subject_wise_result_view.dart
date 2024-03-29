// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:school_management_system/Screens/Dashboard.dart';
// import '../../../../Models/Teacher/Result/class_wise_result_response_model.dart';
// import '../../../../Services/api_services/api_services.dart';
// import '../../../../constants/style.dart';
// import '../../../../widget/appBar/decorative_apbar_widget.dart';

// class ClassWiseResultView extends StatefulWidget {
//   final String selectedClass;
//   final String testType;
//   const ClassWiseResultView(
//       {Key? key, required this.selectedClass, required this.testType});

//   @override
//   State<ClassWiseResultView> createState() => _DayRoutineState();
// }

// class _DayRoutineState extends State<ClassWiseResultView> {
//   List<bool> isExpandedList = List.filled(6, false);

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     double containerSize = MediaQuery.of(context).size.width / 8;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: PreferredSize(
//           preferredSize: Size.fromHeight(
//             MediaQuery.of(context).size.height * 0.3,
//           ),
//           child: DecorativeAppBar(
//             barHeight: MediaQuery.of(context).size.height * 0.24,
//             barPad: MediaQuery.of(context).size.height * 0.20,
//             radii: 30,
//             background: Colors.white,
//             gradient1: lightBlue,
//             gradient2: deepBlue,
//             extra: Container(
//               child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
//                 Padding(
//                   padding:
//                       EdgeInsets.only(top: height * 0.07, left: height * 0.03),
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: const Icon(
//                       Icons.arrow_back,
//                       color: Colors.white,
//                       size: 30,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding:
//                       EdgeInsets.only(top: height * 0.055, left: height * 0.02),
//                   child: Row(
//                     children: [
//                       Container(
//                         width: height * 0.2,
//                         height: height * 0.1,
//                         child: Image.asset("assets/flaticon/result4.png"),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10.0),
//                         child: SizedBox(
//                           width: height * 0.005,
//                           child: Text("",
//                               style: GoogleFonts.inter(
//                                   color: Colors.white,
//                                   letterSpacing: 1.0,
//                                   fontSize: height * 0.03,
//                                   fontWeight: FontWeight.w500)),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ]),
//             ),
//           ),
//         ),
//         body: FutureBuilder<ClassWiseResultResponseModel>(
//           future: ApiServices.teacherViewReqsultClassWise(
//               widget.selectedClass, widget.testType),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text("Error: ${snapshot.error}"));
//             } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
//               return const Center(child: Text("No data found"));
//             } else {
//               ClassWiseResultResponseModel? classResult = snapshot.data;

//               return Container(
//                 child: ListView.builder(
//                   itemCount: classResult!.data!.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return ExpansionTile(
//                       leading: InkWell(
//                         onTap: () {
//                           showDialog(
//                             context: context,
//                             builder: (BuildContext context) {
//                               return AlertDialog(
//                                 title: const Text("Confirmation"),
//                                 content: const Text(
//                                     "Do you want to delete this result?"),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () {
//                                       ApiServices.deleteResult(classResult
//                                           .data![index].id
//                                           .toString());
//                                       Navigator.push(context, MaterialPageRoute(
//                                         builder: (context) {
//                                           return const Dashboard();
//                                         },
//                                       ));
//                                       ScaffoldMessenger.of(context)
//                                           .showSnackBar(
//                                         const SnackBar(
//                                           content: Text(
//                                               'Result deleted successfully'),
//                                           duration: Duration(seconds: 3),
//                                         ),
//                                       );
//                                       log("Item deleted");
//                                     },
//                                     child: const Text(
//                                       "Yes",
//                                     ),
//                                   ),
//                                   TextButton(
//                                     onPressed: () {
//                                       Navigator.of(context).pop();
//                                     },
//                                     child: const Text("No"),
//                                   ),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                         child: CircleAvatar(
//                           backgroundColor: lightBlue,
//                           radius: 20,
//                           child: const Icon(
//                             Icons.delete,
//                             color: Colors.red,
//                           ),
//                         ),
//                       ),
//                       title: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "Name: ${classResult.data![index].studentName.toString()}",
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                           Text(
//                             "Roll: ${classResult.data![index].rollNumber.toString()}",
//                             style: const TextStyle(
//                               fontSize: 15,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ],
//                       ),
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(left: 8, right: 8),
//                           child: Row(
//                             // Additional Row for the top row of containers
//                             children: [
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(), color: deepBlue),
//                                   height: containerSize,
//                                   width: containerSize,
//                                   child: const Center(
//                                     child: Text(
//                                       "Subject",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(), color: deepBlue),
//                                   height: containerSize,
//                                   width: containerSize,
//                                   child: const Center(
//                                     child: Text(
//                                       "Marks",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(), color: deepBlue),
//                                   height: containerSize,
//                                   width: containerSize,
//                                   child: const Center(
//                                     child: Text(
//                                       "Grade",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                       border: Border.all(), color: deepBlue),
//                                   height: containerSize,
//                                   width: containerSize,
//                                   child: const Center(
//                                     child: Text(
//                                       "Comments",
//                                       style: TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         GridView.builder(
//                           shrinkWrap:
//                               true, // Add this to fix the issue with GridView
//                           gridDelegate:
//                               const SliverGridDelegateWithFixedCrossAxisCount(
//                             crossAxisCount: 1,
//                             childAspectRatio: 8,
//                           ),
//                           itemBuilder: (context, index1) {
//                             return Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 8),
//                               child: Row(
//                                 children: [
//                                   Expanded(
//                                     child: Container(
//                                       decoration:
//                                           BoxDecoration(border: Border.all()),
//                                       height: containerSize,
//                                       width: containerSize,
//                                       child: Center(
//                                         child: Text(classResult.data![index]
//                                             .subjects![index1].subject
//                                             .toString()),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       decoration:
//                                           BoxDecoration(border: Border.all()),
//                                       height: containerSize,
//                                       width: containerSize,
//                                       child: Center(
//                                         child: Text(classResult.data![index]
//                                             .subjects![index1].marks
//                                             .toString()),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       decoration:
//                                           BoxDecoration(border: Border.all()),
//                                       height: containerSize,
//                                       width: containerSize,
//                                       child: Center(
//                                         child: Text(classResult.data![index]
//                                             .subjects![index1].grade
//                                             .toString()),
//                                       ),
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: Container(
//                                       decoration:
//                                           BoxDecoration(border: Border.all()),
//                                       height: containerSize,
//                                       width: containerSize,
//                                       child: Center(
//                                         child: Text(classResult.data![index]
//                                             .subjects![index1].comment
//                                             .toString()),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           itemCount: classResult.data![index].subjects!.length,
//                         ),
//                       ],
//                     );
//                   },
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

//...........Above one is old ui................................................

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Result/Teacher/View/edit_marks_of_student_subject_wise.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class SubjectWiseResultView extends StatelessWidget {
  final List resultDataList;
  final String resultId;
  const SubjectWiseResultView(
      {super.key, required this.resultDataList, required this.resultId});

  @override
  Widget build(BuildContext context) {
    double containerSize = MediaQuery.of(context).size.width / 8;
    var height = MediaQuery.of(context).size.height;
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
        body: ListView.builder(
          itemCount: resultDataList.length,
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
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.26,
                            child: Text(
                              resultDataList[index].name.toString(),
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
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            resultDataList[index].rollNumber.toString(),
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
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: 1,
                        itemBuilder: (context, index1) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.height * 0.02,
                                top: 20,
                                right:
                                    MediaQuery.of(context).size.height * 0.02,
                                bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8),
                                      child: Row(
                                        // Additional Row for the top row of containers
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: deepBlue),
                                              height: containerSize,
                                              width: containerSize,
                                              child: const Center(
                                                child: Text(
                                                  "Subject",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: GestureDetector(
                                              onTap: () {
                                                log("hello");

                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        TeacherEditMarksOfResultSubjectWise(
                                                      resultId: resultId,
                                                      studentId:
                                                          resultDataList[index]
                                                              .id
                                                              .toString(),
                                                      marks:
                                                          resultDataList[index]
                                                              .marks
                                                              .toString(),
                                                      subject:
                                                          resultDataList[index]
                                                              .subject
                                                              .toString(),
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(),
                                                    color: deepBlue),
                                                height: containerSize,
                                                width: containerSize,
                                                child: const Center(
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        "Marks",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: deepBlue),
                                              height: containerSize,
                                              width: containerSize,
                                              child: const Center(
                                                child: Text(
                                                  "Grade",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(),
                                                  color: deepBlue),
                                              height: containerSize,
                                              width: containerSize,
                                              child: const Center(
                                                child: Text(
                                                  "Comment",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GridView.builder(
                                        shrinkWrap:
                                            true, // Add this to fix the issue with GridView
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 1,
                                          childAspectRatio: 8,
                                        ),
                                        itemBuilder: (context, index1) {
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8),
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all()),
                                                    height: containerSize,
                                                    width: containerSize,
                                                    child: Center(
                                                      child: Text(
                                                          resultDataList[index]
                                                              .subject
                                                              .toString()),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all()),
                                                    height: containerSize,
                                                    width: containerSize,
                                                    child: Center(
                                                      child: Text(
                                                          resultDataList[index]
                                                              .marks
                                                              .toString()),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all()),
                                                    height: containerSize,
                                                    width: containerSize,
                                                    child: Center(
                                                      child: Text(
                                                          resultDataList[index]
                                                              .grades
                                                              .toString()),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all()),
                                                    height: containerSize,
                                                    width: containerSize,
                                                    child: Center(
                                                      child: Text(
                                                          resultDataList[index]
                                                              .comments
                                                              .toString()),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: 1),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
                //  Divider(),
              ],
            );
          },
        ));
  }
}

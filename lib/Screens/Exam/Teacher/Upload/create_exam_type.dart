import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';

import '../../../../constants/style.dart';
import '../../../../widget/appBar/appbar_widget.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';

class CreateExamTypeView extends StatelessWidget {
  List<String> examTypeList;

  CreateExamTypeView({super.key, required this.examTypeList});

  final selectedClass = 'Choose Class'.obs;

  final nameController = TextEditingController().obs;
  final sectionOptions = [
    'Choose Section',
    'A',
    'B',
    'C',
    "D",
    'E',
  ].obs;
  final selectedSection = 'Choose Section'.obs;

  final classOptions = [
    'Choose Class',
    '1',
    '2',
    '3',
    "4",
    '5',
    '6',
    '7',
    "8",
    '9',
    '10',
    '11',
    "12",
  ].obs;

  final listOfCriteria = [
    {"no": 1, "range": "Above 35", "grades": 5, "comments": "Pass"},
    {"no": 2, "range": "Below", "grades": 0, "comments": "Fail"},
  ].obs;

  @override
  Widget build(BuildContext context) {
    final listOfBool =
        List.generate(listOfCriteria.length, (index) => false).obs;
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    double containerSize = MediaQuery.of(context).size.width / 6;
    return Scaffold(
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
          extra:
              appbar("assets/flaticon/_exam.png", "Examination", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.sp),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(
                "Create Exam Type",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 15.sp,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Exam name",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: const Color.fromARGB(255, 96, 96, 96),
                  ),
                ),
              ),
              Obx(() {
                return TextField(
                  controller: nameController.value,
                  decoration: InputDecoration(
                    hintText: "Enter exam name",
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color.fromARGB(255, 135, 135, 135),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 15.sp,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Class",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: selectedClass.value,
                  onChanged: (value) {
                    if (value != 'Choose Class') {
                      selectedClass.value = value!;
                    }
                  },
                  items: classOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: "Class*",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: deepBlue,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 15.sp,
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Select Section",
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: selectedSection.value,
                  onChanged: (value) {
                    if (value != 'Choose Section') {
                      selectedSection.value = value!;
                    }
                  },
                  items: sectionOptions
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    hintText: "Section*",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: deepBlue,
                        width: 2,
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(
                height: 25.sp,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  // Additional Row for the top row of containers
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(15)),
                            border: Border.all(),
                            color: deepBlue),
                        height: containerSize,
                        width: containerSize,
                        child: const Center(
                          child: Text(
                            "Sr. No.",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(), color: deepBlue),
                        height: containerSize,
                        width: containerSize,
                        child: const Center(
                          child: Text(
                            "Marks range",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(), color: deepBlue),
                        height: containerSize,
                        width: containerSize,
                        child: const Center(
                          child: Text(
                            "Grades",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(15)),
                            border: Border.all(),
                            color: deepBlue),
                        height: containerSize,
                        width: containerSize,
                        child: const Center(
                          child: Text(
                            "Comments",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                // height: 0.2.sh,
                child: Obx(() {
                  return GridView.builder(
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        childAspectRatio: 8,
                      ),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    listOfBool[index] = !listOfBool[index];
                                  },
                                  child: Container(
                                    decoration:
                                        BoxDecoration(border: Border.all()),
                                    height: containerSize,
                                    width: containerSize,
                                    child: Obx(() {
                                      return Center(
                                        child: listOfBool[index]
                                            ? TextField()
                                            : Obx(() {
                                                return Text(
                                                    listOfCriteria[index]["no"]
                                                        .toString()
                                                    // exam
                                                    // .data!.examDetails![index].subject
                                                    // .toString()
                                                    );
                                              }),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  height: containerSize,
                                  width: containerSize,
                                  child: Center(
                                    child: Text(listOfCriteria[index]["range"]
                                            .toString()
                                        // DateFormat('dd-MM-yyyy').format(
                                        // DateTime.parse(exam
                                        //     .data!.examDetails![index].date
                                        //     .toString()))
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  height: containerSize,
                                  width: containerSize,
                                  child: Center(
                                    child: Text(listOfCriteria[index]["grades"]
                                            .toString()
                                        // exam
                                        // .data!.examDetails![index].time
                                        // .toString()
                                        ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration:
                                      BoxDecoration(border: Border.all()),
                                  height: containerSize,
                                  width: containerSize,
                                  child: Center(
                                    child: Text(listOfCriteria[index]
                                                ["comments"]
                                            .toString()
                                        // exam
                                        // .data!.examDetails![index].time
                                        // .toString()
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: listOfCriteria.length
                      // exam.data!.examDetails!.length,
                      );
                }),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.sp),
                    child: SizedBox(
                        height: 0.025.sh,
                        child: ElevatedButton(
                            onPressed: () {
                              listOfCriteria.add({
                                "no": "",
                                "range": "",
                                "grades": "",
                                "comments": ""
                              });
                              listOfBool.add(false);
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.add, size: 15.sp),
                                Text(
                                  "Add row",
                                  style: TextStyle(fontSize: 10.sp),
                                ),
                              ],
                            ))),
                  )),
              // FutureBuilder<ExamRoutineResponseModel>(
              //   future: ApiServices.viewExamRoutine(widget.selectedClass,
              //       widget.testType, widget.selectedSection),
              //   builder: (context, snapshot) {
              //     if (snapshot.connectionState == ConnectionState.waiting) {
              //       return const Center(
              //           child:
              //               CircularProgressIndicator()); // Show loading indicator
              //     } else if (snapshot.hasError) {
              //       return Text('Error: ${snapshot.error}');
              //     } else if (!snapshot.hasData || snapshot.data!.data == null) {
              //       return const Center(child: Text('No Exam Found.'));
              //     } else {
              //       ExamRoutineResponseModel? exam = snapshot.data;
              //       log("Message= ${exam!.message.toString()}");
              //       log("Status= ${exam.status.toString()}");
              //
              //       return GridView.builder(
              //         shrinkWrap: true,
              //         gridDelegate:
              //             const SliverGridDelegateWithFixedCrossAxisCount(
              //           crossAxisCount: 1,
              //           childAspectRatio: 8,
              //         ),
              //         itemBuilder: (context, index) {
              //           return Padding(
              //             padding: const EdgeInsets.symmetric(horizontal: 8),
              //             child: Row(
              //               children: [
              //                 Expanded(
              //                   child: Container(
              //                     decoration:
              //                         BoxDecoration(border: Border.all()),
              //                     height: containerSize,
              //                     width: containerSize,
              //                     child: Center(
              //                       child: Text(exam
              //                           .data!.examDetails![index].subject
              //                           .toString()),
              //                     ),
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Container(
              //                     decoration:
              //                         BoxDecoration(border: Border.all()),
              //                     height: containerSize,
              //                     width: containerSize,
              //                     child: Center(
              //                       child: Text(DateFormat('dd-MM-yyyy').format(
              //                           DateTime.parse(exam
              //                               .data!.examDetails![index].date
              //                               .toString()))),
              //                     ),
              //                   ),
              //                 ),
              //                 Expanded(
              //                   child: Container(
              //                     decoration:
              //                         BoxDecoration(border: Border.all()),
              //                     height: containerSize,
              //                     width: containerSize,
              //                     child: Center(
              //                       child: Text(exam
              //                           .data!.examDetails![index].time
              //                           .toString()),
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           );
              //         },
              //         itemCount: exam.data!.examDetails!.length,
              //       );
              //     }
              //   },
              // ),
              ElevatedButton(
                  onPressed: () async {
                    if (selectedClass.value != "Choose Class" &&
                        selectedSection.value != "Choose Section") {
                      examTypeList.add(nameController.value.text);
                      await TeacherApiServices.teacherCreateExamType(context,
                          classofStudent: selectedClass.value,
                          examTypeList: examTypeList);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey,
                      backgroundColor: Color.fromRGBO(255, 152, 127, 1),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.sp))),
                  child: const Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

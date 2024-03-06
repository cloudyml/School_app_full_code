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
  String examListId;

  CreateExamTypeView(
      {super.key, required this.examTypeList, required this.examListId});

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

  final listOfCriteria = [].obs;
  final srNo = 0.obs;
  final listOfBool = [].obs;

  @override
  Widget build(BuildContext context) {
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
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                    2,
                    (index) => Padding(
                          padding: EdgeInsets.all(10.sp),
                          child: SizedBox(
                            height: 50.sp,
                            width: 0.35.sw,
                            child: TextField(
                              decoration: decoration.copyWith(
                                  labelText: hintTextOfMarks[index]),
                              controller: textOfPassingTotalMarks[index].value,
                            ),
                          ),
                        )),
              ),
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
              Obx(() {
                return SizedBox(
                  // height: 0.2.sh,
                  child: listOfCriteria.isNotEmpty
                      ? Obx(() {
                          return GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 8,
                              ),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          height: containerSize,
                                          width: containerSize,
                                          child: Center(
                                            child: Text("${index + 1}"),
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
                                                "${listOfCriteria[index]["marksRange"][0].toString()}-${listOfCriteria[index]["marksRange"][1].toString()}"
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
                                          decoration: BoxDecoration(
                                              border: Border.all()),
                                          height: containerSize,
                                          width: containerSize,
                                          child: Center(
                                            child: Text(
                                                "${listOfCriteria[index]["grades"]}"
                                                // exam
                                                // .data!.examDetails![index].time
                                                // .toString()
                                                ),
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
                        })
                      : Container(),
                );
              }),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.sp),
                    child: SizedBox(
                        height: 0.025.sh,
                        child: ElevatedButton(
                            onPressed: () {
                              showRowDialogue(context);
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
              ElevatedButton(
                  onPressed: () async {
                    if (selectedClass.value != "Choose Class" &&
                        selectedSection.value != "Choose Section") {
                      // examTypeList.add(nameController.value.text);
                      // examTypeList.toList();
                      await TeacherApiServices.teacherCreateExamType(context,
                          examTypeList: ["${nameController.value.text}"],
                          examListId: examListId);

                      listOfCriteria.toList();
                      await TeacherApiServices.teacherPostGradingData(context,
                          examType: nameController.value.text,
                          selectedClass: selectedClass.value,
                          selectedSection: selectedSection.value,
                          passingMarks: textOfPassingTotalMarks[1].value.text,
                          totalMarks: textOfPassingTotalMarks[0].value.text,
                          gradingCriteria: listOfCriteria);
                      textOfPassingTotalMarks.forEach((element) {
                        element.value.clear();
                      });
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

  final textOfmarksRange =
      List.generate(2, (index) => TextEditingController().obs);
  final textOfGradeComment =
      List.generate(2, (index) => TextEditingController().obs);
  final textOfPassingTotalMarks =
      List.generate(2, (index) => TextEditingController().obs);

  showRowDialogue(context) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(child: const Text("Grade Criteria")),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: deepBlue),
                  onPressed: () {

                    listOfCriteria.add({
                      "marksRange": [textOfmarksRange[0].value.text.toString(),
                        textOfmarksRange[1].value.text.toString()],
                      "grades": textOfGradeComment[0].value.text,
                      "comments": textOfGradeComment[1].value.text
                    });
                    textOfmarksRange.forEach((element) {
                      element.value.clear();
                    });
                    textOfGradeComment.forEach((element) {
                      element.value.clear();
                    });
                    print("Mark range = ${textOfmarksRange[0].value.text.toString()} ${textOfmarksRange[1].value.text.toString()}");
                    print("Mark range = $listOfCriteria");
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      2,
                      (index) => SizedBox(
                            width: 0.25.sw,
                            child: TextField(
                              controller: textOfmarksRange[index].value,
                              decoration: decoration.copyWith(
                                  labelText: hintRangeText[index]),
                            ),
                          )),
                ),
                SizedBox(
                  height: 20.sp,
                ),
                Column(
                  children: List.generate(
                      2,
                      (index) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.sp),
                            child: SizedBox(
                              width: 0.75.sw,
                              child: TextField(
                                controller: textOfGradeComment[index].value,
                                decoration: decoration.copyWith(
                                    labelText: hintText[index]),
                              ),
                            ),
                          )),
                )
              ],
            ),
          );
        });
  }

  final decoration = InputDecoration(
      enabledBorder: OutlineInputBorder(),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)));
  final hintRangeText = ["Range from", "Range to"];
  final hintText = ["Grade", "Comment"];
  final hintTextOfMarks = ["Total Marks", "Passing Marks"];
}

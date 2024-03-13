import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Exam/Teacher/Upload/teacher_choose_examtype.dart';
import 'package:school_management_system/Screens/Exam/Teacher/Upload/upload_exam_routine.dart';

import '../../../../../../../constants/style.dart';
import '../../../../../../../widget/Button/my_elevatedbutton.dart';
import '../../../../../../../widget/appBar/appbar_widget.dart';
import '../../../../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../../Services/api_services/api_services.dart';
import '../../../../Services/teacher_shared_service.dart';

class TeacherChooseClassForUploadExamRoutine extends StatefulWidget {
  final String testType;

  const TeacherChooseClassForUploadExamRoutine(
      {super.key, required this.testType});

  @override
  State<TeacherChooseClassForUploadExamRoutine> createState() =>
      _ChooseClassForTakeAttendanceState();
}

class _ChooseClassForTakeAttendanceState
    extends State<TeacherChooseClassForUploadExamRoutine> {
  // TextEditingController remarks = TextEditingController();
  String selectedClass = 'Choose Class';
  String selectedSection = 'Choose Section';
  List<String> classOptions = [
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
  ];
  List<String> sectionOptions = [
    'Choose Section',
    'A',
    'B',
    'C',
    "D",
    'E',
  ];
  List<ExamRoutineData> examData = [];
  TextEditingController subjectController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  bool isEditing = false;
  ExamRoutineData? selectPaper;
  bool isClicked = false;

  void deletePeriod(int index) {
    setState(() {
      examData.removeAt(index);
      clearTextFields();
    });
  }

  void updatePeriod() {
    setState(() {
      if (selectPaper != null) {
        selectPaper?.subject = subjectController.text;
        selectPaper?.date = dateController.text;
        selectPaper?.time = timeController.text;

        isEditing = false;
        clearTextFields();
      }
    });
  }

  void clearTextFields() {
    setState(() {
      subjectController.clear();
      dateController.clear();
      timeController.clear();
      selectPaper = null;
      isEditing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    void showFailureSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Fill all the required fields'),
          duration: Duration(seconds: 3),
          showCloseIcon: true,
        ),
      );
    }

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    double containerSize = MediaQuery.of(context).size.width / 6;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.19,
          barPad: MediaQuery.of(context).size.height * 0.15,
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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.075,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Examtype",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      widget.testType,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              // Examination class standard
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.075,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Standard",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DropdownButtonFormField<String>(
                      value: selectedClass,
                      onChanged: (value) {
                        if (value != 'Choose Class') {
                          setState(() {
                            selectedClass = value!;
                          });
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
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              // Examination class section
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.075,
                    ),
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Select Section",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: DropdownButtonFormField<String>(
                      value: selectedSection,
                      onChanged: (value) {
                        if (value != 'Choose Class') {
                          setState(() {
                            selectedSection = value!;
                          });
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
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 20.sp),
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
                            "Subject",
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
                            "Date",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: deepBlue,
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15)),
                        ),
                        height: containerSize,
                        width: containerSize,
                        child: const Center(
                          child: Text(
                            "Time",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  child: GridView.builder(
                    itemCount: examData.length,
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
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                height: containerSize,
                                width: containerSize,
                                child: Center(
                                  child: Text("${examData[index].subject}"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                height: containerSize,
                                width: containerSize,
                                child: Center(
                                  child: Text("${examData[index].date}"),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(border: Border.all()),
                                height: containerSize,
                                width: containerSize,
                                child: Center(
                                  child: Text("${examData[index].time}"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.sp),
                child: SizedBox(
                  // width: 0.30.sw,
                  height: 20.sp,
                  child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: subjectController,
                                      decoration: decoration.copyWith(
                                        hintText: "Enter the subject ",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.sp,
                                    ),
                                    TextField(
                                      controller: dateController,
                                      onTap: () async {
                                        DateTime? pickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.now(),
                                          lastDate: DateTime(2101),
                                        );

                                        if (pickedDate != null &&
                                            pickedDate != DateTime.now()) {
                                          setState(() {
                                            dateController.text =
                                                "${pickedDate.month}/${pickedDate.day}/${pickedDate.year}";
                                          });
                                        }
                                      },
                                      decoration: decoration.copyWith(
                                        hintText: "Select exam date ",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15.sp,
                                    ),
                                    TextField(
                                      controller: timeController,
                                      onTap: () async {
                                        TimeOfDay? pickedTime =
                                            await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                        );

                                        if (pickedTime != null) {
                                          setState(() {
                                            timeController.text =
                                                pickedTime.format(context);
                                          });
                                        }
                                      },
                                      decoration: decoration.copyWith(
                                        hintText: "Select exam time ",
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {
                                        if (isEditing) {
                                          updatePeriod();
                                        } else {
                                          if (subjectController
                                                  .text.isNotEmpty &&
                                              timeController.text.isNotEmpty &&
                                              dateController.text.isNotEmpty) {
                                            examData.add(ExamRoutineData(
                                              subject: subjectController.text,
                                              date: dateController.text,
                                              time: timeController.text,
                                            ));
                                          }
                                        }
                                        clearTextFields();
                                        Navigator.pop(context);
                                      },
                                      child: Text("Add")),
                                  ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"))
                                ],
                                actionsAlignment: MainAxisAlignment.center,
                              );
                            });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Add row"),
                          Icon(
                            Icons.add,
                            size: 15.sp,
                          )
                        ],
                      )),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 20, top: height * 0.05),
                child: MyElevatedButton(
                  child: Text(
                    'SUBMIT',
                    style:
                        TextStyle(color: Colors.white, fontSize: width * 0.05),
                  ),
                  onPressed: () async {
                    try {
                      if (isClicked == true) {
                        return;
                      }
                      if (isClicked == false) {
                        setState(() {
                          isClicked = true;
                        });
                        Map<String, dynamic> postData = {
                          "schoolName": TeacherSharedServices.loginDetails()!
                              .data!
                              .data!
                              .schoolName
                              .toString(),
                          "institutionId": TeacherSharedServices.loginDetails()!
                              .data!
                              .data!
                              .institutionId
                              .toString(),
                          "schoolId": TeacherSharedServices.loginDetails()!
                              .data!
                              .data!
                              .schoolId
                              .toString(),
                          "class": selectedClass,
                          "section": selectedSection,
                          "examType": widget.testType,
                          "remarks": "",
                          "examDetails": examData.map((subjects) {
                            return {
                              "date": subjects.date,
                              "subject": subjects.subject,
                              "time": subjects.time,
                            };
                          }).toList(),
                        };

                        // log(postData.toString());
                        await ApiServices.uploadExamRoutine(postData)
                            .then((value) {
                          if (value == true) {
                            showSuccessSnackbar();
                            Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TeacherSelectExamType()))
                                .whenComplete(() {
                              setState(() {
                                isClicked = false;
                              });
                            });
                          } else {
                            showFailureSnackbar();
                          }
                        });
                      }
                    } catch (e) {
                      EasyLoading.showError(e.toString());
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showFailureSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exam Routine already added for this class'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exam uploaded successfully'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  final decoration = InputDecoration(
    focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.purple)),
    enabledBorder: OutlineInputBorder(),
    hintStyle: GoogleFonts.poppins(
      fontSize: 14.sp,
      color: const Color.fromARGB(255, 135, 135, 135),
    ),
  );
}

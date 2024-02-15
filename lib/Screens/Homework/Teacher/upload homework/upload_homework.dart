import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/Screens/Homework/Teacher/upload_view_homework_options.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import 'package:school_management_system/widget/Button/rectangle_elevatedbutton_card.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class UploadAssignment extends StatefulWidget {
  const UploadAssignment({super.key});
  @override
  State<UploadAssignment> createState() => _EventScreen();
}

class _EventScreen extends State<UploadAssignment> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController lastDateInput = TextEditingController();
  TextEditingController subjectInput = TextEditingController();
  TextEditingController headlineInput = TextEditingController();
  TextEditingController commentsInput = TextEditingController();
  TextEditingController topicInput = TextEditingController();
  File? file;
  ImagePicker image = ImagePicker();
  bool isClicked = false;
  List<QuestionModel> questions = [];
  List<String> sectionOptions = ['A', 'B', 'C'];
  List<String> clasOptions = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];
  String selectedClass = '1';
  String selectedSection = 'A';
  TextEditingController questionController = TextEditingController();
  List<Map<String, String>>? textAssignmentList;
  @override
  void dispose() {
    questionController.dispose();
    subjectInput.dispose();
    topicInput.dispose();
    super.dispose();
  }

  bool canSubmitFileAssignment() {
    return selectedClass.isNotEmpty &&
        selectedSection.isNotEmpty &&
        subjectInput.text.isNotEmpty &&
        topicInput.text.isNotEmpty &&
        file != null &&
        dateInput.text.isNotEmpty &&
        lastDateInput.text.isNotEmpty;
  }

  bool canSubmitTextAssignment() {
    return selectedClass.isNotEmpty &&
        selectedSection.isNotEmpty &&
        subjectInput.text.isNotEmpty &&
        topicInput.text.isNotEmpty &&
        questionController.text.isEmpty &&
        dateInput.text.isNotEmpty &&
        lastDateInput.text.isNotEmpty;
  }

  void showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Assignment uploaded successfully'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void showFailureSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.red,
        content: Text("Try again..."),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> getGal() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);

      setState(() {
        file = selectedFile;
      });
    }
  }

  bool isTextAssignments = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          DecorativeAppBar(
            barHeight: MediaQuery.of(context).size.height * 0.24,
            barPad: MediaQuery.of(context).size.height * 0.19,
            radii: 30,
            background: Colors.white,
            gradient1: lightBlue,
            gradient2: deepBlue,
            extra:
                appbar("assets/add_events.png", "Upload Homework", context, () {
              Navigator.pop(context);
            }),
          ),
          Container(
            height: height * 0.07,
            width: width * 0.92,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: const [
                  BoxShadow(
                      color: const Color.fromARGB(255, 126, 126, 126),
                      blurRadius: 6)
                ]),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isTextAssignments = true;
                      });
                    },
                    child: Container(
                      width: width * 0.46,
                      height: height * 0.07,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: isTextAssignments
                            ? const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 252, 86, 46),
                                  Color.fromARGB(255, 255, 152, 127),
                                ],
                              )
                            : const LinearGradient(
                                colors: [Colors.white, Colors.white],
                              ),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Text',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color:
                                isTextAssignments ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isTextAssignments = false;
                      });
                    },
                    child: Container(
                      width: width * 0.46,
                      height: height * 0.07,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        gradient: !isTextAssignments
                            ? const LinearGradient(
                                colors: [
                                  Color.fromARGB(255, 255, 152, 127),
                                  Color.fromARGB(255, 252, 86, 46),
                                ],
                              )
                            : const LinearGradient(
                                colors: [Colors.white, Colors.white],
                              ),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'File',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            color: !isTextAssignments
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //Text assignments
          Visibility(
            visible: isTextAssignments,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05, top: 20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Given Date*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                ),
                                hintText: "Select date",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    dateInput.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Date of Submit*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: lastDateInput,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                ),
                                hintText: "Select date",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    lastDateInput.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Standard*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButton<String>(
                                value: selectedClass,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedClass = newValue!;
                                  });
                                  log(selectedClass);
                                },
                                items: clasOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Section*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButton<String>(
                                value: selectedSection,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSection = newValue!;
                                  });
                                  log(selectedSection);
                                },
                                items: sectionOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Subject*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: subjectInput,
                              decoration: InputDecoration(
                                hintText: "Enter subject for assignment",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Topic*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: topicInput,
                              decoration: InputDecoration(
                                hintText: "Enter topic of the subject",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Enter Question*",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 17,
                            color: const Color.fromARGB(255, 96, 96, 96),
                          ),
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: width * 0.05,
                              right: width * 0.05,
                              top: width * 0.05),
                          child: Column(
                              children:
                                  List.generate(questions.length, (index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                    width: width * 0.8,
                                    child: Text(
                                        questions[index].question.toString())),
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        questions.remove(questions[index]);
                                      });
                                    },
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 25,
                                    ))
                              ],
                            );
                          })),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                left: width * 0.05,
                                right: width * 0.05,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    maxLines: 2,
                                    controller: questionController,
                                    decoration: InputDecoration(
                                      hintText: "Enter question for homework",
                                      hintStyle: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: const Color.fromARGB(
                                            255, 135, 135, 135),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                right: width * 0.05,
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: MyElevatedButton(
                                    onPressed: () {
                                      questionController.text.isNotEmpty
                                          ? setState(() {
                                              questions.add(QuestionModel(
                                                  questionKey: "question",
                                                  question:
                                                      questionController.text));
                                              questionController.clear();
                                            })
                                          : showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                      'Empty Question'),
                                                  content: const Text(
                                                    'Please enter any question in the field',
                                                    style:
                                                        TextStyle(fontSize: 16),
                                                  ),
                                                  actions: <Widget>[
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text('Ok'),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                    },
                                    child: const Text(
                                      "Add Question",
                                      style: TextStyle(color: Colors.white),
                                    )),
                              ),
                            )
                          ],
                        )
                      ],
                    ),

                    //..........
                    SizedBox(
                      height: width * 0.15,
                    ),
                  ],
                ),
              ),
            ),
          ),
          //
          // File Assignments.......................................
          //
          Visibility(
            visible: !isTextAssignments,
            child: Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05, right: width * 0.05, top: 20),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Given Date*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: dateInput,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                ),
                                hintText: "Select date",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    dateInput.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Last Date of Submit*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: lastDateInput,
                              decoration: InputDecoration(
                                suffixIcon: const Icon(
                                  Icons.calendar_month,
                                ),
                                hintText: "Select date",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                              readOnly: true,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                );

                                if (pickedDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(pickedDate);
                                  setState(() {
                                    lastDateInput.text = formattedDate;
                                  });
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Standard*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButton<String>(
                                value: selectedClass,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedClass = newValue!;
                                  });
                                  log(selectedClass);
                                },
                                items: clasOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Section*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButton<String>(
                                value: selectedSection,
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                elevation: 16,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                ),
                                underline: Container(
                                  height: 1,
                                  color: Colors.grey,
                                ),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedSection = newValue!;
                                  });
                                  log(selectedSection);
                                },
                                items: sectionOptions
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem<String>(
                                      value: value, child: Text(value));
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Subject*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: subjectInput,
                              decoration: InputDecoration(
                                hintText: "Enter subject for assignment",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: width * 0.05,
                          right: width * 0.05,
                          top: width * 0.05),
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Enter Topic*",
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 17,
                                color: const Color.fromARGB(255, 96, 96, 96),
                              ),
                            ),
                            TextField(
                              controller: topicInput,
                              decoration: InputDecoration(
                                hintText: "Enter topic of the subject",
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color:
                                      const Color.fromARGB(255, 135, 135, 135),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.06,
                    ),
                    Center(
                      // Center added here
                      child: Container(
                        height: height * 0.2,
                        width: width * 0.52,
                        color: Colors.black12,
                        child: file == null
                            ? const Icon(
                                Icons.image,
                                size: 50,
                              )
                            : file!.path.toLowerCase().endsWith('.pdf')
                                ? PDFView(
                                    filePath: file?.path ?? '',
                                  )
                                : Image.file(
                                    file!,
                                    fit: BoxFit.fill,
                                  ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.05,
                    ),
                    Center(
                      // Center added here
                      child: MyElevatedButton(
                        onPressed: () {
                          getGal();
                        },
                        child: const Text(
                          "+ Choose file",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: width * 0.15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      persistentFooterButtons: [
        RecElevatedButton(
          onPressed: isTextAssignments
              ? canSubmitTextAssignment()
                  ? () async {
                      if (isClicked == false) {
                        setState(() {
                          isClicked = true;
                        });
                        textAssignmentList = questions
                            .map((question) =>
                                {"question": question.question ?? ""})
                            .toList();
                        // log(jsonEncode(
                        //     {"textAssignmentList": textAssignmentList}));
                        await TeacherApiServices.TeacherUploadTextAssignment(
                                classofStudent: selectedClass,
                                section: selectedSection,
                                subject: subjectInput.text,
                                givenDate: dateInput.text,
                                topic: topicInput.text,
                                lastDateOfSubmit: lastDateInput.text,
                                textAssignmentList: textAssignmentList ?? [])
                            .then((value) {
                          if (value == true) {
                            showSuccessSnackbar();
                            Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TeacherAssignmentFirstPage()))
                                .whenComplete(() {
                              setState(() {
                                isClicked = false;
                              });
                            });
                          } else {
                            showFailureSnackbar();
                            setState(() {
                              isClicked = true;
                            });
                          }
                        });
                      }
                    }
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please fill in all fields'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Ok'),
                              ),
                            ],
                          );
                        },
                      );
                    }
              : canSubmitFileAssignment()
                  ? () async {
                      if (isClicked == false) {
                        setState(() {
                          isClicked = true;
                        });

                        await TeacherApiServices.TeacherUploadFileAssignment(
                                dateInput.text,
                                lastDateInput.text,
                                selectedClass,
                                selectedSection,
                                subjectInput.text,
                                topicInput.text,
                                file!,
                                context)
                            .then((value) {
                          if (value == true) {
                            showSuccessSnackbar();
                            Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const TeacherAssignmentFirstPage()))
                                .whenComplete(() {
                              setState(() {
                                isClicked = false;
                              });
                            });
                          } else {
                            showFailureSnackbar();
                            setState(() {
                              isClicked = false;
                            });
                          }
                        });
                      }
                    }
                  : () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Please fill in all fields'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                      setState(() {
                        isClicked = false;
                      });
                    },
          child: const Text(
            "SUBMIT",
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

class QuestionModel {
  String? questionKey;
  String? question;

  QuestionModel({this.questionKey, this.question});
}

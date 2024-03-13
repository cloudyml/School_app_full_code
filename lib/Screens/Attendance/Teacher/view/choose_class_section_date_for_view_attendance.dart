import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/Screens/Attendance/Teacher/upload/take_attandance.dart';
import 'package:school_management_system/Screens/Attendance/Teacher/view/view_attendance_daywise.dart';
import '../../../../constants/style.dart';
import '../../../../widget/Button/my_elevatedbutton.dart';
import '../../../../widget/appBar/appbar_widget.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../Dashboard.dart';

class ChooseClassForViewAttendance extends StatefulWidget {
  const ChooseClassForViewAttendance({Key? key}) : super(key: key);

  @override
  State<ChooseClassForViewAttendance> createState() =>
      _ChooseClassForViewAttendanceState();
}

class _ChooseClassForViewAttendanceState
    extends State<ChooseClassForViewAttendance> {
  String selectedClass = 'Choose Class'; // Set to default option
  String selectedSection = 'Choose Section'; // Set to default option

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
  List<String> sectionOptions = ['Choose Section', 'A', 'B', 'C'];

  TextEditingController dateInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.18,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra:
              appbar("assets/attendance_appbar.png", "Attendance", context, () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Dashboard()));
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
                padding: EdgeInsets.only(left: height * 0.03),
                child: const Text(
                  "View Attendance",
                  style: TextStyle(
                      color: Color.fromARGB(255, 93, 93, 93),
                      fontSize: 24,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.06),
                child: Column(
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
                          // contentPadding: const EdgeInsets.symmetric(
                          //     vertical: 5, horizontal: 5),
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
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.06),
                child: Column(
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
                          if (value != 'Choose Section') {
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
                          // contentPadding: const EdgeInsets.symmetric(
                          //     vertical: 5, horizontal: 5),
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
              ),
              Padding(
                padding: EdgeInsets.only(top: height * 0.06),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.075,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Select Date",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: TextField(
                          controller: dateInput,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(
                              Icons.calendar_month,
                            ),
                            hintText: "Choose date",
                            hintStyle: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: Colors.black87),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: deepBlue,
                                width: 2,
                              ),
                            ),
                          ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(1950),
                                lastDate: DateTime(2200));
                            if (pickedDate != null) {
                              String formattedDate =
                                  DateFormat('yyyy-MM-dd').format(pickedDate);
                              setState(() {
                                dateInput.text = formattedDate;
                              });
                            }
                          },
                        )),
                  ],
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
                  onPressed: () {
                    if (selectedClass == 'Choose Class' ||
                        selectedSection == 'Choose Section' ||
                        dateInput.text.isEmpty) {
                      return; // Exit function if default values are selected
                    } else {
                      log("Selected Class= $selectedClass");
                      log("Selected Section = $selectedSection");
                      log("Selected Date =  ${dateInput.text}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeacherViewAttendanceDayWise(
                            selectedClass: selectedClass,
                            selectedSection: selectedSection,
                            selectedDate: dateInput.text,
                          ),
                        ),
                      );
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
}

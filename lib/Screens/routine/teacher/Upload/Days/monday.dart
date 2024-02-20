import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:school_management_system/Services/teacher_shared_service.dart';
import 'package:school_management_system/constants/style.dart';
import 'dart:convert';

import '../../../../../widget/Button/my_elevatedbutton.dart';

var dayID = "";

class Monday extends StatefulWidget {
  String selectedClass;
  String selectedSection;
  Monday(
      {super.key, required this.selectedClass, required this.selectedSection});

  @override
  State<Monday> createState() => _MondayState();
}

class _MondayState extends State<Monday> {
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();
  final List<PeriodData> timetableData = [];
  List<Widget> cardWidgets = [];
  TimeOfDay? _selectedTime;

  var flag;

  bool isEditing = false;
  PeriodData? selectedPeriod;

  String selectedPeriodOption = "1"; // Initial dropdown value
  List<String> periodOptions = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10"
  ];

  void populateTextFields(PeriodData periodData) {
    setState(() {
      selectedPeriodOption = "${periodData.period}";
      t2.text = periodData.startTime;
      t3.text = periodData.endTime;
      t4.text = periodData.subject;
      t5.text = periodData.teacher;
      selectedPeriod = periodData;
      isEditing = true;
    });
  }

  void clearTextFields() {
    setState(() {
      selectedPeriodOption = "1";
      t2.clear();
      t3.clear();
      t4.clear();
      t5.clear();
      selectedPeriod = null;
      isEditing = false;
    });
  }

  void showPostSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Timetable uploaded successfully'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void showUpdateSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Text('Timetable Updated Successfully'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _selectTime1(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        t2.text = _selectedTime!.format(context);
      });
    }
  }

  Future<void> _selectTime2(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        t3.text = _selectedTime!.format(context);
      });
    }
  }

  void deletePeriod(int index) {
    setState(() {
      timetableData.removeAt(index);
      clearTextFields();
      cardWidgets = timetableData.map((periodData) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Period: ${periodData.period}",
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      Text("Start Time:  ${periodData.startTime}"),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("End Time:  ${periodData.endTime}"),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("Subject:  ${periodData.subject}"),
                      const SizedBox(
                        height: 3,
                      ),
                      Text("Teacher Name:  ${periodData.teacher}"),
                      const SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          populateTextFields(periodData);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          deletePeriod(timetableData.indexOf(periodData));
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      }).toList();
    });
  }

  void updatePeriod() {
    setState(() {
      if (selectedPeriod != null) {
        selectedPeriod!.period = int.tryParse(selectedPeriodOption) ?? 0;
        selectedPeriod!.startTime = t2.text;
        selectedPeriod!.endTime = t3.text;
        selectedPeriod!.subject = t4.text;
        selectedPeriod!.teacher = t5.text;
        isEditing = false;
        clearTextFields();

        cardWidgets = timetableData.map((periodData) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(color: deepBlue),
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Period: ${periodData.period}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Start Time:  ${periodData.startTime}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("End Time:  ${periodData.endTime}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("Subject:  ${periodData.subject}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("Teacher Name:  ${periodData.teacher}"),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              populateTextFields(periodData);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              deletePeriod(timetableData.indexOf(periodData));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList();
      }
    });
  }

  Future<void> postData() async {
    final apiUrl = Uri.parse(
        "http://13.232.53.26:3000/teacher/${TeacherSharedServices.loginDetails()?.data?.id}/setWeeklyTimeTable");
    log(apiUrl.toString());
    final inputData = {
      "day": "Monday",
      "class": widget.selectedClass,
      "section": widget.selectedSection,
      "timeTable": timetableData.map((periodData) {
        return {
          "period": {
            "period": periodData.period,
            "startTime": periodData.startTime,
            "endTime": periodData.endTime,
            "subject": periodData.subject,
            "teacherName": periodData.teacher,
          }
        };
      }).toList(),
    };

    final response = await http.post(
      apiUrl,
      body: jsonEncode(inputData),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': '${TeacherSharedServices.loginDetails()?.data?.token}',
      },
    );
    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      showPostSnackbar();
      log("Data saved successfully.");
    } else {
      log("Failed to save data.");
    }
  }

  Future<void> updateData() async {
    final updateApiUrl = Uri.parse(
        "http://13.232.53.26:3000/teacher/${TeacherSharedServices.loginDetails()?.data?.id}/updateTimeTable-day/$dayID");
    log(updateApiUrl.toString());
    final inputData = {
      "day": "Monday",
      "class": widget.selectedClass,
      "section": widget.selectedSection,
      "timeTable": timetableData.map((periodData) {
        return {
          "period": {
            "period": periodData.period,
            "startTime": periodData.startTime,
            "endTime": periodData.endTime,
            "subject": periodData.subject,
            "teacherName": periodData.teacher,
          }
        };
      }).toList(),
    };

    final response = await http.put(
      updateApiUrl,
      body: jsonEncode(inputData),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': '${TeacherSharedServices.loginDetails()?.data?.token}',
      },
    );

    if (response.statusCode == 200) {
      showUpdateSnackbar();
      log("Data updated successfully.");
    } else {
      log("Failed to update data. Status Code: ${response.statusCode}");
      log("Response Body: ${response.body}");
    }
  }

  Future<void> fetchData() async {
    final apiUrl = Uri.parse(
        "http://13.232.53.26:3000/teacher/${TeacherSharedServices.loginDetails()?.data?.id}/dayWiseTimeTable?class=${widget.selectedClass}&day=Monday&section=${widget.selectedSection}");

    final Map<String, String> headers = {
      'Authorization':
          '${TeacherSharedServices.loginDetails()?.data?.token}', // Add your token here
      'Content-Type': 'application/json',
    };

    final response = await http.get(apiUrl, headers: headers);
    log(response.body);
    log(response.statusCode.toString());

    if (response.statusCode == 200) {
      flag = true;
      final jsonResponse = jsonDecode(response.body);
      final timeTableData = jsonResponse['data']['timeTable'];
      var day_id = jsonResponse['data']['_id'];
      dayID = day_id;
      setState(() {
        cardWidgets.clear();
        for (var periodData in timeTableData) {
          timetableData.add(PeriodData(
            period: periodData['period']['period'],
            startTime: periodData['period']['startTime'],
            endTime: periodData['period']['endTime'],
            subject: periodData['period']['subject'],
            teacher: periodData['period']['teacherName'],
          ));
        }

        cardWidgets = timetableData.map((periodData) {
          return Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: deepBlue),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Period: ${periodData.period}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 17),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 5,
                          ),
                          Text("Start Time :  ${periodData.startTime}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("End Time:  ${periodData.endTime}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("Subject:  ${periodData.subject}"),
                          const SizedBox(
                            height: 3,
                          ),
                          Text("Teacher Name:  ${periodData.teacher}"),
                          const SizedBox(
                            height: 3,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              populateTextFields(periodData);
                            },
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              deletePeriod(timetableData.indexOf(periodData));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }).toList();
      });
    } else {
      flag = false;
      log("Failed to fetch data from the API");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.grey[100],
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedPeriodOption,
                    onChanged: (newValue) {
                      setState(() {
                        selectedPeriodOption = newValue!;
                      });
                    },
                    items: periodOptions.map((String option) {
                      return DropdownMenuItem<String>(
                        value: option,
                        child: Text(option),
                      );
                    }).toList(),
                    decoration: const InputDecoration(
                      labelText: "Select Period",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  TextField(
                    controller: t2,
                    onTap: () async {
                      await _selectTime1(context);
                    },
                    decoration: const InputDecoration(
                      hintText: "Start Time",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  TextField(
                    controller: t3,
                    onTap: () async {
                      await _selectTime2(context);
                    },
                    decoration: const InputDecoration(
                      hintText: "End Time",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  TextField(
                    controller: t4,
                    decoration: const InputDecoration(
                      hintText: "Subject",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  TextField(
                    controller: t5,
                    decoration: const InputDecoration(
                      hintText: "Teacher Name",
                      contentPadding: EdgeInsets.all(10),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (!isEditing)
                    MyElevatedButton(
                      onPressed: () {
                        final periodData = PeriodData(
                          period: int.tryParse(selectedPeriodOption) ?? 0,
                          startTime: t2.text,
                          endTime: t3.text,
                          subject: t4.text,
                          teacher: t5.text,
                        );

                        timetableData.add(periodData);

                        t2.clear();
                        t3.clear();
                        t4.clear();
                        t5.clear();
                        cardWidgets = timetableData.map((periodData) {
                          return Container(
                            margin: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: deepBlue),
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Period: ${periodData.period}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                              "Start Time:  ${periodData.startTime}"),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              "End Time:  ${periodData.endTime}"),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              "Subject:  ${periodData.subject}"),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              "Teacher Name:  ${periodData.teacher}"),
                                          const SizedBox(
                                            height: 3,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(
                                              Icons.edit,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              populateTextFields(periodData);
                                            },
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              deletePeriod(timetableData
                                                  .indexOf(periodData));
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList();

                        setState(() {});
                      },
                      child: const Text(
                        "Add Period",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  if (isEditing)
                    MyElevatedButton(
                      onPressed: updatePeriod,
                      child: const Text(
                        "Update Period",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.37,
                    child: ListView(
                      children: cardWidgets,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        ElevatedButton(
          onPressed: () async {
            if (timetableData.isNotEmpty && flag == true) {
              await updateData();
            } else {
              await postData();
            }
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.grey,
            backgroundColor: const Color.fromRGBO(98, 120, 247, 1.0),
            shape: const LinearBorder(),
            minimumSize: Size(MediaQuery.of(context).size.width, 60),
          ),
          child: Text(
            flag == true ? "UPDATE" : "SUBMIT",
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
      ],
    );
  }
}

class PeriodData {
  int period;
  String startTime;
  String endTime;
  String subject;
  String teacher;

  PeriodData({
    required this.period,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.teacher,
  });
}

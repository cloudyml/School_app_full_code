import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Teacher/Exam/teacher_see_list_of_exam_types_response_model.dart';

import '../../../../Services/api_services/teacher_api_services.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/appbar_widget.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import 'create_type_notification.dart';
import 'teacher_choose_class_for_set_exam_routine.dart';

class TeacherSelectExamType extends StatefulWidget {
  const TeacherSelectExamType({super.key});

  @override
  State<TeacherSelectExamType> createState() => _TeacherSelectExamTypeState();
}

class _TeacherSelectExamTypeState extends State<TeacherSelectExamType> {
  late Future<TeacherSeeExamTypesResponseModel> _examTypeList;

  @override
  void initState() {
    super.initState();
    _examTypeList = TeacherApiServices.teacherSeeListOfExamTypes();
  }

  final listOfTypes = <String>[].obs;
  final examListId = "".obs;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateExamTypeAndNotification(
                          examTypeList: listOfTypes.value,
                          examListId: examListId.value,
                        )));
          },
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.sp),
              side: BorderSide(color: deepBlue)),
          child: Icon(Icons.add)),
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
      body: Column(
        children: [
          const Text(
            "Select exam to upload routine",
            style: TextStyle(
                fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: 10.sp,
          ),
          Expanded(
            child: FutureBuilder(
                future: _examTypeList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData) {
                    return Center(child: Text('There are no exams.'));
                  } else if (snapshot.data == null || snapshot.data!.data == null) {
                    return Center(child: Text('There are no exams.'));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data!.data!.examTypeList!.length,
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, examIndex) {
                        String initials = extractInitials(
                            snapshot.data!.data!.examTypeList![examIndex]);
                        String examType =
                            snapshot.data!.data!.examTypeList![examIndex];
                        listOfTypes.value = snapshot.data!.data!.examTypeList!;
                        examListId.value = snapshot.data!.data!.id!;
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: height * 0.02,
                              horizontal: width * 0.27),
                          child: InkWell(
                            onLongPress: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text(
                                          "Do you want to delete this exam type?"),
                                      actions: [
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            onPressed: () async {
                                              await TeacherApiServices
                                                  .deleteExamType(context,
                                                      examListId: examListId,
                                                      testName: examType);
                                              Navigator.pop(context);
                                            },
                                            child: Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Cancel")),
                                      ],
                                    );
                                  });
                            },
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherChooseClassForUploadExamRoutine(
                                              testType: "$examType")));
                            },
                            child: Container(
                              height: height * 0.16,
                              width: width * 0.46,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(
                                        3, 3), // Offset in the Y direction
                                  ),
                                ],
                                border: Border.all(color: deepBlue),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: deepBlue,
                                    radius: width * 0.07,
                                    child: Text(
                                      "$initials",
                                      style: GoogleFonts.kalam(
                                          fontSize: width * 0.06,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${examType}",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: width * 0.06),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                }),
          ),
        ],
      ),
    );
  }

  String extractInitials(String name) {
    List<String> words = name.split(" ");
    String initials = '';

    for (String word in words) {
      if (word.isNotEmpty) {
        initials += word[0];
      }
    }

    return initials.toUpperCase();
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Teacher/Exam/teacher_see_list_of_exam_types_response_model.dart';
import 'package:school_management_system/Screens/Result/Teacher/Upload/choose_class_section_for_upload_result.dart';
import 'package:school_management_system/Screens/Result/Teacher/View/choose_class_section_to_view_result.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';
import 'package:school_management_system/widget/teacher/Exam/exam_types_card.dart';

class TeacherSelectResultTypeForViewResult extends StatelessWidget {
  const TeacherSelectResultTypeForViewResult({Key? key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
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
      body: FutureBuilder<TeacherSeeExamTypesResponseModel>(
        future: TeacherApiServices.teacherSeeListOfExamTypes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data!.data == null){
            return Center(
              child: Text('No data available.'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No data available.'),
            );
          }
          TeacherSeeExamTypesResponseModel? examTypes = snapshot.data;
          return ListView.builder(
            itemCount: examTypes?.data?.examTypeList?.length ?? 0,
            itemBuilder: (context, index) {
              return ExamTypesCard(
                examTypeName: examTypes!.data!.examTypeList![index],
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeacherChooseClassForSeeResult(
                        testType: examTypes.data!.examTypeList![index],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

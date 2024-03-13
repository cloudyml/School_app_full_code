// import 'package:flutter/material.dart';
// import 'package:school_management_system/Models/Teacher/Result/class_wise_result_response_model.dart';
// import 'package:school_management_system/Screens/Result/Teacher/View/subject_wise_result_view.dart';
// import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
// import 'package:school_management_system/constants/style.dart';
// import 'package:school_management_system/widget/appBar/appbar_widget.dart';
// import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';
// import 'package:school_management_system/widget/teacher/Result/subject_list_of_teacher_card.dart';

// class ShowSubjectListOfTeacher extends StatelessWidget {
//   final String selectedClass;
//   final String testType;
//   const ShowSubjectListOfTeacher(
//       {super.key, required this.selectedClass, required this.testType});

//   @override
//   Widget build(BuildContext context) {
//     double containerSize = MediaQuery.of(context).size.width / 8;
//     return Scaffold(
//         backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
//         appBar: PreferredSize(
//           preferredSize: const Size.fromHeight(300),
//           child: DecorativeAppBar(
//             barHeight: MediaQuery.of(context).size.height * 0.24,
//             barPad: MediaQuery.of(context).size.height * 0.19,
//             radii: 30,
//             background: Colors.white,
//             gradient1: lightBlue,
//             gradient2: deepBlue,
//             extra: appbar(
//                 "assets/flaticon/_assignments.png", "Assignments", context, () {
//               Navigator.pop(context);
//             }),
//           ),
//         ),
//         body: FutureBuilder<ClassWiseResultResponseModel>(
//             future: TeacherApiServices.teacherViewResultClassWise(
//                 selectedClass, testType),
//             builder: (context, snapshot) {
//               ClassWiseResultResponseModel? result = snapshot.data;
//               return ListView.builder(
//                   itemCount: result?.data?.length,
//                   itemBuilder: (context, index) {
//                     return SubjectListCard(
//                       subject: result!.data![index].subject.toString(),
//                       onPress: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             // ignore: prefer_const_constructors
//                             builder: (context) => SubjectWiseResultView(
//                               resultDataList:
//                                   result.data?[index].studentList as List,
//                               resultId:
//                                   snapshot.data!.data![index].id.toString(),
//                             ),
//                           ),
//                         );
//                       },
//                     );
//                   });
//             }));
//   }
// }

//......

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Teacher/Result/Get%20models/class_wise_result_response_model.dart';
import 'package:school_management_system/Screens/Result/Teacher/View/subject_wise_result_view.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';
import 'package:school_management_system/widget/teacher/Result/subject_list_of_teacher_card.dart';

class ShowSubjectListOfTeacher extends StatelessWidget {
  final String selectedClass;
  final String selectedSection;
  final String testType;

  const ShowSubjectListOfTeacher(
      {super.key,
      required this.selectedClass,
      required this.selectedSection,
      required this.testType});

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder<ClassWiseResultResponseModel>(
        future: TeacherApiServices.teacherViewResultClassWise(
            selectedClass, selectedSection, testType),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.data!.data!.isEmpty) {
            return const Center(
              child: Text('No data available'),
            );
          } else {
            ClassWiseResultResponseModel? result = snapshot.data;
            return ListView.builder(
              itemCount: result?.data?.length,
              itemBuilder: (context, index) {
                return SubjectListCard(
                  subject: result!.data![index].subject.toString(),
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SubjectWiseResultView(
                          resultDataList:
                              result.data?[index].studentList as List,
                          resultId: result.data![index].id.toString(),
                        ),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

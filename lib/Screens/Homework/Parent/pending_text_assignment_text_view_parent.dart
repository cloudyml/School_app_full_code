import 'package:flutter/material.dart';
import 'package:school_management_system/Models/Student/student_tex_assignment_submitted_model.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class ParentPendingTextAsignmentDetailScreen extends StatelessWidget {
  ParentPendingTextAsignmentDetailScreen(
      {super.key, required this.assignmentdata});
  List<DatumTextAssignmentList>? assignmentdata;

  @override
  Widget build(BuildContext context) {
    // LaunceToWeb Launceweb = LaunceToWeb();
    return Scaffold(
        backgroundColor: Colors.white,
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
            extra: appbar(
                "assets/flaticon/_assignments.png", " Homework", context, () {
              Navigator.pop(context);
            }),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(assignmentdata!.length, (index) {
            return Container(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Q${index + 1}. ${assignmentdata![index].question}",
                      style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w500)),
                ],
              ),
            );
          }),
        )));
  }
}

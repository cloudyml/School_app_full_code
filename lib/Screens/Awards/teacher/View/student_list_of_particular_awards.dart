import 'package:flutter/material.dart';
import 'package:school_management_system/Screens/Awards/teacher/View/award_of_particular_student.dart';
import 'package:school_management_system/widget/teacher/Awards/students_list_awards_card.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/appbar_widget.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';

class StudentListOfParticularAwards extends StatelessWidget {
  final List studentListAwards;
  final List studentClassList;
  const StudentListOfParticularAwards(
      {super.key,
      required this.studentListAwards,
      required this.studentClassList});

  @override
  Widget build(BuildContext context) {
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
              extra: appbar(
                "assets/add_events.png",
                "View Awards",
                context,
                () {
                  Navigator.pop(context);
                },
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.75,
              child: ListView.builder(
                  itemCount: studentListAwards.length,
                  itemBuilder: (context, index) {
                    return StudentDetilsAwardsCard(
                      studentName:
                          studentListAwards[index].studentName.toString(),
                      studentRoll:
                          studentListAwards[index].rollNumber.toString(),
                      studentClass: studentClassList[index].toString(),
                      section: studentListAwards[index].section.toString(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AwardListOfParticularStudents(
                                        awardsLink: studentListAwards[index]
                                            .uploadedImage
                                            .link
                                            .toString())));
                      },
                    );
                  }),
            )
          ],
        ));
  }
}

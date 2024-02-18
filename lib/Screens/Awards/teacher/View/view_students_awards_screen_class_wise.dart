import 'package:flutter/material.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import '../../../../Models/Teacher/Awards/heading_wise_awards_list_response_model.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/appbar_widget.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../../widget/teacher/Awards/heading_wise_awards_card.dart';
import 'student_list_of_particular_awards.dart';

class ViewAwardsOfClassScreen extends StatelessWidget {
  const ViewAwardsOfClassScreen({super.key});

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
          barPad: MediaQuery.of(context).size.height * 0.19,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: appbar("assets/awards.png", "View Awards", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: FutureBuilder<HeadingWiseAwardsListOfStudentsResponseModel>(
        future: TeacherApiServices.awardsListOfStudents(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Handle error
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.data!.isEmpty) {
            return const Center(
              child: Text(
                'No awards found',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          } else {
            HeadingWiseAwardsListOfStudentsResponseModel? awards =
                snapshot.data;

            return awards?.data?.length == null
                ? const Center(
                    child: Text("No Data found"),
                  )
                : ListView.builder(
                    itemCount: awards!.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: HeadingWiseViewAwardsCard(
                          eventname: awards.data![index].certificationHeading
                              .toString(),
                          eventDate:
                              awards.data![index].certificationDate as DateTime,
                          onPressed: () {
                            List studentClasslist = [];
                            for (var i = 0;
                                i < awards.data![index].studentList!.length;
                                i++) {
                              studentClasslist.add(awards.data![index]
                                  .studentList![i].studentListClass);
                            }
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    StudentListOfParticularAwards(
                                  studentListAwards:
                                      awards.data![index].studentList as List,
                                  studentClassList: studentClasslist,
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  );
          }
        },
      ),
    );
  }
}

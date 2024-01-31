import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'package:school_management_system/Services/api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Parent/Assignments/pending_assignment_parent_card.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

import '../../../Models/Student/assignment_view_model.dart';
import '../../../Services/Url_launcher.dart/method.dart';



// added by Harsh it is the list view of all the pending assignment of his/her child 

class PendingAssignmentParent extends StatelessWidget {
  const PendingAssignmentParent({super.key});

  @override
  Widget build(BuildContext context) {
    LaunceToWeb Launceweb = LaunceToWeb();
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
                "assets/flaticon/_assignments.png", " Assignments", context,
                () {
              Navigator.pop(context);
            }),
          ),
        ),
        body: FutureBuilder<StudentViewAssignmentModel>(
          future: ApiServices.parentViewAssignment(),
          builder: (BuildContext context,
              AsyncSnapshot<StudentViewAssignmentModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("Error.."));
            } else if (!snapshot.hasData || snapshot.data?.data?.length == null ) {
              return const Center(
                child: Text("No Assignment available"),
              ); // Handle the case where there is no data
            } else {
              StudentViewAssignmentModel studentAssignment = snapshot.data!;

              return ListView.builder(
                itemCount: studentAssignment.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  String formattedGivenDate = DateFormat('dd-MM-yy').format(
                    DateTime.parse(
                      studentAssignment.data![index].lastDateOfSubmit.toString(),
                    ),
                  );
                  String formattedSubmitDate = DateFormat('dd-MM-yy').format(
                    DateTime.parse(
                      studentAssignment.data![index].lastDateOfSubmit
                          .toString(),
                    ),
                  );

                  return ParentPendingAssignmentViewCard(
                    subject: studentAssignment.data![index].subject.toString(),
                    givenDate: formattedGivenDate,
                    submitDate: formattedSubmitDate,
                    docUrl: studentAssignment.data![index].uploadedImage.link.toString(),
                    assignmentID: studentAssignment.data![index].id.toString(),
                  );
                },
              );
            }
          },
        ));
  }
}

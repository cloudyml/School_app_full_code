import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:school_management_system/Screens/Payment/teacher_choose_class_section_for_payment_request_accept.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';
import '../../../Models/Student/Fees/student_fee_response_model.dart';
import '../../../constants/style.dart';
import '../teacher/upload_fees.dart';

class TeacherSeeFees extends StatefulWidget {
  const TeacherSeeFees({Key? key}) : super(key: key);

  @override
  State<TeacherSeeFees> createState() => _StudentSeeFeesState();
}

class _StudentSeeFeesState extends State<TeacherSeeFees> {
  showAlertDialog(BuildContext context, VoidCallback onPress) {
    Widget cancelButton = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("Cancel"));
    Widget deletelButton = TextButton(
        onPressed: () {
          onPress();
        },
        child: const Text("Delete"));

    AlertDialog alert = AlertDialog(
      title: const Text("Delete Fees"),
      actions: [cancelButton, deletelButton],
      content:
          const Text("Would you like to continue delete fess of this class?"),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
            extra: appbar("assets/flaticon/_fees.png", " Fees", context, () {
              Navigator.pop(context);
            }),
          ),
        ),
        body: FutureBuilder<StudentFeesDetailsModel>(
          future: TeacherApiServices.teacherViewFees(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No data found"));
            } else if (snapshot.data == null ||
                snapshot.data!.data == null ||
                snapshot.data!.data!.isEmpty) {
              return const Center(child: Text("No data found"));
            } else {
              StudentFeesDetailsModel fees = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: fees.data!.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 20, top: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: deepBlue),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Colors.grey,
                                spreadRadius: 2,
                                offset: Offset(3, 5),
                              )
                            ],
                          ),
                          height: MediaQuery.of(context).size.height * 0.38,
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => UploadFees(
                                      feesModel: fees.data![index])));
                            },
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(
                              "Class: ${fees.data![index].datumClass}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            subtitle: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Admission Fees: "),
                                    Text("${fees.data![index].admissionFees}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Exam Fees: "),
                                    Text(
                                        "${fees.data![index].examinationFees}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Tuition Fees: "),
                                    Text("${fees.data![index].tuitionFees}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Library Deposit: "),
                                    Text("${fees.data![index].libraryFees}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Transport Fees: "),
                                    Text("${fees.data![index].transportFees}"),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Miscellaneous Fees: "),
                                    Text(
                                      "${fees.data![index].miscellaneousFees}",
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Fees ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${fees.data![index].totalFees?.toInt()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Dicount ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${fees.data![index].discountPercentage} %",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${fees.data![index].discountAmount?.toInt()}",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.green,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Total Payable ",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${fees.data![index].discountedFees?.toInt()}",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 10,
                          right: 10,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => UploadFees(
                                          feesModel: fees.data![index]),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  showAlertDialog(context, () {
                                    TeacherApiServices.deleteFees(
                                            fees.data![index].id.toString())
                                        .then((value) {
                                      if (value == true) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const TeacherSeeFees()));
                                      }
                                    });
                                  });
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ))
                    ],
                  );
                },
              );
            }
          },
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: deepBlue,
        //   onPressed: () {
        //     Navigator.of(context).push(
        //         MaterialPageRoute(builder: (context) => const UploadFees()));
        //   },
        //   child: const Text(
        //     "Add",
        //     style: TextStyle(color: Colors.white),
        //   ),
        // ),
        floatingActionButtonLocation: ExpandableFab.location,
        floatingActionButton: ExpandableFab(
          openButtonBuilder: RotateFloatingActionButtonBuilder(
            child: const Icon(Icons.add),
            fabSize: ExpandableFabSize.regular,
            foregroundColor: Colors.white,
            backgroundColor: deepBlue,
            shape: const CircleBorder(),
          ),
          closeButtonBuilder: DefaultFloatingActionButtonBuilder(
            child: const Icon(Icons.close),
            fabSize: ExpandableFabSize.small,
            foregroundColor: Colors.white,
            backgroundColor: Colors.deepOrangeAccent,
            shape: const CircleBorder(),
          ),
          children: [
            FloatingActionButton.large(
              heroTag: "Button1",
              backgroundColor: deepBlue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const UploadFees()));
              },
              child: Text("Fees", style: TextStyle(color: Colors.white)),
            ),
            FloatingActionButton.large(
              heroTag: "Button2",
              backgroundColor: deepBlue,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        const TeacherChooseClassForPaymentRequestAccept()));
              },
              child: Text(
                "Payment",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}

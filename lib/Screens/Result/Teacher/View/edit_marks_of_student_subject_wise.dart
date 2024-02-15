import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Dashboard.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import '../../../../../constants/style.dart';
import '../../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../../Services/api_services/teacher_api_services.dart';

class TeacherEditMarksOfResultSubjectWise extends StatefulWidget {
  final String resultId;
  final String studentId;
  final String marks;
  final String subject;
  const TeacherEditMarksOfResultSubjectWise(
      {super.key,
      required this.resultId,
      required this.studentId,
      required this.marks,
      required this.subject});

  @override
  State<TeacherEditMarksOfResultSubjectWise> createState() =>
      _TeacherEditMarksOfResultSubjectWiseState();
}

class _TeacherEditMarksOfResultSubjectWiseState
    extends State<TeacherEditMarksOfResultSubjectWise> {
  TextEditingController marksInput = TextEditingController();
  bool isClicked = false;
  @override
  void initState() {
    super.initState();
    marksInput.text = widget.marks;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.05,
                  right: width * 0.05,
                  top: height * 0.025,
                  bottom: 30),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Marks*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: marksInput,
                      decoration: InputDecoration(
                        hintText: "Enter marks",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
              ),
              child: MyElevatedButton(
                onPressed: () {
                  if (isClicked == false) {
                    setState(() {
                      isClicked = true;
                    });
                    TeacherApiServices.teacherUpdateResult(
                            marks: marksInput.text,
                            subject: widget.subject,
                            resultId: widget.resultId,
                            studentId: widget.studentId)
                        .then((value) {
                      if (value == true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Marks updated successfully'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Failed to update marks'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        setState(() {
                          isClicked = false;
                        });
                      }
                    });
                  }
                },
                child: const Text(
                  "SUBMIT",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Student/student_tex_assignment_submitted_model.dart';
import 'package:school_management_system/Screens/Dashboard.dart';
import 'package:school_management_system/Screens/Homework/Student/question_tile_text_assignment.dart';
import 'package:school_management_system/Services/api_services/api_services.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class TextSubmitModel {
  String questionKey = "question";
  String? question;
  String answerKey = "answer";
  String? answer;
  TextSubmitModel({this.answer, this.question});

  Map<String, dynamic> toJson() {
    return {questionKey: question, answerKey: answer};
  }
}

class DetailHomeworkScreenStudent extends StatefulWidget {
  DetailHomeworkScreenStudent({
    super.key,
    required this.listOfquestions,
    required this.assignmentId,
  });

  List<DatumTextAssignmentList> listOfquestions;
  String assignmentId;

  @override
  State<DetailHomeworkScreenStudent> createState() =>
      _DetailHomeworkScreenStudentState();
}

class _DetailHomeworkScreenStudentState
    extends State<DetailHomeworkScreenStudent> {
  List answeredList = [];
  int? indexForReference;
  SharedPreferences? instance;
  List<Map<String, String>>? textAssignmentList;

  TextEditingController answer = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initilizePref();
  }

  initilizePref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    instance = prefs;
    log("pref initilized ------> $instance");
    if (instance!.containsKey(widget.assignmentId)) {
      print(instance?.getStringList(widget.assignmentId));
      // for (int i = 0; i < widget.listOfquestions.length; i++) {
      answeredList.addAll(
          instance?.getStringList(widget.assignmentId) as List<dynamic>);
      setState(() {});
      for (int i = 0; i < answeredList.length; i++) {
        log(answeredList[i]);
      }
      // }

      ;
    } else {
      for (int i = 0; i < widget.listOfquestions.length; i++) {
        answeredList.add('Enter Answer');
        log(answeredList[i]);
      }
    }
  }

  var temp = "";
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> answerControllers =
        widget.listOfquestions.map((_) => TextEditingController()).toList();
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
              "assets/flaticon/_assignments.png", " Homework ", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              child: Column(
                children: List.generate(widget.listOfquestions.length, (index) {
                  setState(() {
                    indexForReference = index;
                  });
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () async {
                        int currentindex = index;
                        setState(() {
                          print(currentindex);
                        });

                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  // buttonPadding: EdgeInsets.all(0),
                                  contentPadding: const EdgeInsets.all(0),
                                  backgroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  content: Container(
                                    padding: const EdgeInsets.all(12),
                                    color: Colors.white,
                                    width: MediaQuery.sizeOf(context).width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Q${currentindex + 1} ${widget.listOfquestions[currentindex].question.toString()} ?",
                                              style: GoogleFonts.inter(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Color.fromARGB(
                                                      255, 255, 152, 127),
                                                  size: 32,
                                                ))
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        answeredList[index] != "Enter Answer"

                                            //If Some Vlaue is present Means After Edit it will be present
                                            ? TextFormField(
                                                maxLines: 5,
                                                minLines: 1,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      500)
                                                ],
                                                initialValue:
                                                    answeredList[currentindex],
                                                onChanged: (value) {
                                                  //for re Editing the answer
                                                  temp = value;
                                                },
                                                decoration: InputDecoration(
                                                  fillColor: Colors.yellow,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                              )

                                            //If its by default value enter answer
                                            : TextFormField(
                                                maxLines: 5,
                                                minLines: 1,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      500)
                                                ],
                                                controller: answerControllers[
                                                    currentindex],
                                                decoration: InputDecoration(
                                                  fillColor: Colors.red,
                                                  filled: true,
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                              )

                                        //initially this will be there
                                        ,
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(58),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    setState(() {
                                                      temp == ""
                                                          ? answeredList[
                                                                  currentindex] =
                                                              answerControllers[
                                                                      currentindex]
                                                                  .text
                                                          : answeredList[
                                                                  currentindex] =
                                                              temp;
                                                      temp = "";
                                                    });
                                                    for (int i = 0;
                                                        i < answeredList.length;
                                                        i++) {
                                                      print(answeredList[i]);
                                                    }
                                                  },
                                                  child: Text(
                                                    "Save",
                                                    style: GoogleFonts.inter(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(58),
                                                  border: Border.all(
                                                      color: Colors.black)),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    shadowColor:
                                                        Colors.transparent,
                                                  ),
                                                  onPressed: () {
                                                    if (answerControllers[
                                                                currentindex]
                                                            .text ==
                                                        "") {
                                                      // if (currentindex + 1 <
                                                      //     answerControllers
                                                      //         .length) {
                                                      //   setState(() {
                                                      //     currentindex =
                                                      //         currentindex + 1;
                                                      //     print(currentindex);
                                                      //   });
                                                      // }
                                                    } else {
                                                      setState(() {
                                                        temp == ""
                                                            ? answeredList[
                                                                    currentindex] =
                                                                answerControllers[
                                                                        currentindex]
                                                                    .text
                                                            : answeredList[
                                                                    currentindex] =
                                                                temp;
                                                      });
                                                    }

                                                    if (currentindex + 1 <
                                                        answerControllers
                                                            .length) {
                                                      Navigator.pop(context);
                                                      // setState(() {
                                                      //   currentindex =
                                                      //       currentindex + 1;
                                                      //   print(currentindex);
                                                      //   print(temp);
                                                      //   print("This is the value of the list "+answeredList[currentindex]);
                                                      //   print("This is the value of the TextEditing COntroller "+answerControllers[currentindex].text);
                                                      // });
                                                    }
                                                    answerControllers[
                                                            currentindex]
                                                        .clear();
                                                  },
                                                  child: Text(
                                                    "Next Question",
                                                    style: GoogleFonts.inter(
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.04,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  )),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).whenComplete(() {
                          setState(() {});
                        });
                      },
                      child: QuestionAnswerTileTextHomework(
                        answer: index < answeredList.length
                            ? answeredList[index]
                            : "Enter Answer",
                        index: index,
                        question:
                            widget.listOfquestions[index].question.toString(),
                      ),
                    ),
                  );
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyElevatedButton(
                        // height: 40,
                        onPressed: () {
                          List<TextSubmitModel> sendAnswerLIst = [];
                          for (int i = 0; i < answeredList.length; i++) {
                            if (answeredList[i] == "Enter Answer") {
                              sendAnswerLIst.add(TextSubmitModel(
                                  question: widget.listOfquestions[i].question,
                                  answer: "Not Answered"));
                            } else {
                              // for (int i = 0; i < sendAnswerLIst.length; i++) {

                              // }
                              sendAnswerLIst.add(TextSubmitModel(
                                  question: widget.listOfquestions[i].question,
                                  answer: answeredList[i]));
                              // log(sendAnswerLIst[i].questionKey.toString());
                              // log(sendAnswerLIst[i].answer.toString());
                            }
                          }

                          String jsonData = jsonEncode(
                              sendAnswerLIst.map((e) => e.toJson()).toList());

                          log(jsonEncode(jsonData));
                          log(jsonDecode(jsonEncode(jsonData)));
                          ApiServices.studentUploadAssignmentText(
                                  widget.assignmentId, jsonData)
                              .whenComplete(() {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return const Dashboard();
                              },
                            ));
                            EasyLoading.showSuccess("Uploaded Successfully");
                            instance?.remove(widget.assignmentId);
                            // ApiServices.studentSeeAssignmentText(
                            //     "getPendingAssignment", "text");
                          });
                          // ApiServices.StudentSubmittedAssignment()
                          for (int i = 0; i < sendAnswerLIst.length; i++) {
                            log(sendAnswerLIst[i].question.toString());
                            log(sendAnswerLIst[i].answer.toString());
                          }
                        },
                        child: Text(
                          "Submit",
                          style: GoogleFonts.inter(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(58),
                          border: Border.all(
                            color: const Color.fromARGB(255, 157, 32, 23),
                          ),
                        ),
                        child: MyElevatedButton(
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 242, 156, 150),
                            Color.fromARGB(255, 242, 156, 150)
                          ]),
                          height: 40,
                          onPressed: () {
                            //widget.assignmentId
                            if (answeredList.isEmpty) {
                              EasyLoading.showError(
                                  "Enter Data Else Cant save In Draft");
                            } else {
                              instance
                                  ?.setStringList(
                                      widget.assignmentId,
                                      answeredList
                                          .map((item) => item.toString())
                                          .toList())
                                  .whenComplete(() {
                                EasyLoading.showSuccess("Saved in Draft");
                              });
                              //////////////////////////////////////////////////////////////////////////////////
// answeredList[indexForReference!] = ,

                              print(
                                  instance?.getStringList(widget.assignmentId));
                            }
                          },
                          child: Text(
                            "Save As Draft",
                            style: GoogleFonts.inter(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                              color: const Color.fromARGB(255, 157, 32, 23),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "*Note Once Submitted Cant be edited",
                    style: GoogleFonts.inter(
                      fontSize: MediaQuery.of(context).size.width * 0.03,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

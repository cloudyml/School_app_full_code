
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Homework/Student/question_tile_text_assignment.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import '../../../constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class TextSubmitModel {
  String question = "question";
  String? answer;
  TextSubmitModel({this.answer});
}

class ShowDetailHomeworkScreen extends StatefulWidget {
  ShowDetailHomeworkScreen({
    super.key,
    required this.listOfquestions,
  });

  List listOfquestions;

  @override
  State<ShowDetailHomeworkScreen> createState() =>
      _ShowDetailHomeworkScreenState();
}

class _ShowDetailHomeworkScreenState extends State<ShowDetailHomeworkScreen> {
  List answeredList = [];

  TextEditingController answer = TextEditingController();
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
              "assets/flaticon/_assignments.png", " Homework", context, () {
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
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () async {
                        int currentindex = index;

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
                                              "Q${index + 1} ${widget.listOfquestions[index]["question"].toString()} ?",
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
                                        index < answeredList.length
                                            ? answeredList[index] !=
                                                    "Enter Answer"

                                                //If Some Vlaue is present Means After Edit it will be present
                                                ? TextFormField(
                                                    maxLines: 5,
                                                    minLines: 1,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          500)
                                                    ],
                                                    initialValue:
                                                        answeredList[index],
                                                    onChanged: (value) {
                                                      //for re Editing the answer
                                                      temp = value;
                                                    },
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
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
                                                    controller:
                                                        answerControllers[
                                                            index],
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .grey),
                                                      ),
                                                    ),
                                                  )

                                            //initially this will be there
                                            : TextFormField(
                                                maxLines: 5,
                                                minLines: 1,
                                                inputFormatters: [
                                                  LengthLimitingTextInputFormatter(
                                                      500)
                                                ],
                                                controller:
                                                    answerControllers[index],
                                                decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                              ),
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
                                                          ? answeredList.add(
                                                              answerControllers[
                                                                      index]
                                                                  .text)
                                                          : answeredList
                                                              .add(temp);
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
                                                    setState(() {
                                                      index + 1;
                                                    });
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
                        question: widget.listOfquestions[index]["question"]
                            .toString(),
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
                        onPressed: () {},
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
                            )),
                        child: MyElevatedButton(
                          gradient: const LinearGradient(colors: [
                            Color.fromARGB(255, 242, 156, 150),
                            Color.fromARGB(255, 242, 156, 150)
                          ]),
                          height: 40,
                          onPressed: () {},
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../constants/style.dart';
import '../../../../widget/appBar/appbar_widget.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import 'create_exam_type.dart';

class CreateExamTypeAndNotification extends StatelessWidget {
  List<String> examTypeList;
  String examListId;

  CreateExamTypeAndNotification(
      {super.key, required this.examTypeList, required this.examListId});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
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
          extra:
              appbar("assets/flaticon/_exam.png", "Examination", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(2, (index) {
            return Padding(
              padding: const EdgeInsets.only(top: 30),
              child: InkWell(
                onTap: () {
                  if (index == 0) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateExamTypeView(
                                  examTypeList: examTypeList,
                                  examListId: examListId,
                                )));
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.50,
                  height: MediaQuery.of(context).size.height * 0.20,
                  decoration: BoxDecoration(
                      border: Border.all(color: deepBlue),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Colors.grey,
                          offset: Offset(0, 3),
                          //  spreadRadius: 3,
                        ),
                      ]),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.14,
                        child: Image.asset("assets/upload.png"),
                      ),
                      Text(
                        texts[index],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  List texts = ["Create exam type", "Send exam notification"];
}

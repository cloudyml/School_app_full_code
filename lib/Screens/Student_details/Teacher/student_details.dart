import 'package:flutter/material.dart';

import '../../../constants/style.dart';
import '../../../widget/appBar/appbar_widget.dart';
import '../../../widget/appBar/decorative_apbar_widget.dart';

class StudentDetails extends StatelessWidget {
  final index;

  StudentDetails({this.index, super.key});

  @override
  Widget build(BuildContext context) {
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
          extra: appbar(
              "assets/flaticon/student.png", "Student Name $index", context,
              () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                // height: 150,
                padding: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    rowOfNames(label: "Name", text: "Student Name $index"),
                    rowOfNames(label: "Class", text: "$index"),
                    rowOfNames(label: "Section", text: "Section A")
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(8.0),
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("Attendance"),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.55,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: 15,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text("Date $index"),
                            );
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget rowOfNames({required String label, required String text}) {
    return Row(
      children: [
        Text("$label: ",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(text,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))
      ],
    );
  }
}

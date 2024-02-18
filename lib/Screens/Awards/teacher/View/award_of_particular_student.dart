import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class AwardListOfParticularStudents extends StatelessWidget {
  final String awardsLink;
  const AwardListOfParticularStudents({super.key, required this.awardsLink});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              color: Colors.white,
              child: Container(
                //  height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.height * 0.9,
                padding: const EdgeInsets.all(16),
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: deepBlue),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(awardsLink, fit: BoxFit.fill),
                ),
              )),
        ],
      ),
    );
  }
}

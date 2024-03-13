import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import '../../../Services/Url_launcher.dart/method.dart';

class TeacherFileNotSubmittedAssignmentCard extends StatelessWidget {
  final String name;
  final String roll;
  final String questionPaper;

  const TeacherFileNotSubmittedAssignmentCard({
    super.key,
    required this.name,
    required this.roll,
    required this.questionPaper,
  });

  @override
  Widget build(BuildContext context) {
    LaunceToWeb Launceweb = LaunceToWeb();
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
              spreadRadius: 2,
              offset: Offset(2, 8))
        ],
        color: Colors.white,
        border: Border.all(color: deepBlue),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Name : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold)),
                    Text(name,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Text("Roll : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold)),
                    Text(roll,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.grey)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyElevatedButton(
                onPressed: () {
                  Launceweb.launchweb(questionPaper);
                },
                child: const Text(
                  'Question File',
                  style: TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';

// ignore: must_be_immutable
class StudentDetilsAwardsCard extends StatelessWidget {
  final String studentName;
  final String studentRoll;
  final String studentClass;
  final String section;
  final VoidCallback onPressed;
  const StudentDetilsAwardsCard({
    super.key,
    required this.onPressed,
    required this.studentName,
    required this.studentRoll,
    required this.studentClass,
    required this.section,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: height * 0.26,
        width: width * 0.2,
        decoration: BoxDecoration(
          border: Border.all(color: deepBlue),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 3))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Student Name :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " $studentName",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Roll :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      studentRoll,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Class :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      studentClass,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Section :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      section,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              MyElevatedButton(
                  onPressed: onPressed,
                  child: const Text(
                    "View Award",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

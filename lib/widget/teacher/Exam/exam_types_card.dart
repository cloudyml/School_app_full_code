import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/constants/style.dart';

class ExamTypesCard extends StatelessWidget {
  final String examTypeName;
  final VoidCallback? onPress;
  const ExamTypesCard(
      {super.key, required this.examTypeName, required this.onPress});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: 10, bottom: 10, left: width * 0.2, right: width * 0.2),
      child: InkWell(
        onTap: onPress,
        child: Container(
          height: height * 0.18,
          width: width * 0.46,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(3, 3), // Offset in the Y direction
              ),
            ],
            border: Border.all(color: deepBlue),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              CircleAvatar(
                backgroundColor: deepBlue,
                radius: width * 0.09,
                child: Text(
                  "Exam",
                  style: GoogleFonts.kalam(
                      fontSize: width * 0.06,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                examTypeName,
                style: TextStyle(color: Colors.black, fontSize: width * 0.06),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

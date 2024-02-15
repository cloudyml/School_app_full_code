import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionAnswerTileTextHomework extends StatelessWidget {
  QuestionAnswerTileTextHomework({
    super.key,
    required this.answer,
    required this.index,
    required this.question,
  });
  int index;
  String? answer;
  String question;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Q${index + 1} $question ?",
          style: GoogleFonts.inter(
            fontSize: MediaQuery.of(context).size.width * 0.04,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          padding: EdgeInsets.all(8),
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            answer.toString(),
            style: GoogleFonts.inter(
              fontSize: MediaQuery.of(context).size.width * 0.04,
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

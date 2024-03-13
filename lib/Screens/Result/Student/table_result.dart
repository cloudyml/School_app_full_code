import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class TestResultsTable extends StatelessWidget {
  TestResultsTable({
    super.key,
    required this.comment,
    required this.marks,
    required this.grade,
    required this.subjectName,
    required this.index,
  });
  String subjectName;
  String marks;
  String grade;
  String comment;
  int index;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2.r),
      child: Table(
          border: TableBorder.all(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(2.r),
          ),
          columnWidths: const <int, TableColumnWidth>{
            0: FlexColumnWidth(1.5), // Subject
            1: FlexColumnWidth(1), // Marks
            2: FlexColumnWidth(1), // Grade
            3: FlexColumnWidth(2), // Comment
          },
          children: [
            TableRow(
              decoration: BoxDecoration(
                color: index % 2 == 0 ? Colors.white : Colors.grey[100],
                border: Border.all(),
              ),
              children: [
                SizedBox(
                    height: 0.05.sh,
                    child: Center(
                        child: Text(
                      subjectName.toUpperCase(),
                      style: GoogleFonts.inter(
                        letterSpacing: 1.0,
                        fontSize: 14.sp,
                      ),
                    ))),
                SizedBox(
                    height: 0.05.sh,
                    child: Center(
                        child: Text(
                      marks,
                      style: GoogleFonts.inter(
                        letterSpacing: 1.0,
                        fontSize: 14.sp,
                      ),
                    ))),
                SizedBox(
                    height: 0.05.sh,
                    child: Center(
                        child: Text(
                      grade,
                      style: GoogleFonts.inter(
                        letterSpacing: 1.0,
                        fontSize: 14.sp,
                      ),
                    ))),
                SizedBox(
                    height: 0.05.sh,
                    child: Center(
                        child: Text(
                      comment,
                      style: GoogleFonts.inter(
                        // color: Colors.black,
                        letterSpacing: 1.0,
                        fontSize: 14.sp,
                        // fontWeight: FontWeight.w600
                      ),
                    ))),
              ],
            ),
          ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/constants/style.dart';

class PdfPreviewPage extends StatelessWidget {
  final path;

  // pw.Document pdf;
  const PdfPreviewPage({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: const Text('PDF Preview'),
      ),
      body: PDFView(
        fitEachPage: true,
        filePath: path,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 8.0.w),
        child: Container(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            decoration: BoxDecoration(
                color: deepBlue, borderRadius: BorderRadius.circular(10.r)),
            child: Text(
              'Pdf Document is saved in Documents Folder Of Your Device',
              style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

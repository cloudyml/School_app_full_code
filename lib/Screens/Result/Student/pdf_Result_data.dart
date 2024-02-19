import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:school_management_system/Models/Student/Result/student_see_result_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:school_management_system/Screens/Result/Student/pdf_preview_page.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';

class MakeOfPdf {
  Future<void> makePdf(
      context, StudentResultResponseModel data, String examType) async {
    // Create a PDF document
    final pdf = pw.Document();

    //Add image logo to the pdf
    final ByteData schoolLogo = await rootBundle.load('assets/schoolLogo.jpg');

    Uint8List imageData = (schoolLogo).buffer.asUint8List();

    // Add a page with content
    // HEadings and the pragraph Values

    String formatDateTime(String date) {
      // Assuming the input date is in "yyyy-MM-dd" format
      final inputFormat = DateFormat("yyyy-MM-dd");
      final outputFormat =
          DateFormat("yyyy-MM-dd"); // Change this to your desired format
      final parsedDate = inputFormat.parse(date);
      return outputFormat.format(parsedDate);
    }

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.standard,
        margin: pw.EdgeInsets.symmetric(vertical: 25.w, horizontal: 15.w),
        build: (pw.Context context) => pw.Column(
          children: [
            pw.Header(
                padding: pw.EdgeInsets.all(8.h),
                decoration: pw.BoxDecoration(
                    border: pw.Border(
                        bottom:
                            pw.BorderSide(color: PdfColors.black, width: 2.h))),
                child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text("Result of " + examType,
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.bold, fontSize: 24.sp)),
                      pw.Text(
                          formatDateTime(
                              "${data.data?.data?.createdAt.toString()}"),
                          style: pw.TextStyle(
                              fontWeight: pw.FontWeight.normal,
                              fontSize: 24.sp))
                    ]),
                textStyle: pw.TextStyle(fontSize: 32.sp)),
            pw.SizedBox(height: 10.h),
            pw.Container(
              width: 150.h,
              height: 150.w,
              child: pw.Image(pw.MemoryImage(imageData), fit: pw.BoxFit.cover),
            ),
            pw.SizedBox(height: 25.h),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
              pw.Text("${data.data?.data?.schoolName?.toString()}",
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 22.sp)),
            ]),
            pw.SizedBox(height: 25.h),
            pw.Column(children: [
              pw.Row(children: [
                pw.Text("Name : ",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 20.sp)),
                pw.Text("${data.data?.data?.studentName?.toString()}",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 18.sp)),
              ]),
              pw.SizedBox(height: 5.h),
              pw.Row(children: [
                pw.Text("Roll No : ",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 20.sp)),
                pw.Text("${data.data?.data?.rollNumber?.toString()}",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 18.sp)),
              ]),
              pw.SizedBox(height: 5.h),
              pw.Row(children: [
                pw.Text("Marks Obtained : ",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 20.sp)),
                pw.Text(
                    "${data.data?.result?.totalMarks.toString()} / ${data.data?.result?.totalOutOffMarks.toString()}",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 18.sp)),
              ]),
              pw.SizedBox(height: 5.h),
              pw.Row(children: [
                pw.Text("Grade Obtained : ",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 20.sp)),
                pw.Text("${data.data?.result?.overAllGrades.toString()}",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 18.sp)),
              ]),
              pw.SizedBox(height: 5.h),
              pw.Row(children: [
                pw.Text("Percentage : ",
                    style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 20.sp)),
                pw.Text("${data.data?.result?.percentage.toString()}",
                    style: pw.TextStyle(
                        color: PdfColors.green,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 18.sp)),
              ]),
            ]),
            pw.SizedBox(height: 10.h),

///////////////////////////////////////////////////////////..........................................................
// bottom table view
            ///
            pw.Padding(
              padding: pw.EdgeInsets.all(8.0),
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Table(
                    border: pw.TableBorder.all(style: pw.BorderStyle.dotted),
                    columnWidths: const <int, pw.TableColumnWidth>{
                      0: pw.FlexColumnWidth(1.5), // Subject
                      1: pw.FlexColumnWidth(1), // Marks
                      2: pw.FlexColumnWidth(1), // Grade
                      3: pw.FlexColumnWidth(2), // Comment
                    },
                    children: [
                      pw.TableRow(
                        decoration: pw.BoxDecoration(
                            gradient: pw.LinearGradient(colors: [
                          PdfColor.fromHex("#02a2de"),
                          PdfColor.fromHex("#01c4f5"),
                        ])),
                        children: [
                          pw.SizedBox(
                            height: 0.05.sh,
                            child: pw.Center(
                              child: pw.Text(
                                'Subject',
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#ffffff"),
                                    fontSize: 16.sp,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            height: 0.05.sh,
                            child: pw.Center(
                              child: pw.Text(
                                'Marks',
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#ffffff"),
                                    fontSize: 16.sp,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            height: 0.05.sh,
                            child: pw.Center(
                              child: pw.Text(
                                'Grade',
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#ffffff"),
                                    fontSize: 16.sp,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ),
                          pw.SizedBox(
                            height: 0.05.sh,
                            child: pw.Center(
                              child: pw.Text(
                                'Comment',
                                style: pw.TextStyle(
                                    color: PdfColor.fromHex("#ffffff"),
                                    fontSize: 16.sp,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  pw.Column(
                      children: List.generate(
                          data.data!.data!.subjects!.length,
                          (index) => pw.Table(
                                border: pw.TableBorder.all(
                                    style: pw.BorderStyle.dotted),
                                columnWidths: const <int, pw.TableColumnWidth>{
                                  0: pw.FlexColumnWidth(1.5), // Subject
                                  1: pw.FlexColumnWidth(1), // Marks
                                  2: pw.FlexColumnWidth(1), // Grade
                                  3: pw.FlexColumnWidth(2), // Comment
                                },
                                children: [
                                  pw.TableRow(
                                    decoration: pw.BoxDecoration(
                                      color: index % 2 == 0
                                          ? PdfColor.fromHex("#ffffff")
                                          : PdfColors.grey200,
                                    ),
                                    children: [
                                      pw.SizedBox(
                                        height: 0.05.sh,
                                        child: pw.Center(
                                          child: pw.Text(
                                            "${data.data?.data?.subjects![index].subject?.toUpperCase()}",
                                            style: pw.TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    pw.FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 0.05.sh,
                                        child: pw.Center(
                                          child: pw.Text(
                                            "${data.data?.data?.subjects![index].marks}",
                                            style: pw.TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    pw.FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 0.05.sh,
                                        child: pw.Center(
                                          child: pw.Text(
                                            "${data.data?.data?.subjects![index].grades}",
                                            style: pw.TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    pw.FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                      pw.SizedBox(
                                        height: 0.05.sh,
                                        child: pw.Center(
                                          child: pw.Text(
                                            "${data.data?.data?.subjects![index].comments}",
                                            style: pw.TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight:
                                                    pw.FontWeight.normal),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ))),
                  pw.SizedBox(
                    height: 10.h,
                  ),
                  pw.SizedBox(
                    height: 15.h,
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 15.h),
            pw.SizedBox(
              child: pw.Text(
                  data.data?.result?.result == "Pass"
                      ? "Congratulations You have Cleared ${examType.toUpperCase()} with ${data.data?.result?.percentage}"
                      : "You have Failed $examType as You have Only Scored ${data.data?.result?.percentage}",
                  style: pw.TextStyle(
                    fontSize: 18.sp,
                  ),
                  textAlign: pw.TextAlign.center),
            ),
          ],
        ),
      ),
    );
    final filename =
        '${examType}_Roll_${data.data?.data?.rollNumber}_${data.data?.data?.studentName}_${data.data?.data?.month}_${data.data?.data?.year}.pdf';
    final file = File(
        '/storage/emulated/0/Documents/${filename}_${SharedServiceParentChildren.loginDetails()?.data?.data?.role}');

    try {
      final pdfData = await pdf.save();

    // File.fromRawPath(file).exists() 
     await file.writeAsBytes(pdfData);

      log("PDF saved successfully: ${file.path}");

      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return PdfPreviewPage(
            path: file.path,
          );
        },
      ));
      // ...
    } catch (error) {
      log("Error saving PDF: $error");
    }
  }
}

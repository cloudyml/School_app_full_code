import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/Screens/Dashboard.dart';
import 'package:school_management_system/Services/api_services/api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import 'package:school_management_system/widget/Button/rectangle_elevatedbutton_card.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Services/Url_launcher.dart/method.dart';

File? file;
ImagePicker image = ImagePicker();

class StudentPendingFileAssignmentCard extends StatefulWidget {
  final String subject;
  final String givenDate;
  final String submitDate;
  final String docUrl;
  final String assignmentID;
  final String Type;

  StudentPendingFileAssignmentCard({
    super.key,
    required this.subject,
    required this.givenDate,
    required this.submitDate,
    required this.docUrl,
    required this.assignmentID,
    required this.Type,
  });

  @override
  State<StudentPendingFileAssignmentCard> createState() =>
      _StudentPendingFileAssignmentCardState();
}

class _StudentPendingFileAssignmentCardState
    extends State<StudentPendingFileAssignmentCard> {
  @override
  Widget build(BuildContext context) {
    void showSuccessSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Assignment uploaded successfully'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    void showFalureSnackbar() {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Assignment already uploaded'),
          duration: Duration(seconds: 3),
        ),
      );
    }

    LaunceToWeb Launceweb = LaunceToWeb();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              color: Colors.grey,
              spreadRadius: 2,
              offset: Offset(2, 8))
        ],
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
                    const Text("Given Date : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold)),
                    Text(widget.givenDate,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    const Text("Submit Date : ",
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromRGBO(0, 0, 0, 1),
                            fontWeight: FontWeight.bold)),
                    Text(widget.submitDate,
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                "Subject : ",
                style: TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(5, 5, 4, 1),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                widget.subject,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          widget.Type == "studentseeSubmittedAssignment"
              ? MyElevatedButton(
                  onPressed: () {
                    log("View Assignment Success");
                    log(launchUrl.toString());
                    Launceweb.launchweb(widget.docUrl);
                  },
                  child: const Text(
                    'View File',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MyElevatedButton(
                      onPressed: () {
                        log("View Assignment Success");
                        log(launchUrl.toString());
                        Launceweb.launchweb(widget.docUrl);
                      },
                      child: const Text(
                        'View File',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    MyElevatedButton(
                      onPressed: () {
                        log(widget.assignmentID);
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Center(
                                            child: Container(
                                              height: height * 0.2,
                                              width: width * 0.6,
                                              color: Colors.black12,
                                              child: file == null
                                                  ? const Icon(
                                                      Icons.image,
                                                      size: 50,
                                                    )
                                                  : file!.path
                                                          .toLowerCase()
                                                          .endsWith('.pdf')
                                                      ? PDFView(
                                                          filePath:
                                                              file?.path ?? '',
                                                        )
                                                      : Image.file(
                                                          file!,
                                                          fit: BoxFit.fill,
                                                        ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(

                                                // right: width * 0.18,
                                                top: height * 0.02),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                MyElevatedButton(
                                                  onPressed: () async {
                                                    var img =
                                                        await image.pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                    setState(() {
                                                      file = File(img!.path);
                                                    });
                                                    setState(() {});
                                                  },
                                                  width: width * 0.3,
                                                  child: const Text(
                                                    "Chose file",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10.w,
                                                ),
                                                MyElevatedButton(
                                                  onPressed: () async {
                                                    var img =
                                                        await image.pickImage(
                                                            source: ImageSource
                                                                .camera);
                                                    setState(() {
                                                      file = File(img!.path);
                                                    });
                                                    setState(() {});
                                                  },
                                                  width: width * 0.3,
                                                  child: const Text(
                                                    "Camera",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10.h,
                                          ),
                                          MyElevatedButton(
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              gradient: LinearGradient(colors: [
                                                lightBlue,
                                                deepBlue
                                              ]),
                                              onPressed: () {
                                                ApiServices
                                                    .StudentUploadAssignmentFile(
                                                  file!,
                                                  widget.assignmentID
                                                      .toString(),
                                                ).then((value) {
                                                  if (value == true) {
                                                    showSuccessSnackbar();
                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const Dashboard()));
                                                  } else {
                                                    showFalureSnackbar();
                                                  }
                                                });
                                              },
                                              child: Text(
                                                "Submit",
                                                style: GoogleFonts.inter(
                                                    fontSize: 22.sp,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ))
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  getCam() async {}

  getGallery() async {}

  Future<void> getGal() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);

      setState(() {
        file = selectedFile;
      });
    }
    setState(() {});
  }
}

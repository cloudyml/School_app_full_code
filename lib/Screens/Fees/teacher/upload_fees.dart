import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Services/api_services/api_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/rectangle_elevatedbutton_card.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

import '../../../Models/Student/Fees/student_fee_response_model.dart';
import '../../Dashboard.dart';

class UploadFees extends StatefulWidget {
  final SingleFeeModel? feesModel;
  const UploadFees({super.key, this.feesModel});

  @override
  State<UploadFees> createState() => _UploadFeesState();
}

class _UploadFeesState extends State<UploadFees> {
  TextEditingController classInput = TextEditingController();
  TextEditingController admissionInput = TextEditingController();
  TextEditingController discountInput = TextEditingController();
  TextEditingController miscellaneousInput = TextEditingController();
  TextEditingController libraryInput = TextEditingController();
  TextEditingController tuitionInput = TextEditingController();
  TextEditingController examInput = TextEditingController();
  TextEditingController transportInput = TextEditingController();
  String selectedClass = 'Choose Class';
  List<String> classOptions = [
    'Choose Class',
    '1',
    '2',
    '3',
    "4",
    '5',
    '6',
    '7',
    "8",
    '9',
    '10',
    '11',
    "12",
  ];
  @override
  void initState() {
    if (widget.feesModel != null) {
      selectedClass = widget.feesModel!.datumClass!.toString();
      admissionInput.text = widget.feesModel!.admissionFees!.toString();
      libraryInput.text = widget.feesModel!.libraryFees!.toString();
      tuitionInput.text = widget.feesModel!.tuitionFees!.toString();
      examInput.text = widget.feesModel!.examinationFees!.toString();
      transportInput.text = widget.feesModel!.transportFees!.toString();
      miscellaneousInput.text = widget.feesModel!.miscellaneousFees!.toString();
    }
    super.initState();
  }

  void showSuccessSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Fee details uploaded successfully'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void showFailureSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Invalid Input...'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
              "assets/flaticon/_fees.png",
              widget.feesModel != null ? "Update fees" : "Upload Fees",
              context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: width * 0.05, right: width * 0.05, top: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "Select Standard",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 17,
                          color: const Color.fromARGB(255, 96, 96, 96),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.88,
                    child: DropdownButtonFormField<String>(
                      value: selectedClass,
                      onChanged: (value) {
                        if (value != 'Choose Class') {
                          setState(() {
                            selectedClass = value!;
                          });
                        }
                      },
                      items: classOptions
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      decoration: InputDecoration(
                        hintText: "Class*",
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: deepBlue,
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.025,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Admission Fees*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: admissionInput,
                      decoration: InputDecoration(
                        hintText: "Enter admission fees",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.025,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Examination Fees*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: examInput,
                      decoration: InputDecoration(
                        hintText: "Enter examination fees",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.025,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tuition Fees*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: tuitionInput,
                      decoration: InputDecoration(
                        hintText: "Enter tuition fees",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.025,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Library Fees*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: libraryInput,
                      decoration: InputDecoration(
                        hintText: "Enter library fees",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.025,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Transport Fees*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: transportInput,
                      decoration: InputDecoration(
                        hintText: "Enter transport fees",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.025,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Miscellaneous Fees*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: miscellaneousInput,
                      decoration: InputDecoration(
                        hintText: "Enter miscellaneous fees",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.05,
                top: height * 0.025,
              ),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Discount Fees*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextField(
                      keyboardType: TextInputType.number,
                      controller: discountInput,
                      decoration: InputDecoration(
                        hintText: "Enter admission fees",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 135, 135, 135),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      persistentFooterButtons: [
        RecElevatedButton(
          onPressed: () async {
            if (isChecked == false) {
              setState(() {
                isChecked = true;
              });

              widget.feesModel != null
                  ? await ApiServices.updateFees(
                      selectedClass,
                      admissionInput.text,
                      tuitionInput.text,
                      examInput.text,
                      libraryInput.text,
                      transportInput.text,
                      miscellaneousInput.text,
                      discountInput.text,
                    ).then((value) {
                      if (value == true) {
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()))
                            .whenComplete(() {
                          setState(() {
                            isChecked = false;
                          });
                        });
                        showSuccessSnackbar();
                      } else {
                        setState(() {
                          isChecked = false;
                        });
                        showFailureSnackbar();
                      }
                    })
                  : ApiServices.uploadFees(
                      selectedClass,
                      admissionInput.text,
                      tuitionInput.text,
                      examInput.text,
                      libraryInput.text,
                      transportInput.text,
                      miscellaneousInput.text,
                      discountInput.text,
                    ).then((value) {
                      if (value == true) {
                        Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Dashboard()))
                            .whenComplete(() {
                          setState(() {
                            isChecked = false;
                          });
                        });
                        showSuccessSnackbar();
                      } else {
                        setState(() {
                          isChecked = false;
                        });
                        showFailureSnackbar();
                      }
                    });
            }
          },
          child: Text(
            widget.feesModel != null ? "UPDATE " : "SUBMIT",
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Navbar/Account/Parent/edit_parent/info_tile_edit_page.dart';
import 'package:school_management_system/Services/api_services/api_services.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/Services/shared_services_parent_children.dart';
import '../../../../../constants/style.dart';
import '../../../../../widget/Button/my_elevatedbutton.dart';
import '../../../../../widget/appBar/appbar_widget.dart';
import '../../../../../widget/appBar/decorative_apbar_widget.dart';

class EditParentAccountDetails extends StatefulWidget {
  const EditParentAccountDetails({
    super.key,
  });

  @override
  State<EditParentAccountDetails> createState() =>
      _EditParentAccountDetailsState();
}

class _EditParentAccountDetailsState extends State<EditParentAccountDetails> {
  TextEditingController passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
              "assets/My_account/avatar.png", " Edit Details", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            EditInfoPageTileNonEditable(
                heading: "Name",
                subheading:
                    "${SharedServiceParentChildren.loginDetails()?.data?.data?.name}"),
            EditInfoPageTileNonEditable(
                heading: "Email",
                subheading:
                    "${SharedServiceParentChildren.loginDetails()?.data?.data?.email}"),
            EditInfoPageTileNonEditable(
                heading: "Phone Number",
                subheading:
                    "${SharedServiceParentChildren.loginDetails()?.data?.data?.phoneNumber}"),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 30),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Password*",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                        color: const Color.fromARGB(255, 96, 96, 96),
                      ),
                    ),
                    TextFormField(
                      initialValue: SharedServiceParentChildren.loginDetails()
                          ?.data
                          ?.data
                          ?.password,
                      onChanged: (value) {
                        passwordInput.text = value;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter new password",
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
            EditInfoPageTileNonEditable(
                heading: "City",
                subheading:
                    "${SharedServiceParentChildren.loginDetails()?.data?.data?.address}"),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 20),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: MyElevatedButton(
                    onPressed: ()  {
                       ApiServices.updateMyAccountParentStudent(
                              passwordInput.text)
                          .whenComplete(() {
                        setState(() {
                          SharedServiceParentChildren.updateMyAccountDetails(
                              password: passwordInput.text);
                        });
                      });
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.green,
                          content: Text('Password Updated Successfully'),
                          duration: Duration(seconds: 3),
                        ),
                      );

                      log(passwordInput.text);
                      log("${SharedServiceParentChildren.loginDetails()?.data?.data?.password}");
                    },
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

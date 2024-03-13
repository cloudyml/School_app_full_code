// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:school_management_system/Services/api_services/api_services.dart';
// import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
// import 'package:school_management_system/Services/teacher_shared_service.dart';

// import '../../../../../constants/style.dart';
// import '../../../../../widget/Button/my_elevatedbutton.dart';
// import '../../../../../widget/appBar/appbar_widget.dart';
// import '../../../../../widget/appBar/decorative_apbar_widget.dart';

// class EditTeacherAccountDetails extends StatefulWidget {
//   const EditTeacherAccountDetails({super.key, l});

//   @override
//   State<EditTeacherAccountDetails> createState() =>
//       _EditTeacherAccountDetailsState();
// }

// class _EditTeacherAccountDetailsState extends State<EditTeacherAccountDetails> {
//   TextEditingController nameInput = TextEditingController();
//   TextEditingController emailInput = TextEditingController();
//   TextEditingController phonenoInput = TextEditingController();
//   TextEditingController passwordInput = TextEditingController();
//   TextEditingController cityInput = TextEditingController();

//   @override
//   void initState() {
//     nameInput.text =
//         TeacherSharedServices.loginDetails()!.data!.data!.name.toString();
//     emailInput.text =
//         TeacherSharedServices.loginDetails()!.data!.data!.email.toString();
//     super.initState();
//     phonenoInput.text = TeacherSharedServices.loginDetails()!
//         .data!
//         .data!
//         .phoneNumber
//         .toString();
//     super.initState();
//     passwordInput.text =
//         TeacherSharedServices.loginDetails()!.data!.data!.password.toString();
//     super.initState();
//     cityInput.text =
//         TeacherSharedServices.loginDetails()!.data!.data!.address.toString();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(
//           MediaQuery.of(context).size.height * 0.3,
//         ),
//         child: DecorativeAppBar(
//           barHeight: MediaQuery.of(context).size.height * 0.24,
//           barPad: MediaQuery.of(context).size.height * 0.19,
//           radii: 30,
//           background: Colors.white,
//           gradient1: lightBlue,
//           gradient2: deepBlue,
//           extra: appbar(
//               "assets/My_account/avatar.png", " Edit Details", context, () {
//             Navigator.pop(context);
//           }),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(
//                 left: 20.0,
//                 right: 20,
//               ),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Name*",
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 17,
//                         color: const Color.fromARGB(255, 96, 96, 96),
//                       ),
//                     ),
//                     TextField(
//                       controller: nameInput,
//                       decoration: InputDecoration(
//                         hintText: "Enter your name",
//                         hintStyle: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: const Color.fromARGB(255, 135, 135, 135),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Email*",
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 17,
//                         color: const Color.fromARGB(255, 96, 96, 96),
//                       ),
//                     ),
//                     TextField(
//                       controller: emailInput, // Fixed the controller name here
//                       decoration: InputDecoration(
//                         hintText: "Enter your email",
//                         hintStyle: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: const Color.fromARGB(255, 135, 135, 135),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Phone Number*",
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 17,
//                         color: const Color.fromARGB(255, 96, 96, 96),
//                       ),
//                     ),
//                     TextField(
//                       controller:
//                           phonenoInput, // Fixed the controller name here
//                       decoration: InputDecoration(
//                         hintText: "Enter phone",
//                         hintStyle: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: const Color.fromARGB(255, 135, 135, 135),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Password*",
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 17,
//                         color: const Color.fromARGB(255, 96, 96, 96),
//                       ),
//                     ),
//                     TextField(
//                       controller: passwordInput,
//                       decoration: InputDecoration(
//                         hintText: "Enter new password",
//                         hintStyle: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: const Color.fromARGB(255, 135, 135, 135),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 20.0, right: 20, top: 30),
//               child: Container(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "City*",
//                       style: GoogleFonts.poppins(
//                         fontWeight: FontWeight.w600,
//                         fontSize: 17,
//                         color: const Color.fromARGB(255, 96, 96, 96),
//                       ),
//                     ),
//                     TextField(
//                       controller: cityInput,
//                       decoration: InputDecoration(
//                         hintText: "Enter your city",
//                         hintStyle: GoogleFonts.poppins(
//                           fontSize: 12,
//                           color: const Color.fromARGB(255, 135, 135, 135),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 50, left: 20),
//               child: Align(
//                   alignment: Alignment.bottomLeft,
//                   child: MyElevatedButton(
//                     onPressed: () async {
//                       if (nameInput.text ==
//                               TeacherSharedServices.loginDetails()!
//                                   .data!
//                                   .data!
//                                   .name
//                                   .toString() &&
//                           emailInput.text ==
//                               TeacherSharedServices.loginDetails()!
//                                   .data!
//                                   .data!
//                                   .email
//                                   .toString() &&
//                           phonenoInput.text ==
//                               TeacherSharedServices.loginDetails()!
//                                   .data!
//                                   .data!
//                                   .phoneNumber
//                                   .toString() &&
//                           passwordInput.text ==
//                               TeacherSharedServices.loginDetails()!
//                                   .data!
//                                   .data!
//                                   .password
//                                   .toString() &&
//                           cityInput.text ==
//                               TeacherSharedServices.loginDetails()!
//                                   .data!
//                                   .data!
//                                   .address
//                                   .toString()) {
//                         EasyLoading.showInfo("Nothing to update");
//                       } else {
//                         await TeacherApiServices.updateMyAccountTeacher(

//                                 passwordInput.text,
//                              )
//                             .then((value) {
//                           if (value == true) {
//                             TeacherSharedServices.updateMyAccountDetails(
//                               name: nameInput.text,
//                               email: emailInput.text,
//                               phoneNumber: phonenoInput.text,
//                               password: passwordInput.text,
//                               address: cityInput.text,
//                             );
//                             EasyLoading.showSuccess("Updated Successfully");
//                           } else if (value == false) {
//                             EasyLoading.showError("Something Went Wrong");
//                           }
//                         });
//                       }
//                     },
//                     child: const Text(
//                       "SUBMIT",
//                       style: TextStyle(color: Colors.white, fontSize: 18),
//                     ),
//                   )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//...............

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Navbar/Account/Teacher/Edit_Teacher/info_tile_edit_page.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/Services/teacher_shared_service.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class EditTeacherAccountDetails extends StatefulWidget {
  const EditTeacherAccountDetails({
    super.key,
  });

  @override
  State<EditTeacherAccountDetails> createState() =>
      _EditTeacherAccountDetailsState();
}

class _EditTeacherAccountDetailsState extends State<EditTeacherAccountDetails> {
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
            const SizedBox(
              height: 5,
            ),
            EditInfoPageTileNonEditable(
                heading: "Name",
                subheading:
                    "${TeacherSharedServices.loginDetails()?.data?.data?.name}"),
            EditInfoPageTileNonEditable(
                heading: "Email",
                subheading:
                    "${TeacherSharedServices.loginDetails()?.data?.data?.email}"),
            EditInfoPageTileNonEditable(
                heading: "Phone Number",
                subheading:
                    "${TeacherSharedServices.loginDetails()?.data?.data?.phoneNumber}"),
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
                      initialValue: TeacherSharedServices.loginDetails()
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
                    "${TeacherSharedServices.loginDetails()?.data?.data?.address}"),
            Padding(
              padding: EdgeInsets.only(top: 0.01.sh, left: 20),
              child: Align(
                  alignment: Alignment.bottomLeft,
                  child: MyElevatedButton(
                    onPressed: () {
                      TeacherApiServices.updateMyAccountTeacher(
                        passwordInput.text,
                      ).then((success) {
                        if (success) {
                          TeacherSharedServices.updateMyAccountDetails(
                            password: passwordInput.text,
                          ).then((_) {
                            // Password updated in SharedPreferences successfully
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.green,
                                content: Text('Password Updated Successfully'),
                                duration: Duration(seconds: 3),
                              ),
                            );
                            Navigator.pop(context);
                          }).catchError((error) {
                            log('Error updating password in SharedPreferences: $error');
                          });
                        } else {
                          log('Password update on the server failed');
                        }
                      }).catchError((error) {
                        log('Error updating password on the server: $error');
                      });

                      log(passwordInput.text);
                      log("${TeacherSharedServices.loginDetails()?.data?.data?.password}");
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

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Services/api_services.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';
import '../../../Models/Student/About/view_about_school.dart';
import '../../../Services/Url_launcher.dart/method.dart';
import '../../../constants/style.dart';

class ParentViewAboutSchool extends StatelessWidget {
  const ParentViewAboutSchool({super.key});

  @override
  Widget build(BuildContext context) {
    LaunceToWeb Launceweb = LaunceToWeb();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: FutureBuilder<AboutSchoolResponseModel>(
        future: ApiServices.ViewAboutSchoolParent(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator()); // Show loading indicator
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.data == null) {
            return Center(child: const Text('No data found.'));
          } else {
            AboutSchoolResponseModel? aboutSchool = snapshot.data;
            return SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          gradient:
                              LinearGradient(colors: [lightBlue, deepBlue]),
                        ),
                        height: MediaQuery.of(context).size.height * 0.10,
                        child: Row(
                          children: [
                            // IconButton(
                            //     onPressed: () {
                            //       Navigator.pop(context);
                            //     },
                            //     icon: const Icon(
                            //       Icons.arrow_back,
                            //       size: 40,
                            //       color: Colors.white,
                            //     )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.34,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text("About Us",
                                  style: GoogleFonts.inter(
                                      color: Colors.white,
                                      letterSpacing: 2.0,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 188, 187, 187),
                        ),
                        height: MediaQuery.of(context).size.height * 0.22,
                        child: aboutSchool!.data!.coverPic!.link!.isEmpty
                            ? Text("")
                            : Image.network(
                                aboutSchool.data!.coverPic!.link.toString(),
                                fit: BoxFit.cover,
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 20, top: 50),
                                  child: Text(
                                    aboutSchool.data!.schoolName.toString(),
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: deepBlue,
                                  radius: 15,
                                  child: const ClipOval(
                                    child: Icon(
                                      size: 18,
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Text(
                                    aboutSchool.data!.schoolAddress.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: deepBlue,
                                  radius: 15,
                                  child: const ClipOval(
                                    child: Icon(
                                      Icons.web,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Text(
                                    aboutSchool.data!.websiteLink.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor: deepBlue,
                                  radius: 15,
                                  child: const ClipOval(
                                    child: Icon(
                                      size: 18,
                                      Icons.email,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Text(
                                    aboutSchool.data!.schoolEmailId.toString(),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'About school',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              aboutSchool.data!.aboutSchool.toString(),
                              textAlign: TextAlign.justify,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 144, 144, 144),
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Core values',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            Text(
                              aboutSchool.data!.coreValues.toString(),
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 144, 144, 144),
                                  fontSize: 14),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Text(
                              'Rules and Regulations',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            MyElevatedButton(
                              onPressed: () {
                                Launceweb.launchweb(
                                  aboutSchool.data!.rulesAndRegulation!.link
                                      .toString(),
                                );
                              },
                              child: const Text(
                                "View",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Divider(),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              'Contact details',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Principal offices - ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontSize: 15),
                                ),
                                Text(
                                  aboutSchool.data!.principalOffice.toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Admission department - ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontSize: 15),
                                ),
                                Text(
                                  aboutSchool.data!.admissionDepartment
                                      .toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Enquiry office - ',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontSize: 15),
                                ),
                                Text(
                                  aboutSchool.data!.enquiryDepartment
                                      .toString(),
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 144, 144, 144),
                                      fontSize: 14),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    left: 20,
                    top: 220,
                    height: 100,
                    width: 100,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: deepBlue),
                        color: Colors.teal,
                      ),
                      child: SizedBox(
                        width: width * 0.24,
                        child: Image.network(
                          aboutSchool.data!.profilePic!.link.toString(),
                          fit: BoxFit.fill,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Image.asset(
                                'assets/imagee.png'); // Replace with your placeholder image asset
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

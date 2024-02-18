import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Models/Teacher/Notice/teacher_view_notice_response_model.dart';
import 'package:school_management_system/Screens/Navbar/Notice/Student/notice_detailed_screen.dart';
import 'package:school_management_system/Services/api_services/api_services.dart';
import 'package:school_management_system/Services/api_services/teacher_api_services.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import '../../../../Models/Student/Notice/view_notice_response_model.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../../widget/student/Notice/student_notice_card.dart';

class TeacherViewNoticeScreen extends StatefulWidget {
  const TeacherViewNoticeScreen({Key? key}) : super(key: key);

  @override
  _TeacherViewNoticeScreenState createState() =>
      _TeacherViewNoticeScreenState();
}

class _TeacherViewNoticeScreenState extends State<TeacherViewNoticeScreen> {
  String searchText = '';
  List<String> notices = List.generate(10, (index) => 'Notice $index');
  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(300),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.19,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: appbar("assets/add_events.png", " Notice", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            child: Container(
              height: height * 0.07,
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchText = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(5),
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: deepBlue), // Color when focused
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<TeacherNoticeResponseModel>(
              future: TeacherApiServices.viewNoticeTeacher(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Error: ...');
                } else if (!snapshot.hasData || snapshot.data!.data == null) {
                  return const Center(child: Text('No events found.'));
                } else {
                  TeacherNoticeResponseModel? notices = snapshot.data;
                  return ListView.builder(
                    itemCount: notices!.data!.noticeList!.length,
                    itemBuilder: (context, index) {
                      final title =
                          notices.data!.noticeList![index].heading.toString();
                      final lowerCaseTitle = title.toLowerCase();

                      if (searchText.isEmpty ||
                          lowerCaseTitle.contains(searchText)) {
                        return ViewNoticeCard(
                          noticeId:
                              notices.data!.noticeList![index].id.toString(),
                          title: title,
                          image: notices
                              .data!.noticeList![index].uploadedImage!.link
                              .toString(),
                          isRead:
                              notices.data!.noticeList![index].read.toString(),
                          onClicked: () {
                            TeacherApiServices.verifyReadUnreadNoticeTeacher(
                                    notices.data!.noticeList![index].id
                                        .toString())
                                .then(
                              (value) {
                                if (value == true) {
                                  if (isClicked == false) {
                                    setState(() {
                                      isClicked == true;
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NoticeDetailedScreen(
                                                heading: notices.data!
                                                    .noticeList![index].heading
                                                    .toString(),
                                                date: notices.data!
                                                    .noticeList![index].date
                                                    .toString(),
                                                des: notices
                                                    .data!
                                                    .noticeList![index]
                                                    .description
                                                    .toString(),
                                                imglink: notices
                                                    .data!
                                                    .noticeList![index]
                                                    .uploadedImage!
                                                    .link
                                                    .toString(),
                                              )),
                                    ).whenComplete(() {
                                      setState(() {
                                        isClicked = false;
                                      });
                                    });
                                  }
                                }
                              },
                            );
                          },
                        );
                      } else {
                        return const SizedBox
                            .shrink(); // Hide non-matching items
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

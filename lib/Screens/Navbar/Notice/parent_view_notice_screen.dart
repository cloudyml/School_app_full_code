import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/Navbar/Notice/Student/notice_detailed_screen.dart';
import 'package:school_management_system/Services/api_services.dart';
import '../../../../Models/Student/Notice/view_notice_response_model.dart';
import '../../../../constants/style.dart';
import '../../../../widget/appBar/decorative_apbar_widget.dart';
import '../../../../widget/student/Notice/student_notice_card.dart';

class ParentViewNoticeScreen extends StatefulWidget {
  const ParentViewNoticeScreen({Key? key}) : super(key: key);

  @override
  _ParentViewNoticeScreenState createState() => _ParentViewNoticeScreenState();
}

class _ParentViewNoticeScreenState extends State<ParentViewNoticeScreen> {
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
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.3,
        ),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.20,
          barPad: MediaQuery.of(context).size.height * 0.17,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: EdgeInsets.only(top: height * 0.07, left: width * 0.2),
                child: Row(
                  children: [
                    Container(
                      width: 35,
                      height: 35,
                      child: Image.asset("assets/add_events.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        width: height * 0.3,
                        child: Text("Notice",
                            style: GoogleFonts.inter(
                                color: Colors.white,
                                letterSpacing: 1.0,
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.w500)),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
      body: Column(
        children: [
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
            child: FutureBuilder<ViewNoticeResponseModel>(
              future: ApiServices.viewNoticeParent(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return const Text('Error: ...');
                } else if (!snapshot.hasData || snapshot.data!.data == null) {
                  return const Center(child: Text('No events found.'));
                } else {
                  ViewNoticeResponseModel? notices = snapshot.data;
                  return ListView.builder(
                    itemCount: notices!.data!.noticeList!.length,
                    itemBuilder: (context, index) {
                      final title =
                          notices.data!.noticeList![index].heading.toString();
                      final lowerCaseTitle = title.toLowerCase();

                      if (searchText.isEmpty ||
                          lowerCaseTitle.contains(searchText)) {
                        return ViewNoticeCard(
                          title: title,
                          image:
                              notices.data!.noticeList![index].link.toString(),
                          isRead:
                              notices.data!.noticeList![index].read.toString(),
                          onClicked: () {
                            ApiServices.verifyReadUnreadNoticeParent(notices
                                    .data!.noticeList![index].id
                                    .toString())
                                .then(
                              (value) {
                                if (value == true) {
                                  if (isClicked == false) {
                                    setState(() {
                                      isClicked = true;
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
                                                imglink: notices.data!
                                                    .noticeList![index].link
                                                    .toString(),
                                              )),
                                    ).whenComplete(() {
                                      setState(() {
                                        isClicked == false;
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

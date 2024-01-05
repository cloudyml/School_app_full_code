import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:school_management_system/Screens/Navbar/Notice/Teacher/choose_notice_options.dart';
import 'package:school_management_system/Services/api_services.dart';
import 'package:school_management_system/Services/shared_services.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';

class ViewNoticeCard extends StatefulWidget {
  String title;
  String image;
  String isRead;
  String noticeId;
  final VoidCallback onClicked;

  ViewNoticeCard(
      {Key? key,
      required this.image,
      required this.onClicked,
      required this.title,
      required this.isRead,
      required this.noticeId})
      : super(key: key);

  @override
  State<ViewNoticeCard> createState() => _ViewNoticeCardState();
}

class _ViewNoticeCardState extends State<ViewNoticeCard> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10,
      ),
      child: Stack(
        children: [
          Container(
            height: height * 0.17,
            width: width,
            decoration: BoxDecoration(
              color: widget.isRead == "false"
                  ? const Color.fromARGB(255, 255, 215, 156)
                  : Colors.white,
              border: Border.all(color: deepBlue),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: width * 0.24,
                    child: Image.network(
                      widget.image,
                      fit: BoxFit.fill,
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      (loadingProgress.expectedTotalBytes ?? 1)
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
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: width * 0.63,
                            child: Text(
                              widget.title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyElevatedButton(
                            width: width * 0.3,
                            onPressed: () {
                              widget.onClicked();
                            },
                            child: const Text(
                              "View",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (SharedService.loginDetails()!.data!.data!.role == "teacher")
            Positioned(
              top: 5,
              right: 5,
              child: IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  _showDeleteDialog();
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showDeleteDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to delete this notice?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteNotice();
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteNotice() {
    ApiServices.deleteNoticeTeacher(widget.noticeId).then((value) {
      if (value == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Notice Deleted'),
            duration: Duration(seconds: 2),
          ),
        );

        // Optionally navigate to a different screen after deletion
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const TeacherNoticeOptions(),
          ),
        );
        log("Notice Deleted");
      }
    });
  }
}

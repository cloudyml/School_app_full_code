import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';

// ignore: must_be_immutable
class HeadingWiseViewAwardsCard extends StatelessWidget {
  String eventname;
  DateTime eventDate;
  final VoidCallback onPressed;
  HeadingWiseViewAwardsCard({
    super.key,
    required this.eventname,
    required this.eventDate,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    String formattedDate = DateFormat('dd-MM-yyyy').format(eventDate);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: height * 0.19,
        width: width * 0.2,
        decoration: BoxDecoration(
          border: Border.all(color: deepBlue),
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(blurRadius: 4, color: Colors.grey, offset: Offset(0, 3))
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Event Name :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      " ${eventname}",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Text(
                      "Date :",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      formattedDate,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: width * 0.05,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: width * 0.02,
              ),
              MyElevatedButton(
                  onPressed: onPressed,
                  child: const Text(
                    "View Awards",
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:school_management_system/constants/style.dart';

class OptionTileWidgetAccount extends StatelessWidget {
  OptionTileWidgetAccount({
    super.key,
    required this.heading,
    required this.subheading,
    required this.imageIcon,
  });
  String heading;
  String subheading;
  String imageIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 5,
            color: Colors.grey,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.08.sw),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: deepBlue,
              child: ClipOval(
                child: Image.asset(
                  imageIcon,
                  //  fit: BoxFit.cover,
                  width: 60,
                  height: 20,
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 0.5
                        .sw, // Set a width that fits your text without overflow
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            heading,
                            style: TextStyle(fontSize: 20),

                            maxLines: 1, // Display only one line of text
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 0.55
                        .sw, // Set a width that fits your text without overflow
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Text(
                            subheading,

                            maxLines: 1, // Display only one line of text
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

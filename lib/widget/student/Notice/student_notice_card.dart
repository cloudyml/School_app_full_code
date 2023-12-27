import 'package:flutter/material.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/Button/my_elevatedbutton.dart';

class ViewNoticeCard extends StatefulWidget {
  String title;
  String image;
  String isRead;
  final VoidCallback onClicked;
  ViewNoticeCard(
      {super.key,
      required this.image,
      required this.onClicked,
      required this.title,
      required this.isRead});

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
      child: Container(
        height: height * 0.17,
        width: width * 0.9,
        decoration: BoxDecoration(
            color: widget.isRead == "false"
                ? Color.fromARGB(255, 255, 215, 156)
                : Colors.white,
            border: Border.all(color: deepBlue),
            borderRadius: BorderRadius.circular(15)),
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
                    SizedBox(
                      width: width * 0.63,
                      child: Text(
                        widget.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    MyElevatedButton(
                      width: width * 0.3,
                      onPressed: () {
                        widget.onClicked();
                      },
                      child: const Text(
                        "View",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

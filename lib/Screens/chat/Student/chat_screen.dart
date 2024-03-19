import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/student/Assignments/pending_assignment_card.dart';
import 'package:swipe_to/swipe_to.dart';

class msgmodel {
  String keyname;
  String username;
  String sentTime;
  bool replied;
  String? repliedToMsgContent;
  String? repliedToWhom;
  String value;
  msgmodel({
    required this.keyname,
    required this.value,
    this.repliedToMsgContent,
    this.repliedToWhom,
    required this.replied,
    required this.username,
    required this.sentTime,
  });
}

class ChatRoomScreen extends StatefulWidget {
  ChatRoomScreen({super.key});

  static List option = [
    "Image",
    "Pdf",
    "camera",
  ];
  static List optionicon = [
    const Icon(Icons.image),
    const Icon(Icons.picture_as_pdf),
    const Icon(Icons.camera),
  ];
  // static List<msgmodel> msgs1 = [
  //   msgmodel(
  //       keyname: "user1", value: "Hello", sentTime: "17:30", username: "User1"),
  //   msgmodel(
  //       keyname: "user2", value: "HI", sentTime: "17:31", username: "User2"),
  //   msgmodel(
  //       keyname: "user1",
  //       value: "Whats up",
  //       sentTime: "17:33",
  //       username: "User1"),
  //   msgmodel(
  //       keyname: "user2",
  //       value: "Nothing Revising maths rn",
  //       sentTime: "17:36",
  //       username: "User2"),
  //   msgmodel(
  //       keyname: "user1",
  //       value:
  //           "ok i had a doubt can you help?? plz help me in stuck at a issue and rellay can help ",
  //       sentTime: "17:40",
  //       username: "User1"),
  //   msgmodel(
  //       keyname: "user2",
  //       value: "ya sure ask ",
  //       sentTime: "17:45",
  //       username: "User2"),
  //   msgmodel(
  //       keyname: "user1",
  //       value: "Thanks a lot that helped me a lot",
  //       sentTime: "17:30",
  //       username: "User1"),
  //   msgmodel(
  //       keyname: "user2",
  //       value: "No Problem anytime...",
  //       sentTime: "17:50",
  //       username: "User2"),
  // ];

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

String replyingtoMsg = "";
String whomWeAreReplying = "";
final replyFocusNode = FocusNode();
List<msgmodel> newmsgsssssssssssssssss = [];

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  Future<void> getGal() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);

      setState(() {
        file = selectedFile;
      });
    }
  }

  Future<void> getPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);

      setState(() {
        file = selectedFile;
      });
    }
  }

  Future<XFile?> takePictureFromCamera() async {
    try {
      final imagePicker = ImagePicker();
      final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
      );
      return pickedImage;
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
      return null;
    }
  }

  bool isVioceMsg = false;
  TextEditingController msg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              lightBlue,
              deepBlue,
            ])),
            height: 0.12.sh,
            width: 1.0.sw,
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, left: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 32.sp,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 0.015.sw,
                  ),
                  CircleAvatar(
                    radius: 20.r,
                    backgroundImage: const NetworkImage(
                        "https://imgs.search.brave.com/k_9AIFjJQjBjTnvKm5YAOLa9e8uZdzUSj15RoL4t4yc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzU1LzA0Lzk3/LzM2MF9GXzE1NTA0/OTc4Nl9DaDE3Z1Jm/UGptS0c1TjlTMjFW/TXM4TFdCa2prZlZE/aS5qcGc"),
                  ),
                  SizedBox(
                    width: 0.02.sw,
                  ),
                  Text(
                    "Maths XII class",
                    style: GoogleFonts.inter(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 0.09.sh),
              child: Container(
                height: 0.8.sh,
                child: SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    children:
                        List.generate(newmsgsssssssssssssssss.length, (index) {
                      return SwipeTo(
                        swipeSensitivity: 15,
                        animationDuration: const Duration(milliseconds: 500),
                        onRightSwipe: (details) {
                          setState(() {
                            replyingtoMsg =
                                newmsgsssssssssssssssss[index].value;
                            log(replyingtoMsg);
                            replyFocusNode.requestFocus();
                            whomWeAreReplying =
                                newmsgsssssssssssssssss[index].username;
                          });
                        },
                        child: Container(
                            // width: 1.0.sw,
                            alignment: newmsgsssssssssssssssss[index].keyname ==
                                    "user2"
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: newmsgsssssssssssssssss[index]
                                            .value
                                            .length >
                                        20
                                    ? 0.7.sw
                                    : null,
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 8.w),
                                decoration: BoxDecoration(
                                  color: deepBlue.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                      newmsgsssssssssssssssss[index].keyname ==
                                              "user2"
                                          ? CrossAxisAlignment.start
                                          : CrossAxisAlignment.end,
                                  children: [
                                    newmsgsssssssssssssssss[index].replied
                                        ? Container(
                                          padding: EdgeInsets.only(left: 5.w),
                                            decoration: BoxDecoration(
                                                color:
                                                    deepBlue.withOpacity(0.3),
                                                border: Border(
                                                  left: BorderSide(
                                                      width: 5.w,
                                                      color: Colors.black),
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(5.r)),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SizedBox(
                                                  child: Text(
                                                    newmsgsssssssssssssssss[
                                                            index]
                                                        .repliedToWhom
                                                        .toString(),
                                                    overflow: TextOverflow.clip,
                                                    style: GoogleFonts.inter(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: newmsgsssssssssssssssss[
                                                                  index]
                                                              .repliedToMsgContent!
                                                              .length >
                                                          20
                                                      ? 0.7.sw
                                                      : null,
                                                  child: Text(
                                                    newmsgsssssssssssssssss[
                                                            index]
                                                        .repliedToMsgContent!,
                                                    overflow: TextOverflow.clip,
                                                    style: GoogleFonts.inter(),
                                                    maxLines: 2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        : Container(
                                            width: 0,
                                          ),
                                    SizedBox(
                                      width: newmsgsssssssssssssssss[index]
                                                  .value
                                                  .length >
                                              20
                                          ? 0.65.sw
                                          : null,
                                      child: Text(
                                        newmsgsssssssssssssssss[index].value,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    Text(
                                      newmsgsssssssssssssssss[index].sentTime,
                                      
                                    )
                                  ],
                                ),
                              ),
                            )),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          replyingtoMsg != ""
              ? Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          topRight: Radius.circular(10.r)),
                      color: deepBlue,
                      border: Border.all(color: Colors.grey.withOpacity(0.9)),
                    ),
                    width: 0.8.sw,
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.withOpacity(0.8),
                          border: Border(
                            left: BorderSide(width: 5.w, color: Colors.black),
                          ),
                          borderRadius: BorderRadius.circular(5.r)),
                      width: 0.6.sw,
                      padding:
                          EdgeInsets.only(left: 4.w, top: 2.h, bottom: 2.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 0.6.sw,
                                child: Text(
                                  whomWeAreReplying,
                                  overflow: TextOverflow.clip,
                                  maxLines: 1,
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      replyingtoMsg = "";
                                      whomWeAreReplying = "";
                                    });
                                  },
                                  child: const Icon(Icons.close))
                            ],
                          ),
                          Text(
                            replyingtoMsg,
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.inter(),
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
          Padding(
            padding: EdgeInsets.only(bottom: 4.h, left: 4.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.8.sw,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: deepBlue,
                      // border: Border.all(color: Colors.grey.withOpacity(0.9)),
                      borderRadius: replyingtoMsg != ""
                          ? BorderRadius.only(
                              topLeft: Radius.circular(0.r),
                              topRight: Radius.circular(0.r),
                              bottomLeft: Radius.circular(10.r),
                              bottomRight: Radius.circular(10.r),
                            )
                          : BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 0.56.sw,
                          child: TextField(
                            controller: msg,
                            focusNode: replyFocusNode,
                            maxLines: 4,
                            minLines: 1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Ask A Doubt",
                              hintStyle: GoogleFonts.inter(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return Container(
                                  height: 0.2.sh,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CircleAvatar(
                                        radius: 35.r,
                                        child: GestureDetector(
                                          onTap: () {
                                            getPDF();
                                          },
                                          child: Icon(
                                            Icons.picture_as_pdf,
                                            size: 32.sp,
                                          ),
                                        ),
                                      ),
                                      CircleAvatar(
                                          radius: 35.r,
                                          child: GestureDetector(
                                            onTap: () {
                                              takePictureFromCamera();
                                            },
                                            child: Icon(
                                              Icons.video_camera_back_outlined,
                                              size: 32.sp,
                                            ),
                                          )),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.attach_file_rounded,
                            size: 32.sp,
                            color: Colors.white,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            getGal();
                          },
                          child: Icon(
                            Icons.image,
                            size: 32.sp,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(8.h),
                  decoration: BoxDecoration(
                      color: lightBlue,
                      borderRadius: BorderRadius.circular(10.r)),
                  child: GestureDetector(
                    onTap: () {
                      if (!isVioceMsg) {
                        replyingtoMsg != ""
                            ? setState(() {
                                newmsgsssssssssssssssss.add(msgmodel(
                                    keyname: "user2",
                                    value: msg.text,
                                    replied: true,
                                    repliedToMsgContent: replyingtoMsg,
                                    repliedToWhom: whomWeAreReplying,
                                    sentTime:
                                        "${DateTime.now().hour}:${DateTime.now().minute}",
                                    username: "User2"));
                                msg.clear();
                              })
                            : setState(() {
                                newmsgsssssssssssssssss.add(msgmodel(
                                    keyname: "user2",
                                    value: msg.text,
                                    replied: false,
                                    sentTime:
                                        "${DateTime.now().hour}:${DateTime.now().minute}",
                                    username: "User2"));
                                msg.clear();
                              });
                        setState(() {
                          replyingtoMsg = "";
                          whomWeAreReplying = "";
                        });
                      } else {
                        replyingtoMsg != ""
                            ? setState(() {
                                newmsgsssssssssssssssss.add(msgmodel(
                                    keyname: "user1",
                                    value: msg.text,
                                    replied: true,
                                    repliedToMsgContent: replyingtoMsg,
                                    repliedToWhom: whomWeAreReplying,
                                    sentTime:
                                        "${DateTime.now().hour}:${DateTime.now().minute}",
                                    username: "User1"));
                                msg.clear();
                              })
                            : setState(() {
                                newmsgsssssssssssssssss.add(msgmodel(
                                    keyname: "user1",
                                    value: msg.text,
                                    replied: false,
                                    sentTime:
                                        "${DateTime.now().hour}:${DateTime.now().minute}",
                                    username: "User1"));
                                msg.clear();
                              });

                        setState(() {
                          replyingtoMsg = "";
                          whomWeAreReplying = "";
                        });
                      }
                    },
                    onLongPress: () {
                      setState(() {
                        isVioceMsg = !isVioceMsg;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isVioceMsg
                          ? Icon(
                              Icons.mic,
                              size: 24.sp,
                              color: Colors.white,
                            )
                          : Icon(
                              Icons.send,
                              size: 24.sp,
                              color: Colors.white,
                            ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

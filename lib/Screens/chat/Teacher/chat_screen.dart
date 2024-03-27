// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/Screens/chat/Teacher/pdf_in%20_chat_view.dart';
import 'package:school_management_system/Screens/chat/Teacher/teacher_view_chat_image.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:swipe_to/swipe_to.dart';

class MessageModel {
  String keyname;
  String username;
  String sentTime;
  bool replied;
  String? repliedToMsgContent;
  String? repliedToWhom;
  var repliedToImage;
  var repliedToPdf;
  String? value;
  List<XFile>? images;
  File? pdf;

  MessageModel({
    required this.keyname,
    this.value,
    this.repliedToMsgContent,
    this.repliedToWhom,
    required this.replied,
    required this.username,
    required this.sentTime,
    this.images,
    this.repliedToImage,
    this.pdf,
    this.repliedToPdf,
  });
}

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({
    super.key,
  });

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  bool isPhotoSelected = false;
  bool isVioceMsg = false;
  bool show = false;
  bool sendButton = true;
  List<MessageModel> newMsg1 = [];
  TextEditingController messageController = TextEditingController();
  List<XFile> selectedImages = []; // Store selected images
  ImagePicker image = ImagePicker();
  bool isChecked = false;
  File? file;

  //............... swipe.................................................
  String replyingtoMsg = "";
  String whomWeAreReplying = "";
  final replyFocusNode = FocusNode();
  TextEditingController msg = TextEditingController();
  var replyingToImage;
  var replyingToPdf;

//..............................................................................................
  Future<void> pickImages() async {
    final List<XFile> images = await ImagePicker().pickMultiImage();

    if (!isVioceMsg) {
      replyingtoMsg != "" && file != null
          ? setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user2",
                  value: msg.text,
                  replied: true,
                  images: images,
                  repliedToMsgContent: replyingtoMsg,
                  repliedToWhom: whomWeAreReplying,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User2"));
              msg.clear();
            })
          : setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user2",
                  value: msg.text,
                  images: images,
                  replied: false,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User2"));
              msg.clear();
            });
      setState(() {
        replyingtoMsg = "";
        whomWeAreReplying = "";
      });
    } else {
      replyingtoMsg != "" && file != null
          ? setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user1",
                  value: msg.text,
                  images: images,
                  replied: true,
                  repliedToMsgContent: replyingtoMsg,
                  repliedToWhom: whomWeAreReplying,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User1"));
              msg.clear();
            })
          : setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user1",
                  value: msg.text,
                  images: images,
                  replied: false,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User1"));
              msg.clear();
            });

      setState(() {
        replyingtoMsg = "";
        whomWeAreReplying = "";
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

      if (!isVioceMsg) {
        replyingtoMsg != "" && file != null
            ? setState(() {
                newMsg1.add(MessageModel(
                    keyname: "user2",
                    value: msg.text,
                    replied: true,
                    pdf: selectedFile,
                    repliedToMsgContent: replyingtoMsg,
                    repliedToWhom: whomWeAreReplying,
                    sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                    username: "User2"));
                msg.clear();
              })
            : setState(() {
                newMsg1.add(MessageModel(
                    keyname: "user2",
                    value: msg.text,
                    pdf: selectedFile,
                    replied: false,
                    sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                    username: "User2"));
                msg.clear();
              });
        setState(() {
          replyingtoMsg = "";
          whomWeAreReplying = "";
        });
      } else {
        replyingtoMsg != "" && file != null
            ? setState(() {
                newMsg1.add(MessageModel(
                    keyname: "user1",
                    value: msg.text,
                    replied: true,
                    pdf: selectedFile,
                    repliedToMsgContent: replyingtoMsg,
                    repliedToWhom: whomWeAreReplying,
                    sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                    username: "User1"));
                msg.clear();
              })
            : setState(() {
                newMsg1.add(MessageModel(
                    keyname: "user1",
                    value: msg.text,
                    pdf: selectedFile,
                    replied: false,
                    sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                    username: "User1"));
                msg.clear();
              });

        setState(() {
          replyingtoMsg = "";
          whomWeAreReplying = "";
        });
      }
    }
  }

  Future<void> takePictureFromCamera() async {
    try {
      final imagePicker = ImagePicker();
      final XFile? pickedImage = await imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50, // Adjust image quality as needed
        preferredCameraDevice: CameraDevice.rear, // Specify camera device
      );
      if (pickedImage != null) {
        setState(() {
          selectedImages.add(pickedImage);
        });
      }
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
//....
    if (!isVioceMsg) {
      replyingtoMsg != "" && file != null
          ? setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user1",
                  value: msg.text,
                  replied: true,
                  images: selectedImages,
                  repliedToMsgContent: replyingtoMsg,
                  repliedToWhom: whomWeAreReplying,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User1"));
              msg.clear();
            })
          : setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user1",
                  value: msg.text,
                  images: selectedImages,
                  replied: false,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User1"));
              msg.clear();
            });
      setState(() {
        replyingtoMsg = "";
        whomWeAreReplying = "";
      });
    } else {
      replyingtoMsg != "" && file != null
          ? setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user2",
                  value: msg.text,
                  images: selectedImages,
                  replied: true,
                  repliedToMsgContent: replyingtoMsg,
                  repliedToWhom: whomWeAreReplying,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User2"));
              msg.clear();
            })
          : setState(() {
              newMsg1.add(MessageModel(
                  keyname: "user2",
                  value: msg.text,
                  images: selectedImages,
                  replied: false,
                  sentTime: "${DateTime.now().hour}:${DateTime.now().minute}",
                  username: "User2"));
              msg.clear();
            });

      setState(() {
        replyingtoMsg = "";
        whomWeAreReplying = "";
      });
    }
  }

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
            height: 0.11.sh,
            width: 1.0.sw,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 0.05.sw,
                  ),
                  const CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://imgs.search.brave.com/k_9AIFjJQjBjTnvKm5YAOLa9e8uZdzUSj15RoL4t4yc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzU1LzA0Lzk3/LzM2MF9GXzE1NTA0/OTc4Nl9DaDE3Z1Jm/UGptS0c1TjlTMjFW/TXM4TFdCa2prZlZE/aS5qcGc"),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    "Maths Group",
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
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 70),
                child: Column(
                  children: List.generate(newMsg1.length, (index) {
                    return SwipeTo(
                      swipeSensitivity: 15,
                      animationDuration: const Duration(milliseconds: 500),
                      onRightSwipe: (details) {
                        setState(() {
                          replyingToImage = newMsg1[index].images == null
                              ? null
                              : newMsg1[index].images![0];
                          replyingToPdf = newMsg1[index].pdf;
                          replyingtoMsg = newMsg1[index].value == null
                              ? ""
                              : newMsg1[index].value!;
                          log(replyingtoMsg);
                          replyFocusNode.requestFocus();
                          whomWeAreReplying = newMsg1[index].username;
                        });
                      },
                      child: Container(
                          child: newMsg1[index].keyname == "user1"
                              ? Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (newMsg1[index].pdf != null) {
                                            Get.to(() => ChatPdfPreviewPage(
                                                  path:
                                                      newMsg1[index].pdf?.path,
                                                ));
                                          } else {
                                            log("It is not pdf");
                                          }
                                        },
                                        child: ChatBubble(
                                          clipper: ChatBubbleClipper1(
                                              type: BubbleType.receiverBubble),
                                          backGroundColor:
                                              const Color(0xffE7E7ED),
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              newMsg1[index].replied
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w),
                                                      decoration: BoxDecoration(
                                                          color: deepBlue
                                                              .withOpacity(0.3),
                                                          border: Border(
                                                            left: BorderSide(
                                                                width: 5.w,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                              newMsg1[index]
                                                                  .repliedToWhom
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          newMsg1[index]
                                                                      .repliedToPdf !=
                                                                  null
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 150,
                                                                    width:
                                                                        0.3.sw,
                                                                    child:
                                                                        PDFView(
                                                                      filePath: newMsg1[
                                                                              index]
                                                                          .repliedToPdf
                                                                          .path,
                                                                    ),
                                                                  ),
                                                                )
                                                              : newMsg1[index]
                                                                          .repliedToImage !=
                                                                      null
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.r),
                                                                        child: Image.file(
                                                                            height:
                                                                                0.2.sh,
                                                                            File(newMsg1[index].repliedToImage!.path)),
                                                                      ),
                                                                    )
                                                                  : SizedBox(
                                                                      width: newMsg1[index].repliedToMsgContent!.length >
                                                                              20
                                                                          ? 0.7
                                                                              .sw
                                                                          : null,
                                                                      child:
                                                                          Text(
                                                                        newMsg1[index]
                                                                            .repliedToMsgContent!,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                        style: GoogleFonts
                                                                            .inter(),
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 0,
                                                    ),
                                              SizedBox(
                                                width: newMsg1[index]
                                                            .value!
                                                            .length >
                                                        30
                                                    ? 0.7.sw
                                                    : null,
                                                child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    newMsg1[index].username,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                              newMsg1[index].images != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      child: Container(
                                                        child: Column(
                                                          children:
                                                              List.generate(
                                                            newMsg1[index]
                                                                .images!
                                                                .length,
                                                            (insideindex) =>
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                TeacherChatDetailedPhotoView(file: newMsg1[index].images![insideindex])));
                                                              },
                                                              child: Image.file(
                                                                width: 0.7.sw,
                                                                File(newMsg1[
                                                                        index]
                                                                    .images![
                                                                        insideindex]
                                                                    .path),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : newMsg1[index].pdf != null
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 100.h,
                                                              width: 0.7.sw,
                                                              child: PDFView(
                                                                enableSwipe:
                                                                    false,
                                                                fitPolicy:
                                                                    FitPolicy
                                                                        .BOTH,
                                                                filePath:
                                                                    newMsg1[index]
                                                                        .pdf!
                                                                        .path,
                                                              ),
                                                            ),
                                                            Text("Name of pdf")
                                                          ],
                                                        )
                                                      : Container(
                                                          child: Text(
                                                            newMsg1[index]
                                                                    .value ??
                                                                "null",
                                                            // textAlign:
                                                            //     TextAlign.left,
                                                          ),
                                                        ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    newMsg1[index].sentTime,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: GestureDetector(
                                        onTap: () {
                                          if (newMsg1[index].pdf != null) {
                                            Get.to(() => ChatPdfPreviewPage(
                                                  path:
                                                      newMsg1[index].pdf?.path,
                                                ));
                                          } else {
                                            log("It is not pdf");
                                          }
                                        },
                                        child: ChatBubble(
                                          clipper: ChatBubbleClipper1(
                                              type: BubbleType.receiverBubble),
                                          backGroundColor: lightBlue,
                                          margin:
                                              const EdgeInsets.only(top: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              newMsg1[index].replied
                                                  ? Container(
                                                      padding: EdgeInsets.only(
                                                          left: 5.w),
                                                      decoration: BoxDecoration(
                                                          color: deepBlue
                                                              .withOpacity(0.3),
                                                          border: Border(
                                                            left: BorderSide(
                                                                width: 5.w,
                                                                color: Colors
                                                                    .black),
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.r)),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          SizedBox(
                                                            child: Text(
                                                              newMsg1[index]
                                                                  .repliedToWhom
                                                                  .toString(),
                                                              overflow:
                                                                  TextOverflow
                                                                      .clip,
                                                              style: GoogleFonts.inter(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          newMsg1[index]
                                                                      .repliedToPdf !=
                                                                  null
                                                              ? Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child:
                                                                      SizedBox(
                                                                    height: 150,
                                                                    width:
                                                                        0.3.sw,
                                                                    child:
                                                                        PDFView(
                                                                      filePath: newMsg1[
                                                                              index]
                                                                          .repliedToPdf
                                                                          .path,
                                                                    ),
                                                                  ),
                                                                )
                                                              : newMsg1[index]
                                                                          .repliedToImage !=
                                                                      null
                                                                  ? Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10.r),
                                                                        child: Image.file(
                                                                            height:
                                                                                0.2.sh,
                                                                            File(newMsg1[index].repliedToImage!.path)),
                                                                      ),
                                                                    )
                                                                  : SizedBox(
                                                                      width: newMsg1[index].repliedToMsgContent!.length >
                                                                              20
                                                                          ? 0.7
                                                                              .sw
                                                                          : null,
                                                                      child:
                                                                          Text(
                                                                        newMsg1[index]
                                                                            .repliedToMsgContent!,
                                                                        overflow:
                                                                            TextOverflow.clip,
                                                                        style: GoogleFonts
                                                                            .inter(),
                                                                        maxLines:
                                                                            2,
                                                                      ),
                                                                    ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(
                                                      width: 0,
                                                    ),
                                              SizedBox(
                                                width: newMsg1[index]
                                                            .value!
                                                            .length >
                                                        30
                                                    ? 0.7.sw
                                                    : null,
                                                child: Text(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    newMsg1[index].username,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400)),
                                              ),
                                              newMsg1[index].images != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      child: Container(
                                                        child: Column(
                                                          children:
                                                              List.generate(
                                                            newMsg1[index]
                                                                .images!
                                                                .length,
                                                            (insideindex) =>
                                                                GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                TeacherChatDetailedPhotoView(file: newMsg1[index].images![insideindex])));
                                                              },
                                                              child: Image.file(
                                                                width: 0.7.sw,
                                                                File(newMsg1[
                                                                        index]
                                                                    .images![
                                                                        insideindex]
                                                                    .path),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  : newMsg1[index].pdf != null
                                                      ? Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              height: 100.h,
                                                              width: 0.7.sw,
                                                              child: PDFView(
                                                                enableSwipe:
                                                                    false,
                                                                fitPolicy:
                                                                    FitPolicy
                                                                        .BOTH,
                                                                filePath:
                                                                    newMsg1[index]
                                                                        .pdf!
                                                                        .path,
                                                              ),
                                                            ),
                                                            Text("Name of pdf")
                                                          ],
                                                        )
                                                      : Container(
                                                          child: Text(
                                                            newMsg1[index]
                                                                .value!,
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    newMsg1[index].sentTime,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                    );
                  }),
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
          replyingtoMsg != "" ||
                  replyingToImage != null ||
                  replyingToPdf != null
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
                        borderRadius: BorderRadius.circular(5.r),
                      ),
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
                                      replyingToImage = null;
                                      replyingToPdf = null;
                                    });
                                  },
                                  child: const Icon(Icons.close))
                            ],
                          ),
                          replyingToImage != null
                              ? Image.file(
                                  File(
                                    replyingToImage.path,
                                  ),
                                  height: 55.h,
                                  fit: BoxFit.cover,
                                  filterQuality: FilterQuality.high,
                                  // width: 45.w,
                                )
                              : replyingToPdf != null
                                  ? SizedBox(
                                      height: 55.h,
                                      width: 0.2.sw,
                                      child: PDFView(
                                          enableSwipe: false,
                                          filePath: replyingToPdf.path),
                                    )
                                  :

                                  // replyingToPdf != null
                                  Text(
                                      replyingtoMsg,
                                      overflow: TextOverflow.clip,
                                      style: GoogleFonts.inter(),
                                      maxLines: 2,
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
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Card(
                    color: deepBlue,
                    margin: const EdgeInsets.only(left: 2, right: 2, bottom: 8),
                    child: TextFormField(
                      focusNode: replyFocusNode,
                      style: const TextStyle(color: Colors.white),
                      controller: messageController,
                      textAlignVertical: TextAlignVertical.center,
                      keyboardType: TextInputType.multiline,
                      // onChanged: (value) {

                      // },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Type a message",
                        hintStyle: const TextStyle(
                          color: Colors.white,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.attach_file,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                getPDF();
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.photo,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      width: double.infinity,
                                      height: 0.12.sh,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              takePictureFromCamera();
                                              selectedImages = [];
                                            },
                                            child: CircleAvatar(
                                                backgroundColor: deepBlue,
                                                radius: 33,
                                                child: const Icon(
                                                  Icons.camera_alt,
                                                  color: Colors.white,
                                                )),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              pickImages();
                                              //getGal();
                                            },
                                            child: CircleAvatar(
                                                backgroundColor: deepBlue,
                                                radius: 33,
                                                child: const Icon(
                                                  Icons.photo,
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                        contentPadding: const EdgeInsets.all(5),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 8,
                    right: 2,
                    left: 2,
                  ),
                  child: CircleAvatar(
                    radius: 25,
                    //backgroundColor: Color.fromARGB(255, 252, 86, 46),
                    backgroundColor: deepBlue,
                    child: GestureDetector(
                      onLongPress: () {
                        setState(() {
                          isVioceMsg = !isVioceMsg;
                        });
                      },
                      onTap: () {
                        if (!isVioceMsg) {
                          replyingtoMsg != "" ||
                                  replyingToImage != null ||
                                  replyingToPdf != null
                              ? setState(() {
                                  newMsg1.add(MessageModel(
                                      keyname: "user2",
                                      value: messageController.text,
                                      replied: true,
                                      repliedToImage: replyingToImage,
                                      repliedToPdf: replyingToPdf,
                                      repliedToMsgContent: replyingtoMsg,
                                      repliedToWhom: whomWeAreReplying,
                                      sentTime:
                                          "${DateTime.now().hour}:${DateTime.now().minute}",
                                      username: "User2"));
                                  messageController.clear();
                                })
                              : setState(() {
                                  newMsg1.add(MessageModel(
                                      keyname: "user2",
                                      value: messageController.text,
                                      replied: false,
                                      repliedToImage: replyingToImage,
                                      repliedToPdf: replyingToPdf,
                                      sentTime:
                                          "${DateTime.now().hour}:${DateTime.now().minute}",
                                      username: "User2"));
                                  messageController.clear();
                                });
                          setState(() {
                            replyingtoMsg = "";
                            whomWeAreReplying = "";
                            replyingToImage = null;
                            replyingToPdf = null;
                          });
                        } else {
                          replyingtoMsg != "" ||
                                  replyingToImage != null ||
                                  replyingToPdf != null
                              ? setState(() {
                                  newMsg1.add(MessageModel(
                                      keyname: "user1",
                                      value: messageController.text,
                                      replied: true,
                                      repliedToImage: replyingToImage,
                                      repliedToPdf: replyingToPdf,
                                      repliedToMsgContent: replyingtoMsg,
                                      repliedToWhom: whomWeAreReplying,
                                      sentTime:
                                          "${DateTime.now().hour}:${DateTime.now().minute}",
                                      username: "User1"));
                                  messageController.clear();
                                })
                              : setState(() {
                                  newMsg1.add(MessageModel(
                                      keyname: "user1",
                                      value: messageController.text,
                                      replied: false,
                                      sentTime:
                                          "${DateTime.now().hour}:${DateTime.now().minute}",
                                      username: "User1"));
                                  messageController.clear();
                                });

                          setState(() {
                            replyingtoMsg = "";
                            whomWeAreReplying = "";
                            replyingToImage = null;
                            replyingToPdf = null;
                          });
                        }
                      },
                      child: Icon(
                        isVioceMsg ? Icons.send : Icons.mic,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

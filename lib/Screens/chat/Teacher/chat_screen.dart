import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_full_pdf_viewer_null_safe/full_pdf_viewer_scaffold.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:school_management_system/Screens/chat/Teacher/teacher_view_chat_image.dart';
import 'package:school_management_system/Services/Url_launcher.dart/method.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:url_launcher/url_launcher.dart';

class msgmodel {
  String? keyname;
  String? username;
  String? sentTime;
  String? value;
  List<XFile>? images;
  File? pdf;
  msgmodel({
    this.keyname,
    this.value,
    this.username,
    this.sentTime,
    this.images,
    this.pdf,
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
  List<msgmodel> newMsg1 = [];
  TextEditingController messageController = TextEditingController();
  List<XFile> selectedImages = []; // Store selected images
  ImagePicker image = ImagePicker();
  bool isChecked = false;
  File? file;

  //...........................................................................

  Future<void> pickImages() async {
    final List<XFile>? images = await ImagePicker().pickMultiImage();
    if (images != null && images.isNotEmpty) {
      setState(() {
        selectedImages = images;
      });
    }
    if (sendButton == true) {
      setState(() {
        newMsg1.add(
          msgmodel(
            keyname: "user1",
            value: messageController.text,
            sentTime: "17:30",
            username: "user1",
            images: selectedImages,
            pdf: file,
          ),
        );
      });
      messageController.clear();
      selectedImages = [];
      file = null;
    } else {
      setState(() {
        newMsg1.add(
          msgmodel(
            keyname: "user2",
            value: messageController.text,
            sentTime: "17:30",
            username: "User2",
            images: selectedImages,
            pdf: file,
          ),
        );
      });
      messageController.clear();
      selectedImages = [];
      file = null;
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

    if (sendButton == true) {
      setState(() {
        newMsg1.add(
          msgmodel(
            keyname: "user1",
            value: messageController.text,
            sentTime: "17:30",
            username: "user1",
            images: selectedImages,
            pdf: file,
          ),
        );
      });
      messageController.clear();
      selectedImages = [];
      file = null;
    } else {
      setState(() {
        newMsg1.add(
          msgmodel(
            keyname: "user2",
            value: messageController.text,
            sentTime: "17:30",
            username: "User2",
            images: selectedImages,
            pdf: file,
          ),
        );
      });
      messageController.clear();
      selectedImages = [];
      file = null;
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
    if (sendButton == true) {
      setState(() {
        newMsg1.add(
          msgmodel(
            keyname: "user1",
            value: messageController.text,
            sentTime: "17:30",
            username: "user1",
            images: selectedImages,
            pdf: file,
          ),
        );
      });
      messageController.clear();
      selectedImages = [];
      file = null;
    } else {
      setState(() {
        newMsg1.add(
          msgmodel(
            keyname: "user2",
            value: messageController.text,
            sentTime: "17:30",
            username: "User2",
            images: selectedImages,
            pdf: file,
          ),
        );
      });
      messageController.clear();
      selectedImages = [];
      file = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    LaunceToWeb launceweb = LaunceToWeb();
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
              child: Column(
                children: List.generate(newMsg1.length, (index) {
                  return Container(
                      child: newMsg1[index].keyname == "user1"
                          ? Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: ChatBubble(
                                    clipper: ChatBubbleClipper1(
                                        type: BubbleType.receiverBubble),
                                    backGroundColor: const Color(0xffE7E7ED),
                                    margin: const EdgeInsets.only(top: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              newMsg1[index].value!.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              newMsg1[index].username ?? "",
                                              style: GoogleFonts.inter(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400)),
                                        ),

                                        SizedBox(
                                          width:
                                              newMsg1[index].value!.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newMsg1[index].value ?? "",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(height: 8),
                                              // For Image View
                                              if (newMsg1[index].images !=
                                                      null &&
                                                  newMsg1[index]
                                                      .images!
                                                      .isNotEmpty)
                                                Column(
                                                  children: newMsg1[index]
                                                      .images!
                                                      .map((image) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TeacherChatDetailedPhotoView(
                                                                        file:
                                                                            image)));
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 4.0),
                                                        height: 200,
                                                        width: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          image:
                                                              DecorationImage(
                                                            image: FileImage(
                                                                File(image
                                                                    .path)),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              //For pdf view
                                            ],
                                          ),
                                        ),

                                        //.......
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              newMsg1[index].sentTime ?? "",
                                              style: GoogleFonts.inter(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ChatBubble(
                                    clipper: ChatBubbleClipper1(
                                        type: BubbleType.sendBubble),
                                    alignment: Alignment.topRight,
                                    margin: const EdgeInsets.only(top: 20),
                                    backGroundColor: const Color.fromARGB(
                                        255, 255, 152, 127),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width:
                                              newMsg1[index].value!.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Text(
                                            newMsg1[index].username ?? "",
                                            overflow: TextOverflow.ellipsis,
                                            style: GoogleFonts.inter(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Colors
                                                  .black, // Set the text color to white
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              newMsg1[index].value!.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                newMsg1[index].value ?? "",
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18),
                                              ),
                                              const SizedBox(height: 8),
                                              if (newMsg1[index].images !=
                                                      null &&
                                                  newMsg1[index]
                                                      .images!
                                                      .isNotEmpty)
                                                Column(
                                                  children: newMsg1[index]
                                                      .images!
                                                      .map((image) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TeacherChatDetailedPhotoView(
                                                                        file:
                                                                            image)));
                                                      },
                                                      child: Container(
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            vertical: 4.0),
                                                        height: 200,
                                                        width: 200,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          image:
                                                              DecorationImage(
                                                            image: FileImage(
                                                                File(image
                                                                    .path)),
                                                            fit: BoxFit.fill,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              newMsg1[index].sentTime ?? "",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ));
                }),
              ),
            ),
          ),
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
                          sendButton = !sendButton;
                        });
                      },
                      onTap: () {
                        if (sendButton == true) {
                          setState(() {
                            newMsg1.add(
                              msgmodel(
                                  keyname: "user1",
                                  value: messageController.text,
                                  sentTime: "17:30",
                                  username: "user1",
                                  images: selectedImages),
                            );
                          });
                          messageController.clear();
                          selectedImages = [];
                        } else {
                          setState(() {
                            newMsg1.add(
                              msgmodel(
                                  keyname: "user2",
                                  value: messageController.text,
                                  sentTime: "17:30",
                                  username: "User2",
                                  images: selectedImages),
                            );
                          });
                          messageController.clear();
                          selectedImages = [];
                        }
                      },
                      child: Icon(
                        sendButton ? Icons.send : Icons.mic,
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

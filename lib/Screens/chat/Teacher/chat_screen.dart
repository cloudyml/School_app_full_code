import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/constants/style.dart';

class msgmodel {
  String keyname;
  String username;
  String sentTime;
  String value;
  msgmodel({
    required this.keyname,
    required this.value,
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
    //const Icon(Icons.image),
    const Icon(Icons.picture_as_pdf),
    const Icon(Icons.camera),
  ];

  static List<msgmodel> msgs1 = [
    msgmodel(
        keyname: "user1", value: "Hello", sentTime: "17:30", username: "User1"),
    msgmodel(
        keyname: "user2", value: "HI", sentTime: "17:31", username: "User2"),
    msgmodel(
        keyname: "user1",
        value: "Whats up ?",
        sentTime: "17:33",
        username: "User1"),
    msgmodel(
        keyname: "user2",
        value: "Nothing Revising maths rn",
        sentTime: "17:36",
        username: "User2"),
    msgmodel(
        keyname: "user1",
        value:
            "ok i had a doubt can you help?? plz help me in stuck at a issue and rellay can help ",
        sentTime: "17:40",
        username: "User1"),
    msgmodel(
        keyname: "user2",
        value:
            "ya sure ask, ok i had a doubt can you help?? plz help me in stuck at a issue and rellay can help ",
        sentTime: "17:45",
        username: "User2"),
    msgmodel(
        keyname: "user1",
        value: "Thanks a lot that helped me a lot",
        sentTime: "17:30",
        username: "User1"),
    msgmodel(
        keyname: "user2",
        value: "No Problem anytime...",
        sentTime: "17:50",
        username: "User2"),
  ];

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  bool isVioceMsg = false;
  bool show = false;
  bool sendButton = true;
  List<msgmodel> newMsg1 = [];
  TextEditingController messageController = TextEditingController();
  File? file;
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
                                              newMsg1[index].value.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Text(
                                              overflow: TextOverflow.ellipsis,
                                              newMsg1[index].username,
                                              style: GoogleFonts.inter(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w400)),
                                        ),
                                        SizedBox(
                                          width:
                                              newMsg1[index].value.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Text(newMsg1[index].value,
                                              style: GoogleFonts.inter(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              newMsg1[index].sentTime,
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
                                              newMsg1[index].value.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Text(
                                            newMsg1[index].username,
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
                                              newMsg1[index].value.length > 30
                                                  ? 0.7.sw
                                                  : null,
                                          child: Text(
                                            newMsg1[index].value,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              newMsg1[index].sentTime,
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
                  width: MediaQuery.of(context).size.width - 80,
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
                                              getGal();
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
                                  username: "user1"),
                            );
                          });
                          messageController.clear();
                        } else {
                          setState(() {
                            newMsg1.add(
                              msgmodel(
                                  keyname: "user2",
                                  value: messageController.text,
                                  sentTime: "17:30",
                                  username: "User2"),
                            );
                          });
                          messageController.clear();
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

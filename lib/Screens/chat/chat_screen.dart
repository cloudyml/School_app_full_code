import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
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
    const Icon(Icons.image),
    const Icon(Icons.picture_as_pdf),
    const Icon(Icons.camera),
  ];
  static List<msgmodel> msgs1 = [
    msgmodel(
        keyname: "user1", value: "Hello", sentTime: "17:30", username: "User1"),
    msgmodel(
        keyname: "user2", value: "HI!!", sentTime: "17:31", username: "User2"),
    msgmodel(
        keyname: "user1",
        value: "Hey! How have you been lately",
        sentTime: "17:33",
        username: "User1"),
    msgmodel(
        keyname: "user2",
        value:
            "Hey! I've been doing pretty well, thanks for asking. How about you",
        sentTime: "17:36",
        username: "User2"),
    msgmodel(
        keyname: "user1",
        value: "What's the most interesting thing you've done recently? ",
        sentTime: "17:40",
        username: "User1"),
    msgmodel(
        keyname: "user2",
        value:
            "Recently, I started learning how to cook new recipes, which has been quite fun.",
        sentTime: "17:45",
        username: "User2"),
    msgmodel(
        keyname: "user1",
        value:
            "Have you watched any good movies or TV shows lately? Any recommendations?",
        sentTime: "17:30",
        username: "User1"),
    msgmodel(
        keyname: "user2",
        value:
            "I watched this amazing documentary last night called The Social Dilemma. You should definitely check it out if you haven't already.",
        sentTime: "17:50",
        username: "User2"),
  ];

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  bool isVioceMsg = false;

  File? file;

  Future<void> getGal() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'jpeg', 'png', 'pdf'],
    );

    if (result != null && result.files.isNotEmpty) {
      File selectedFile = File(result.files.single.path!);

      setState(() {
        file = selectedFile;
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
                  Icon(
                    Icons.arrow_back,
                    size: 32.sp,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 0.05.sw,
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
            child: Container(
              // color: Colors.amber,
              // height: 0.7.sh,
              // width: 1.0.sw,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(ChatRoomScreen.msgs1.length, (index) {
                    return Container(
                      child: ChatRoomScreen.msgs1[index].keyname == "user1"
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 8.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              blurRadius: 10.r)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 0.3.sw,
                                              child: Row(
                                                children: [
                                                  const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        "assets/chat_user.jpg"),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    ChatRoomScreen
                                                        .msgs1[index].username,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            SizedBox(
                                              width: 0.7.sw,
                                              child: Text(
                                                  ChatRoomScreen
                                                      .msgs1[index].value,
                                                  style: GoogleFonts.inter(
                                                      fontSize: 16.sp,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              ChatRoomScreen
                                                  .msgs1[index].sentTime,
                                              style: GoogleFonts.inter(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 8.w),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.4),
                                              blurRadius: 10.r)
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10.r)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 0.3.sw,
                                              child: Row(
                                                children: [
                                                  const CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        "assets/chat_user2.jpg"),
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Text(
                                                    ChatRoomScreen
                                                        .msgs1[index].username,
                                                    style: GoogleFonts.inter(
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
                                            ),
                                            Text(
                                                ChatRoomScreen
                                                    .msgs1[index].value,
                                                style: GoogleFonts.inter(
                                                    fontSize: 16.sp,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              ChatRoomScreen
                                                  .msgs1[index].sentTime,
                                              style: GoogleFonts.inter(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                    );
                  }),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 0.72.sw,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.9)),
                        borderRadius: BorderRadius.circular(10.r)),
                    child: TextFormField(
                      maxLines: 4,
                      minLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter Message",
                        hintStyle: GoogleFonts.inter(
                          fontSize: 16.sp,
                        ),
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
                          height: 0.16.sh,
                          child: GridView.builder(
                            itemCount: ChatRoomScreen.option.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              return Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        getGal();
                                      },
                                      child: CircleAvatar(
                                        radius: 35.r,
                                        child: ChatRoomScreen.optionicon[index],
                                      ),
                                    ),
                                    Text(ChatRoomScreen.option[index])
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Icon(
                    Icons.attach_file_rounded,
                    size: 32.sp,
                  ),
                ),
                CircleAvatar(
                  radius: 25.r,
                  child: GestureDetector(
                    onLongPress: () {
                      setState(() {
                        isVioceMsg = !isVioceMsg;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: isVioceMsg
                          ? const Icon(Icons.mic)
                          : const Icon(Icons.send),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

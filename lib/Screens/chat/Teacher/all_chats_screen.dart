import 'dart:async';
import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:school_management_system/Screens/chat/Teacher/chat_screen.dart';
import 'package:school_management_system/constants/style.dart';

class TeacherAllChatLIstScreen extends StatefulWidget {
  const TeacherAllChatLIstScreen({super.key});

  @override
  State<TeacherAllChatLIstScreen> createState() =>
      _TeacherAllChatLIstScreenState();
}

class _TeacherAllChatLIstScreenState extends State<TeacherAllChatLIstScreen> {
  // late WebSocketChannel channel;

  // void reconnect() async {
  //   await Future.delayed(const Duration(seconds: 5));

  //   channel = IOWebSocketChannel.connect(
  //       'ws://13.232.53.26:3000/chat-application/STP');
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   channel = IOWebSocketChannel.connect(
  //       'ws://13.232.53.26:3000/chat-application/STP');
  //   channel.stream.listen((message) {
  //     log('Received: $message');
  //   }, onError: (error) {
  //     log('Error: $error');
  //     reconnect(); // Call reconnect on error
  //   }, onDone: () {
  //     log('Connection closed');
  //   });
  // }

  // @override
  // void dispose() {
  //   connect.close();
  //   super.dispose();
  // }
  void connect() {
    var socket = IO
        .io('http://13.232.53.26:3000/chat-application/STP', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.on('connect', (_) {
      log('Socket Connected Successfully');
    });
    socket.on('disconnect', (_) => log('Disconnected from socket server'));
  }

  @override
  void initState() {
    super.initState();
    connect();
  }

//..............................................................................
  void sendDataToGroup(String data, String groupName) {
    var socket = IO
        .io('http://13.232.53.26:3000/chat-application/STP', <String, dynamic>{
      'transports': ['websocket'],
    });
    socket.emit('get STP-group', {'data': data, 'group': groupName});
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
                    width: 0.05.sw,
                  ),
                  Text(
                    "All Chats",
                    style: GoogleFonts.inter(
                        fontSize: 22.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(6, (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const ChatRoomScreen();
                        },
                      ));
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                blurRadius: 10.r)
                          ],
                          borderRadius: BorderRadius.circular(10.r)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32.r,
                                backgroundImage: const NetworkImage(
                                    "https://imgs.search.brave.com/k_9AIFjJQjBjTnvKm5YAOLa9e8uZdzUSj15RoL4t4yc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzU1LzA0Lzk3/LzM2MF9GXzE1NTA0/OTc4Nl9DaDE3Z1Jm/UGptS0c1TjlTMjFW/TXM4TFdCa2prZlZE/aS5qcGc"),
                              ),
                              SizedBox(
                                width: 15.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 0.3.sw,
                                    child: Text(
                                      "User$index",
                                      style: GoogleFonts.inter(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  SizedBox(
                                    width: 0.7.sw,
                                    child: Text("Hello User whats up",
                                        style: GoogleFonts.inter(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "9:30",
                                style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          )),
        ],
      ),
    );
  }
}

//......................... below one is get group list.................

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:school_management_system/Services/teacher_shared_service.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;

// class TeacherAllChatLIstScreen extends StatefulWidget {
//   const TeacherAllChatLIstScreen({Key? key}) : super(key: key);

//   @override
//   State<TeacherAllChatLIstScreen> createState() =>
//       _TeacherAllChatLIstScreenState();
// }

// class _TeacherAllChatLIstScreenState extends State<TeacherAllChatLIstScreen> {
//   late IO.Socket socket;
//   final List<Map<String, dynamic>> groups = []; // List to store group data

//   @override
//   void initState() {
//     super.initState();
//     connect();
//   }

//   void connect() {
//     socket = IO
//         .io('http://13.232.53.26:3000/chat-application/STP', <String, dynamic>{
//       'transports': ['websocket'],
//     });
//     socket.connect();
//     socket.onConnect((_) {
//       log('Socket Connected Successfully !!');
//       emitGetStpGroup();
//     });

//     socket.on('get STP-group', (data) {
//       log('Received group data: $data');

//       setState(() {
//         if (data['status'] == true) {
//           log("Entered to the Data");
//           try {
//             groups.clear();
//             groups.addAll(List<Map<String, dynamic>>.from(data['data']));
//             log('Groups list updated: $groups');
//           } catch (error) {
//             log('Error updating groups list: $error');
//           }
//         } else {
//           log('Error: Server response status is not "true".');
//         }
//       });
//     });
//   }

//   void emitGetStpGroup() async {
//     log("Entered");

//     try {
//       final String userToken =
//           TeacherSharedServices.loginDetails()!.data!.token.toString();

//       if (userToken.isNotEmpty) {
//         socket.emit('get STP-group', {
//           'token': userToken,
//           'memberId': TeacherSharedServices.loginDetails()!.data!.id.toString(),
//         });
//       } else {
//         log('User token not available for "get STP-group" request.');
//       }
//     } catch (error) {
//       log('Error emitting "get STP-group" event: $error');
//     }
//   }

//   @override
//   void dispose() {
//     socket.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         children: [
//           Container(
//             decoration: const BoxDecoration(
//               gradient:
//                   LinearGradient(colors: [Colors.lightBlue, Colors.purple]),
//             ),
//             height: 0.11.sh,
//             width: 1.0.sw,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Icon(
//                       Icons.arrow_back,
//                       size: 32.sp,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 0.05.sw,
//                   ),
//                   Text(
//                     "All Chats",
//                     style: GoogleFonts.inter(
//                       fontSize: 22.sp,
//                       color: Colors.white,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Expanded(
//             child: Container(
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: List.generate(groups.length, (index) {
//                     final group = groups[index];
//                     return GestureDetector(
//                       onTap: () {
//                         // Handle group selection
//                       },
//                       child: Container(
//                         padding: EdgeInsets.symmetric(
//                             vertical: 10.h, horizontal: 8.w),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           boxShadow: [
//                             BoxShadow(
//                                 color: Colors.grey.withOpacity(0.4),
//                                 blurRadius: 10.r),
//                           ],
//                           borderRadius: BorderRadius.circular(10.r),
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   radius: 32.r,
//                                   backgroundImage: const NetworkImage(
//                                       "https://imgs.search.brave.com/k_9AIFjJQjBjTnvKm5YAOLa9e8uZdzUSj15RoL4t4yc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzU1LzA0Lzk3/LzM2MF9GXzE1NTA0/OTc4Nl9DaDE3Z1Jm/UGptS0c1TjlTMjFW/TXM4TFdCa2prZlZE/aS5qcGc"),
//                                 ),
//                                 SizedBox(width: 15.w),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     SizedBox(
//                                       width: 0.3.sw,
//                                       child: Text(
//                                         "${group['groupName']}",
//                                         style: GoogleFonts.inter(
//                                           fontSize: 12.sp,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     SizedBox(
//                                       width: 0.7.sw,
//                                       child: Text(
//                                         "${group['message']}",
//                                         style: GoogleFonts.inter(
//                                           fontSize: 16.sp,
//                                           fontWeight: FontWeight.w600,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.end,
//                               children: [
//                                 Text(
//                                   "${group['time']}", // Use group['time'] or actual timestamp here
//                                   style: GoogleFonts.inter(
//                                     fontSize: 12.sp,
//                                     fontWeight: FontWeight.w500,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

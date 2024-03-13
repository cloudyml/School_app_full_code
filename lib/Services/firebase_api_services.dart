import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:school_management_system/Screens/Awards/student/student_view_awards.dart';
import 'package:school_management_system/Screens/Dashboard.dart';
import 'package:school_management_system/Screens/Events/student/student_view_events.dart';
import 'package:school_management_system/main.dart';

var fcmToken;

Future<void> handelBackgroundNotification(RemoteMessage message) async {
  log('TITLE: ${message.notification?.title}');
  // log('msgggggggsasdasdsggg: ${message.category}');
  log('dataaaaaaaaaaaaaaaaaaaaaaaa: ${message.notification?.android?.tag}');
  log('dataaaaaa: ${message.data["tag"]}');
  log('dataaaaaa: ${message.notification?.title}');
  log('type: ${message.messageType.toString()}');
  // log('tag: ${message.data['tags'] as List<String>}');
  // log('dataaaaaaaaaaaaaaaaaaaaaaaaaa: ${message.data}');
  // log('image :${message.notification?.android?.imageUrl}');
}

// "/fees"
// "/events"
// ""
class FirebaseApi {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  Future<void> initNotification() async {
    await messaging.requestPermission();
    fcmToken = await messaging.getToken();
    print("this is the fcm token generated $fcmToken");
    // initpushNOtificationIos();
    FirebaseMessaging.instance.getInitialMessage().then(handelMsg);
    //to open app from notificaion when running in background
    FirebaseMessaging.onMessageOpenedApp.listen(handelMsg);
    FirebaseMessaging.onBackgroundMessage(handelBackgroundNotification);
  }

  void handelMsg(RemoteMessage? msg) {
    if (msg != null) {
      navigatorKey.currentState
          ?.pushNamed(msg.data["tag"], arguments: msg);
    }
  }

// // For ios mobile application
//   Future initpushNOtificationIos() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     //to open the app using notification

//   }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:school_management_system/Screens/Awards/student/student_view_awards.dart';
import 'package:school_management_system/Screens/Events/parent/parent_view_event.dart';
import 'package:school_management_system/Screens/Events/student/student_view_events.dart';
import 'package:school_management_system/Services/Provider/attendance_provider.dart';
import 'package:school_management_system/Services/firebase_api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Splash/splashScreen.dart';
import 'constants/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:
              "BE3w4u8FT55cFWx915NdSlyskwI3AWW0uaCy_AY9l3EGqp7VX7NHQq1hx6P2YNjg1PbayoBEeiojS_KzAiCWpaw",
          appId: "1:167650873505:android:cf329f9030a49eeb67e0e0",
          messagingSenderId: "167650873505",
          projectId: "school-app-94046"),
    );
  } else {
    await Firebase.initializeApp();
    await FirebaseApi().initNotification();
  }

  preferences = await SharedPreferences.getInstance();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (_) => AttendanceProvider(),
    ),
  ], child: const MyApp()));
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'A Student Management System',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: "/",
        routes: {
          '/': (context) => const SplashScreen(),
          ParentsViewEvents.route: (context) => const ParentsViewEvents(),
          StudentViewAwards.route: (context) => const StudentViewAwards(),
        },
        // home: const SplashScreen(),
        navigatorKey: navigatorKey,
        builder: EasyLoading.init(),
      ),
    );
  }
}

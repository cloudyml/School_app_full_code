// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:school_management_system/constants/style.dart';
// import 'package:school_management_system/widget/appBar/appbar_widget.dart';
// import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

// class TeacherChatDetailedPhotoView extends StatelessWidget {
//   final XFile file;
//   const TeacherChatDetailedPhotoView({super.key, required this.file});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(
//           MediaQuery.of(context).size.height * 0.3,
//         ),
//         child: DecorativeAppBar(
//           barHeight: MediaQuery.of(context).size.height * 0.24,
//           barPad: MediaQuery.of(context).size.height * 0.19,
//           radii: 30,
//           background: Colors.white,
//           gradient1: lightBlue,
//           gradient2: deepBlue,
//           extra: appbar("assets/gallery2.png", "Chat Image", context, () {
//             Navigator.pop(context);
//           }),
//         ),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 10),
//             child: SizedBox(
//               height: MediaQuery.of(context).size.height * 0.5,
//               child: ListView.builder(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: 1,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Image.file(
//                       File(file.path),
//                       fit: BoxFit.cover,
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:school_management_system/constants/style.dart';
import 'package:school_management_system/widget/appBar/appbar_widget.dart';
import 'package:school_management_system/widget/appBar/decorative_apbar_widget.dart';

class TeacherChatDetailedPhotoView extends StatelessWidget {
  final XFile file;
  const TeacherChatDetailedPhotoView({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          MediaQuery.of(context).size.height * 0.3,
        ),
        child: DecorativeAppBar(
          barHeight: MediaQuery.of(context).size.height * 0.24,
          barPad: MediaQuery.of(context).size.height * 0.19,
          radii: 30,
          background: Colors.white,
          gradient1: lightBlue,
          gradient2: deepBlue,
          extra: appbar("assets/gallery2.png", "Chat Image", context, () {
            Navigator.pop(context);
          }),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  File(file.path),
                  fit: BoxFit.cover,
                ),
              )),
        ],
      ),
    );
  }
}

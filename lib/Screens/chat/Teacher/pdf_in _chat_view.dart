import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:school_management_system/constants/style.dart';

class ChatPdfPreviewPage extends StatelessWidget {
  final path;
  const ChatPdfPreviewPage({
    Key? key,
    required this.path,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: lightBlue,
        title: const Text('PDF Preview'),
      ),
      body: PDFView(
        fitEachPage: true,
        filePath: path,
      ),
    );
  }
}

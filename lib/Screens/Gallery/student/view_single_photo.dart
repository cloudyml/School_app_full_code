import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';

class GalleryDetailedScreen extends StatefulWidget {
  final String imgurl;

  GalleryDetailedScreen({required this.imgurl});

  @override
  State<GalleryDetailedScreen> createState() => _GalleryDetailedScreenState();
}

class _GalleryDetailedScreenState extends State<GalleryDetailedScreen> {
  @override
  Widget build(BuildContext context) {
    var downloadProgress = 0.0;
    bool downloded = false;
    String msg = "";
    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white, size: 40),
        title: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.arrow_back_ios_new)),

                //TODO add the download option
                GestureDetector(
                    onTap: () async {
                      FileDownloader.downloadFile(
                        url: widget.imgurl,
                        onDownloadError: (errorMessage) {
                          log(errorMessage);
                          setState(() {
                            msg = errorMessage;
                            downloded = false;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Download Error\n $msg'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        onDownloadCompleted: (path) async {
                          final File file = File(path);
                          log("success");
                          setState(() {
                            downloded = false;
                            msg = "Success";
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.green,
                              content: Text('Downloaded Successfully\n $path'),
                              duration: Duration(seconds: 3),
                            ),
                          );
                        },
                        onProgress: (fileName, progress) {
                          setState(() {
                            downloadProgress = progress;
                          });
                          //  ScaffoldMessenger.of(context).showSnackBar(
                          //    SnackBar(
                          //     backgroundColor: Colors.green,
                          //     content: Text("$downloadProgress %"),
                          //     // duration: Duration(seconds: 3),
                          //   ),
                          // );
                        },
                      );
                    },
                    child: const Icon(Icons.downloading_outlined))
              ],
            ),
          ],
        ),
      ),
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(
              widget.imgurl,
            ),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
      // bottomNavigationBar: msg == "success"
      //     ? SnackBar(content: Text("Success"))
      //     : SnackBar(content: Text("message")),
    );
  }
}

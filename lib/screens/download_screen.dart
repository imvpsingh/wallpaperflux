import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../widgets/custom_text.dart';

class DownloadWallpaper extends StatefulWidget {
  final String imgUrl;

  const DownloadWallpaper({super.key, required this.imgUrl});

  @override
  State<DownloadWallpaper> createState() => _DownloadWallpaperState();
}

class _DownloadWallpaperState extends State<DownloadWallpaper> {
  // var currentYear = DateTime.now().year.toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: "Download Wallpaper",
          fontSize: 20,
          shadow: [Shadow(color: Colors.white54)],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context); // Navigates back when the back button is pressed
          },
        ),
        iconTheme: const IconThemeData(
          color: Colors.black87, // Sets the color of icons, including the back icon
        ),
        elevation: 4.0,
        bottomOpacity: 5.0,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Hero(
                    tag: widget.imgUrl,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.imgUrl,
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          await _downloadWallpaper();
                        },
                        child: const CustomText(
                          text: 'Download',
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _downloadWallpaper() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      try {
        var dio = Dio();
        var dir = await getApplicationDocumentsDirectory();
        String fileName = widget.imgUrl.split('/').last.split('?').first;
        String tempPath = '${dir.path}/$fileName';


        await dio.download(widget.imgUrl, tempPath);

        File downloadedFile = File(tempPath);
        String newPath = "/storage/emulated/0/Download/$fileName";


        await saveFile(newPath, await downloadedFile.readAsBytes());

      } catch (e) {
        Fluttertoast.showToast(
          msg: 'Failed to download wallpaper: $e',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: 'Permission denied. Cannot download the wallpaper.',
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<void> saveFile(String newPath, List<int> bytes) async {
    try {
       File file = File(newPath);
      await file.create(recursive: true);
      await file.writeAsBytes(bytes);
      Fluttertoast.showToast(msg: 'File saved successfully at $newPath',toastLength: Toast.LENGTH_LONG,);
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error saving file: $e');
    }
  }

}

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_file/open_file.dart';

import 'package:permission_handler/permission_handler.dart';


class DownLoadFiles extends StatefulWidget {
  const DownLoadFiles({Key? key}) : super(key: key);

  @override
  State<DownLoadFiles> createState() => _DownLoadFilesState();
}

class _DownLoadFilesState extends State<DownLoadFiles> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 250,
            child: ElevatedButton(onPressed: () {
              openFile(url:"https://docs.google.com/document/d/1TQNAdN6IB4vOXulkF52ftF6312ytp3JyvulOqrqIIHQ/edit#heading=h.4egyv65lt8kg",filename:"ppl.txt");
            },
            child: const Text('Download File'),),
          ),
          const SizedBox(height: 20,),
          SizedBox(
            width: 250,
            child: ElevatedButton(onPressed: () {
              // openFile(url:"https://res.cloudinary.com/govisible/image/upload/odc129a2wwbdrrntrpe5.pdf",filename:"odc129a2wwbdrrntrpe5.pdf");
              // downloadFileProgress();
              saveVideo("https://res.cloudinary.com/govisible/image/upload/odc129a2wwbdrrntrpe5.pdf", "odc129a2wwbdrrntrpe5.pdf");
            },
              child: const Text('Download File with progress'),),
          ),
          const SizedBox(height: 20,),
          Container(
            child: CircularProgressIndicator(
              value: progress,
              color: Colors.blue,
              backgroundColor: Colors.grey,
            ),
          ),
          Text(progressString),

        ],
      ),
    );
  }

  ///Will download file and open file in native file opener
  void openFile({required String url, String? filename}) async {

     final file = await downloadFile(url,filename!);
     if(file == null) return;
     
     if (kDebugMode) {
       print('path:${file.path}');
     }

     OpenFile.open(file.path);

  }

  ///Download file into private folder not visible to user
  Future<File?> downloadFile(String url, String filename) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File('${appStorage.path}/$filename');

    try{
      final response = await Dio().get(url,options: Options(
        responseType: ResponseType.bytes,
        followRedirects: false,
        receiveTimeout: 0,
      ));

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();
      return file;
    }catch(e){
      print(e);
      return null;
    }

  }

  ///Downloading File with progress bar
  Future<void> downloadFileProgress(String path, String url) async {
    Dio dio = Dio();

    try {
      var dir = await getApplicationDocumentsDirectory();
      var filename = imgUrl.split('/').last;
      await dio.download(url, path,
          onReceiveProgress: (rec, total) {
            print("Rec: $rec , Total: $total");

            setState(() {
              downloading = true;
              progress = rec / total;
              print(progress);
              progressString = "${((rec / total) * 100).toStringAsFixed(0)}%";
            });
          }).then((value) => {
            OpenFile.open(path)
      });
    } catch (e) {
      print(e);
    }

    setState(() {
      downloading = false;
      progressString = "Completed";
    });
    print("Download completed");
  }

  final imgUrl = "https://res.cloudinary.com/govisible/image/upload/odc129a2wwbdrrntrpe5.pdf";
  bool downloading = false;
  var progressString = "";
  double progress = 0.0;

  ///Save File to external storage and it is visible to users also
  Future<bool> saveVideo(String url, String fileName) async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage) &&
    // access media location needed for android 10/Q
    await _requestPermission(Permission.accessMediaLocation) &&
    // manage external storage needed for android 11/R
    await _requestPermission(Permission.manageExternalStorage)) {
          directory = await getExternalStorageDirectory();
          String newPath = "";

          List<String> paths = directory!.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/$folder";
            } else {
              break;
            }
          }
          newPath = "$newPath/LearningFlutter";
          directory = Directory(newPath);
          print(directory);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File("${directory.path}/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if(await File(saveFile.path).exists()){
        if (kDebugMode) {
          print("File All ready exits");
        }
        OpenFile.open(saveFile.path);
      }else{
        downloadFileProgress(saveFile.path,url);
      }


      /*if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
              setState(() {
                progress = value1 / value2;
              });
            });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }*/
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Function for requesting the permissions storage
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

}

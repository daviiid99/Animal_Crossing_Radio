import 'dart:io';

import '../Screens/screen.dart';
import 'package:path_provider/path_provider.dart';

class FilesIntegrity{
  // This class is used to check missing files in user's storage

  static Future<List<DownloadModel>> checkFiles() async {
    // Check for all files
    Directory path = Directory("data/user/0/com.daviiid99.ac_radio/app_flutter");
    List<DownloadModel> pending = [];

    for (String platform in DownloadModel.files.keys){
      for (String file in DownloadModel.files[platform].keys){
        var uri = DownloadModel.files[platform][file][1];
        if (!File("${path.path}/$uri").existsSync()){
          // File doesn't exists, time to add it into pending list
          DownloadModel currentDownload = DownloadModel(fileName: file, fileUrl: DownloadModel.files[platform][file][0], filePath: "${path.path}/${DownloadModel.files[platform][file][1]}");
          pending.add(currentDownload);
        }
      }
    }

    return pending;
    }
}
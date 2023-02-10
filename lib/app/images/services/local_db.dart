import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

import '../model.dart';
class ImageLocalDb {
  static const tableName = "imageLocalDb";
  List<ImageModel> getImage(){
    return Hive.box<ImageModel>(tableName).values.toList();
  }
  saveImage(ImageModel image)async{
    Box box = Hive.box<ImageModel>(tableName);
    final ids = box.values.map((e) => e.id).toSet();
      if(!ids.contains(image.id)){
        String devicePath = await _download(image.url);
        dynamic newImage = image.toJson();
        newImage['download_url'] = devicePath;
        newImage['isDownloaded'] = true;
        box.add(ImageModel.fromJson(newImage));
      }
  }

  Future<String> _download(String url) async {
    final response = await http.get(Uri.parse(url));

    final imageName =   "${DateTime.now().microsecondsSinceEpoch}${path.basename(url)}";
    final appDir = await path_provider.getApplicationDocumentsDirectory();
    final localPath = path.join(appDir.path, imageName);
    final imageFile = File(localPath);
    await imageFile.writeAsBytes(response.bodyBytes);
    return imageFile.path;
  }
  _delete(String url) async {
    final file = File(url);
    await file.delete();
  }

  deleteImage(ImageModel imageModel)async{
    Box box = Hive.box<ImageModel>(tableName);
    int i= 0;
    for(ImageModel image in box.values){
      if(image.id == imageModel.id){
        box.deleteAt(i);
        _delete(imageModel.url);
        break;
      }
      i++;
    }
  }

}
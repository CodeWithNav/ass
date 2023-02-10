import 'dart:convert';

import 'package:assignment/app/images/model.dart';
import 'package:http/http.dart' as http;
class ImageApi {
  static const baseUrl = 'https://picsum.photos/v2/list';

  Future<List<ImageModel>> getImages()async{
    http.Response res = await http.get(Uri.parse(baseUrl));
    List<dynamic> data = jsonDecode(res.body);
    return data.map((jsonData) => ImageModel.fromJson({...jsonData,'isDownloaded':false})).toList();
  }
}
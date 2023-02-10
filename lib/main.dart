import 'dart:io';

import 'package:assignment/app/images/model.dart';
import 'package:assignment/app/images/presentation/images_list/view.dart';
import 'package:assignment/app/images/services/images_api.dart';
import 'package:assignment/app/images/services/local_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Directory tempDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(tempDir.path);
  Hive.registerAdapter(ImageModelAdapter());
  await Hive.openBox<ImageModel>(ImageLocalDb.tableName);
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiRepositoryProvider(providers: [
        RepositoryProvider(create: (_)=>ImageApi()),
        RepositoryProvider(create: (_)=>ImageLocalDb()),
      ], child: const ImagesListView()),
    );
  }
}

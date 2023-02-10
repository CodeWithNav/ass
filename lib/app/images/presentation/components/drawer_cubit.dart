import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';


class DrawerCubit extends Cubit<File?> {
  DrawerCubit() : super(null);


  getImage(ImageSource source)async{
    final file = await ImagePicker().getImage(source: source);
    if(file != null){
      emit(File(file.path));
    }
  }



}

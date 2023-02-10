
import 'dart:collection';

import 'package:assignment/app/images/services/local_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import '../../../model.dart';
import '../../../services/images_api.dart';

part 'images_list_event.dart';
part 'images_list_state.dart';

class ImagesListBloc extends Bloc<ImagesListEvent, ImagesListState> {
  final ImageApi imageApi;
  final ImageLocalDb imageLocalDb;
  ImagesListBloc({required this.imageApi,required this.imageLocalDb}) : super(ImagesListLoading()) {
    on<ImagesListLoadDataEvent>((event, emit) async{
      await loadData(emit);
    });
    on<ImagesListDeleteEvent>(deleteImage);
  }
  deleteImage(ImagesListDeleteEvent event, emit)async{
    if(state is ImagesListData){
      var images = (state as ImagesListData).images;
      if(event.imageModel.isDownloaded){
        imageLocalDb.deleteImage(event.imageModel);
        images.removeWhere((element) => element.id == event.imageModel.id);
        emit(ImagesListData(images: images,isDeleted: true));
      }
    }
  }
  loadData(Emitter<ImagesListState> emit)async{
      if(state is! ImagesListLoading){
        emit(ImagesListLoading());
      }
      try {
        List<ImageModel> localRes = imageLocalDb.getImage();
        Set localIds = {};
        for(ImageModel local in localRes){
          localIds.add(local.id);
        }
        if(localRes.isNotEmpty) emit(ImagesListData(images: localRes));
        List<ImageModel> res = await imageApi.getImages();
        for(ImageModel remoteImage in res){
          if(!localIds.contains(remoteImage.id)){
            localIds.add(remoteImage.id);
            imageLocalDb.saveImage(remoteImage);
            localRes.add(remoteImage);
          }
        }
        localRes.sort((a,b)=> a.id.compareTo(b.id));
        emit(ImagesListData(images: localRes));

      }catch(e){
        emit(ImagesListError());
      }
      }
}

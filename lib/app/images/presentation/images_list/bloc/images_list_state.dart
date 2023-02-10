part of 'images_list_bloc.dart';

@immutable
abstract class ImagesListState {}

class ImagesListLoading extends ImagesListState {}
class ImagesListData extends ImagesListState{
  final List<ImageModel> images;
  final bool isDeleted;
  ImagesListData({required this.images,this.isDeleted=false});
}
class ImagesListError extends ImagesListState{
  final String message;
  ImagesListError({this.message = "something went wrong"});
}
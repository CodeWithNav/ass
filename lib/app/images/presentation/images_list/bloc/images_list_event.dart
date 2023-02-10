part of 'images_list_bloc.dart';

@immutable
abstract class ImagesListEvent {}
class ImagesListLoadDataEvent extends ImagesListEvent{

}
class ImagesListDeleteEvent extends ImagesListEvent{
    final ImageModel imageModel;
    ImagesListDeleteEvent({required this.imageModel});
}

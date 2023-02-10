import 'dart:io';

import 'package:assignment/app/images/presentation/components/drawer.dart';
import 'package:assignment/app/images/presentation/components/drawer_cubit.dart';
import 'package:assignment/app/images/presentation/image_details/view.dart';
import 'package:assignment/app/images/presentation/images_list/bloc/images_list_bloc.dart';
import 'package:assignment/app/images/services/images_api.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/local_db.dart';

class ImagesListView extends StatelessWidget {
  const ImagesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => DrawerCubit(), child:Scaffold(
      drawer: const ImageListDrawer(),
      appBar: AppBar(
        title: const Text('Images'),
      ),
      body:
          BlocProvider(create: (context) => ImagesListBloc(imageApi: RepositoryProvider.of<ImageApi>(context),imageLocalDb: RepositoryProvider.of<ImageLocalDb>(context))..add(ImagesListLoadDataEvent()),
        child: Builder(
          builder: (context) {
            return BlocConsumer<ImagesListBloc, ImagesListState>(

              listener: (context,state){
                  if((state is ImagesListData) && state.isDeleted){
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Deleted Successfully')));
                  }
              },
              builder: (context, state) {
                if(state is ImagesListData){
                  return ListView.builder(
                      itemCount: state.images.length,
                      itemBuilder: (_,i){
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: (){
                              Navigator.of(context).push( MaterialPageRoute(builder: (_)=>ImageDetailView(imageModel: state.images[i])));
                            },
                            child: Stack(
                              children: [
                                ClipRRect(
                                  key: Key(state.images[i].id),
                                  borderRadius: BorderRadius.circular(10),
                                  child: state.images[i].isDownloaded ?Image.file(File(state.images[i].url), fit: BoxFit.cover,
                                    height: 260,
                                    width: double.infinity,) :CachedNetworkImage(

                                    fit: BoxFit.cover,
                                    height: 260,
                                    width: double.infinity,
                                    imageUrl: state.images[i].url,
                                    placeholder: (context, url) => const Center(
                                      child: Icon(Icons.image),
                                    ),
                                    errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
                                  ),
                                ),
                                if(state.images[i].isDownloaded) Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: InkWell(
                                      onTap: (){
                                        showDialog(context: context, builder: (_){
                                          return AlertDialog(
                                            content: const Text("you want to delete the image"),
                                            actions: [
                                              TextButton(onPressed: (){
                                                Navigator.of(context).pop();
                                              }, child: const Text('No')),
                                              TextButton(onPressed: (){
                                                BlocProvider.of<ImagesListBloc>(context).add(ImagesListDeleteEvent(imageModel: state.images[i]));
                                                Navigator.of(context).pop();
                                              }, child: const Text('Yes'))
                                            ],
                                          );
                                        });
                                      },
                                      child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                              color: Colors.white.withOpacity(0.4),
                                              borderRadius: BorderRadius.circular(100)
                                          ),
                                          child: const Icon(Icons.delete)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
                if(state is ImagesListError){
                  return  Center(
                    child: Text(state.message),
                  );
                }

                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          }
        ),
      ),
    ));
  }
}

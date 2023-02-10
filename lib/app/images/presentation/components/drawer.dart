import 'dart:io';

import 'package:assignment/app/images/presentation/components/drawer_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageListDrawer extends StatelessWidget {
  const ImageListDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    File? image = context.watch<DrawerCubit>().state;


        return Drawer(
          child: Column(
            children:  [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.blue,
                ),
               child: Row(
                 mainAxisSize: MainAxisSize.max,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   ClipRRect(
                     borderRadius: BorderRadius.circular(50),
                     child: image != null ? Image.file(image,fit: BoxFit.cover,height: 80,width: 80,) : null,
                   ),
                 ],
               )
              ),
              ListTile(
                onTap: (){
                  context.read<DrawerCubit>().getImage(ImageSource.gallery);
                },
                title: const Text('Image From Gallery'),
                trailing: const Icon(Icons.image),
              ),
              ListTile(
                onTap: (){
                  context.read<DrawerCubit>().getImage(ImageSource.camera);
                },
                title: const Text('Image From Camera'),
                trailing: const Icon(Icons.camera),
              )
            ],
          ),
        );
  }
}

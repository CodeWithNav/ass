import 'dart:io';

import 'package:assignment/app/images/model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageDetailView extends StatelessWidget {
  const ImageDetailView({Key? key,required this.imageModel}) : super(key: key);
  final ImageModel imageModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          (imageModel.isDownloaded) ?Image.file(File(imageModel.url), fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,) : CachedNetworkImage(
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            imageUrl: imageModel.url,
            placeholder: (context, url) => const Center(
              child: Icon(Icons.image),
            ),
            errorWidget: (context, url, error) => const Center(child: Icon(Icons.error)),
          ),

          Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 34,left: 24),
                child: Row(
                  children: [
                    Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(100)
                        ),
                        child: const Icon(Icons.arrow_back)),
                    const SizedBox(width: 16,),
                    Text(imageModel.author,style: const TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),)
                  ],
                ),
              ),
            ),),

        ],
      ),
    );
  }
}

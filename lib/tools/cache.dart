// ignore_for_file: avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'theme.dart';

dynamic cacheImage(String imageLink) {
  return CachedNetworkImage(
    placeholder: (context, url) => Center(
      child: LoadingAnimationWidget.inkDrop(
        color: themeTxtColor(),
        size: MediaQuery.of(context).size.height / 10,
      ),
    ),
    errorWidget: (context, link, _) {
      print("Failed to fetch image from $link");
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.error_outlined),
          Text("Failed to fetch your image"),
        ],
      );
    },
    imageUrl: imageLink,
    fit: BoxFit.cover,
  );
}

// void clearImageCache() {
//   for(int page in pages) {
//   CachedNetworkImage.evictFromCache(page[""])
//   }
// }

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
    imageUrl: imageLink,
    fit: BoxFit.cover,
  );
}

// void clearImageCache() {
//   for(int page in pages) {
//   CachedNetworkImage.evictFromCache(page[""])
//   }
// }

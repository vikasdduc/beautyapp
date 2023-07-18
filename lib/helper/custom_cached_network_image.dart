import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget cachedNetworkImage(String url) {
  return CachedNetworkImage(
    imageUrl: url,
    progressIndicatorBuilder: (context, url, downloadProgress) => Center(
        child: CircularProgressIndicator(
      value: downloadProgress.progress,
      color: Colors.white,
    )),
    errorWidget: (context, url, error) => const Icon(Icons.error),
    fit: BoxFit.cover,
  );
}

ImageProvider cachedNetworkImageProvider(String url) {
  return CachedNetworkImageProvider(url);
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MoviePosterWidget extends StatelessWidget {
  final String image;
  final String tag;

  MoviePosterWidget({@required this.image, @required this.tag});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Container(
        width: Get.width * 0.20,
        height: 125,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CachedNetworkImage(
            imageUrl: image,
            errorWidget: (_, __, ___) {
              return Image.asset(
                "assets/images/placeholder.png",
                fit: BoxFit.fitWidth,
              );
            },
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

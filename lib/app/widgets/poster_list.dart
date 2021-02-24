import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/app/routes/app_pages.dart';
import 'package:movies_app/app/widgets/poster_item.dart';
import 'package:movies_app/core/domain/movie_poster.dart';
import 'package:movies_app/core/domain/resource.dart';

class PosterList extends StatelessWidget {
  final Resource status;
  final List<MoviePoster> posters;
  final Widget emptyWidget;
  final Widget failureWidget;
  final Function(int, String) onLongPress;
  final Function(String) onRemove;
  final int posterSelectedIndex;

  PosterList({
    @required this.status,
    @required this.posters,
    @required this.emptyWidget,
    @required this.failureWidget,
    @required this.onLongPress,
    @required this.onRemove,
    @required this.posterSelectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    if (status is Failure) {
      return failureWidget;
    } else if (posters.isEmpty) {
      return emptyWidget;
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      primary: false,
      itemCount: posters.length,
      itemBuilder: (BuildContext context, int index) {
        return PosterItem(
          movie: posters[index],
          id: posters[index].id + index.toString(),
          isSelected: posterSelectedIndex == index,
          onTap: (movie) {
            Get.toNamed(
              Routes.DETAIL,
              arguments: {
                "poster": movie,
                "id": movie.id + index.toString(),
              },
            );
          },
          onLongPress: () {
            onLongPress(index, posters[index].id);
          },
          onRemove: onRemove,
        );
      },
    );
  }
}

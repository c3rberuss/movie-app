import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movies_app/app/styles/palette.dart';
import 'package:movies_app/app/utils/functions.dart';
import 'package:movies_app/app/widgets/movie_poster_widget.dart';
import 'package:movies_app/core/domain/movie_poster.dart';

class PosterItem extends StatelessWidget {
  final MoviePoster movie;
  final Function(MoviePoster) onTap;
  final Function() onLongPress;
  final Function(String) onRemove;
  final String id;
  final bool isSelected;

  PosterItem({
    @required this.movie,
    @required this.onTap,
    this.onLongPress,
    @required this.id,
    this.isSelected = false,
    @required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap != null
            ? () {
                onTap(movie);
              }
            : null,
        onLongPress: onLongPress,
        child: Stack(
          children: [
            Row(
              children: [
                MoviePosterWidget(
                  tag: id,
                  image: movie.poster,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        movie.title,
                        style: TextStyle(
                          fontSize: 17,
                          color: Palette.white,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${capitalize(movie.type)} - ${movie.year}",
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.white,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            isSelected
                ? Container(
                    height: 125,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Palette.grey.withOpacity(0.8),
                    ),
                    child: Center(
                      child: IconButton(
                        icon: Icon(LineIcons.trash, size: 40),
                        onPressed: () {
                          onRemove(movie.id);
                        },
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

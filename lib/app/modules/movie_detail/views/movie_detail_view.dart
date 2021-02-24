import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movies_app/app/modules/movie_detail/controllers/movie_detail_controller.dart';
import 'package:movies_app/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:movies_app/app/styles/palette.dart';
import 'package:movies_app/app/widgets/custom_buttons.dart';
import 'package:movies_app/app/widgets/custom_dialog.dart';
import 'package:movies_app/app/widgets/movie_poster_widget.dart';
import 'package:movies_app/core/domain/movie_poster.dart';
import 'package:movies_app/core/domain/resource.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class MovieDetailView extends GetView<MovieDetailController> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments;
    final MoviePoster movie = args['poster'];
    final String id = args['id'];
    final Random random = Random(10);

    controller.fetchMovie(movie.id);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.darkLight,
            actions: [
              IconButton(
                icon: Icon(LineIcons.upload),
                onPressed: () {},
              ),
            ],
            flexibleSpace: Container(
              child: Stack(
                children: [
                  SizedBox(
                    width: Get.width,
                    height: 250,
                    child: CachedNetworkImage(
                      imageUrl: movie.poster,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 255,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Palette.darkLight,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: MoviePosterWidget(
                            tag: id,
                            image: movie.poster,
                          ),
                        ),
                        SizedBox(
                          width: Get.width * 0.70,
                          child: Text(
                            movie.title,
                            style: TextStyle(
                              fontSize: 20,
                              color: Palette.white,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              height: 300,
            ),
            expandedHeight: 260,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomOutlineButton(
                          text: "Where To Watch",
                          buttonType: CustomButtonType.light,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 32),
                      Expanded(
                        child: CustomOutlineButton(
                          text: "Cast & Crew",
                          buttonType: CustomButtonType.light,
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomOutlineButton(
                    text: "Trailer",
                    fullWidth: true,
                    minWidth: 500,
                    maxWidth: 500,
                    icon: LineIcons.play,
                    buttonType: CustomButtonType.light,
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: GetBuilder<MovieDetailController>(
              id: "data",
              builder: (_) {
                if (controller.status is Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Text(
                        controller.movie.plot,
                        style: TextStyle(fontSize: 15, color: Palette.white),
                      ),
                    ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _CircularPercentIndicator(
                          double.parse(controller.movie.imdbRating, (_) => 1.0),
                          "${controller.movie.votes} Ratings",
                        ),
                        _CircularPercentIndicator(
                          random.nextDouble() + 1,
                          "My Rating",
                        ),
                      ],
                    ),
                    Divider(),
                    _ViewActions(movie: movie, isInWatchlist: controller.isInWatchlist)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CircularPercentIndicator extends StatelessWidget {
  final double value;
  final String text;

  _CircularPercentIndicator(this.value, this.text);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 60.0,
      lineWidth: 6.0,
      percent: value / 10,
      center: new Text(
        "${value.toStringAsFixed(1)}",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Palette.white,
        ),
      ),
      progressColor: Palette.success,
      footer: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Palette.light,
        ),
      ),
      backgroundColor: Palette.darkLight,
    );
  }
}

class _ButtonCard extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;

  _ButtonCard({@required this.text, @required this.icon, @required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: onTap,
              child: SizedBox(
                height: 75,
                width: 75,
                child: Center(
                  child: Icon(icon, size: 45, color: Palette.light),
                ),
              ),
            ),
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: 15,
              color: Palette.light,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _ViewActions extends GetView<MovieDetailController> {
  final bool isInWatchlist;
  final MoviePoster movie;

  _ViewActions({@required this.movie, this.isInWatchlist = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, right: 16, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _ButtonCard(
              text: "Share Movie",
              icon: LineIcons.share,
              onTap: () {},
            ),
          ),
          SizedBox(width: 32),
          Expanded(
            child: _ButtonCard(
              text: isInWatchlist ? "Remove from Watchlist" : "Add to Watchlist",
              icon: LineIcons.bookmark,
              onTap: () async {
                watchlistAction(context);
              },
            ),
          ),
          SizedBox(width: 32),
          Expanded(
            child: _ButtonCard(
              text: "Create Post",
              icon: LineIcons.alternateComment,
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  void watchlistAction(BuildContext context) {
    if (isInWatchlist) {
      controller.removeFromWatchlist(movie.id).then((_) async {
        await showDialog(
          context: context,
          child: CustomDialog(text: "¡This ${movie.type} has been removed from your Watchlist!"),
        );

        Get.find<WatchlistController>().fetchWatchlist(refresh: true);
      });
    } else {
      controller.addToWatchlist(movie).then(
        (_) {
          showDialog(
            context: context,
            child: CustomDialog(text: "¡This ${movie.type} has been added to your Watchlist!"),
          );
        },
      );
    }

    controller.toggleIsInWatchlist();
  }
}

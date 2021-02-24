import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/app/modules/home/controllers/home_controller.dart';
import 'package:movies_app/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:movies_app/app/styles/palette.dart';
import 'package:movies_app/app/widgets/custom_buttons.dart';
import 'package:movies_app/app/widgets/custom_dialog.dart';
import 'package:movies_app/app/widgets/poster_list.dart';
import 'package:movies_app/core/domain/resource.dart';

class WatchlistView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<WatchlistController>(
      id: "builder",
      builder: (controller) {
        if (controller.status is Loading) {
          return SizedBox(
            height: 100,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (controller.status is Success || controller.status is Failure) {
          return RefreshIndicator(
            backgroundColor: Palette.dark,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: Palette.darkLight,
                  flexibleSpace: LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            left: 32,
                            right: 0,
                            bottom: 11,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Your watchlist",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w400,
                                  color: Palette.lightSecondary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  expandedHeight: 175,
                  collapsedHeight: 60,
                  pinned: true,
                  stretch: true,
                  floating: true,
                ),
                SliverPadding(
                  padding: EdgeInsets.only(bottom: 32, top: 33),
                  sliver: SliverToBoxAdapter(
                    child: GetBuilder<WatchlistController>(
                      id: "data",
                      builder: (_) {
                        return PosterList(
                          status: controller.status,
                          posters: controller.data,
                          emptyWidget: _Empty(),
                          failureWidget: Center(
                            child: SizedBox(
                              height: 200,
                              child: Text(
                                "Oops!! we can't load your Watchlist",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: Palette.light,
                                ),
                              ),
                            ),
                          ),
                          onLongPress: (index, id) {
                            controller.selectPoster(index, id);
                          },
                          onRemove: (poster) {
                            controller.removeFromWatchList(poster).then((_) async {
                              showDialog(
                                context: context,
                                child:
                                    CustomDialog(text: "¡It has been removed from your Watchlist!"),
                              );

                              controller.fetchWatchlist(refresh: true);
                            });
                          },
                          posterSelectedIndex: controller.posterSelected,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            onRefresh: controller.refreshData,
          );
        }

        return Center(
          child: SizedBox(
            child: Image.asset("assets/images/empty.png"),
          ),
        );
      },
    );
  }
}

class _Empty extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            "assets/images/empty.png",
            width: Get.width * 0.5,
          ),
        ),
        SizedBox(height: 32),
        Text(
          "Your Watchlist is empty",
          style: TextStyle(
            fontSize: 18,
            color: Palette.light.withOpacity(0.6),
          ),
        ),
        SizedBox(height: 100),
        CustomFilledButton(
          text: "Go to search",
          onPressed: () {
            controller.toPage(1);
          },
        ),
      ],
    );
  }
}

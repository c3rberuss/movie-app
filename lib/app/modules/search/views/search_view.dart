import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movies_app/app/modules/search/controllers/search_controller.dart';
import 'package:movies_app/app/modules/watchlist/controllers/watchlist_controller.dart';
import 'package:movies_app/app/styles/palette.dart';
import 'package:movies_app/app/widgets/custom_dialog.dart';
import 'package:movies_app/app/widgets/poster_list.dart';
import 'package:movies_app/app/widgets/search_bar.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: RefreshIndicator(
        backgroundColor: Palette.dark,
        child: CustomScrollView(
          slivers: [
            ObxValue<RxDouble>((height) {
              return SliverAppBar(
                pinned: true,
                floating: true,
                backgroundColor: Palette.darkLight,
                collapsedHeight: height.value,
                flexibleSpace: SearchBar(
                  controller: controller.textEditingController,
                  onClear: controller.clearInput,
                  clearButtonEnabled: true,
                  isShowingFilter: height.value == 170,
                  showFilter: () {
                    controller.expandFilter();
                  },
                  hideFilter: () {
                    controller.collapseFilter();
                  },
                  onFilterSelected: (filterType) {
                    controller.changeFilter(filterType: filterType);
                  },
                ),
                bottom: TabBar(
                  indicatorColor: Palette.white,
                  tabs: [
                    Tab(text: "Entertainment"),
                    Tab(text: "Friends"),
                  ],
                ),
              );
            }, controller.height),
            SliverToBoxAdapter(
              child: ObxValue<RxBool>((isLoading) {
                if (isLoading.value) {
                  return SizedBox(
                    height: 100,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return SizedBox.shrink();
              }, controller.isLoading),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 32, top: 16),
              sliver: SliverToBoxAdapter(
                child: GetBuilder<SearchController>(
                  id: "data",
                  builder: (_) {
                    return PosterList(
                      status: controller.status,
                      posters: controller.data,
                      emptyWidget: SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            "¡Search movies and series!",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w600,
                              color: Palette.light,
                            ),
                          ),
                        ),
                      ),
                      failureWidget: SizedBox(
                        height: 200,
                        child: Center(
                          child: Text(
                            "Oops!! we can't find your movie.",
                            style: TextStyle(
                              fontSize: 22,
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
                          await showDialog(
                            context: context,
                            child: CustomDialog(text: "¡It has been removed from your Watchlist!"),
                          );

                          Get.find<WatchlistController>().fetchWatchlist(refresh: true);
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
      ),
    );
  }
}

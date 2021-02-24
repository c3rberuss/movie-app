import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:movies_app/app/modules/watchlist/controllers/watchlist_controller.dart';

class HomeController extends GetxController {
  RxInt _page = 0.obs;

  RxInt get page => _page;

  final PageController pageController = PageController();

  void toPage(int page) {
    if (page == 0) {
      Get.find<WatchlistController>().fetchWatchlist();
    }

    pageController.jumpToPage(page);
    _page.value = page;
  }
}

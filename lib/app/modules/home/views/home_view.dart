import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movies_app/app/modules/account/views/account_view.dart';
import 'package:movies_app/app/modules/home/controllers/home_controller.dart';
import 'package:movies_app/app/modules/notifications/views/notifications_view.dart';
import 'package:movies_app/app/modules/search/views/search_view.dart';
import 'package:movies_app/app/modules/watchlist/views/watchlist_view.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          body: PageView(
            controller: controller.pageController,
            onPageChanged: controller.toPage,
            children: [
              WatchlistView(),
              SearchView(),
              NotificationsView(),
              AccountView(),
            ],
          ),
          bottomNavigationBar: ObxValue(
            (page) {
              return BottomNavigationBar(
                showSelectedLabels: false,
                items: [
                  BottomNavigationBarItem(icon: Icon(LineIcons.home), label: "Home"),
                  BottomNavigationBarItem(icon: Icon(LineIcons.search), label: "Search"),
                  BottomNavigationBarItem(icon: Icon(LineIcons.bell), label: "Notifications"),
                  BottomNavigationBarItem(icon: Icon(LineIcons.user), label: "Account"),
                ],
                onTap: controller.toPage,
                currentIndex: page.value,
              );
            },
            controller.page,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:movies_app/app/modules/splash/controllers/splash_controller.dart';
import 'package:movies_app/app/routes/app_pages.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        controller.db.openDb("watchlist_movies").then((_) => Get.offAllNamed(Routes.HOME));

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  "assets/icons/icon.png",
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: Get.width * 0.20,
                  child: LinearProgressIndicator(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

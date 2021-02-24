import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/app/routes/app_pages.dart';
import 'package:movies_app/app/styles/app_theme.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Open Movie DB App",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
    );
  }
}

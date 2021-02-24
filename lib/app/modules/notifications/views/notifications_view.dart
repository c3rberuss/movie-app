import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movies_app/app/styles/palette.dart';

class NotificationsView extends GetView {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Palette.darkLight,
            pinned: true,
            floating: true,
            centerTitle: true,
            title: Text(
              "My notifications",
              style: TextStyle(
                fontSize: 22,
                color: Palette.light,
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(16),
            sliver: SliverToBoxAdapter(
              child: ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return _NotificationItem();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Palette.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.5,
                  child: Image.asset(
                    "assets/images/user2.png",
                    height: 60,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "Josué Amaya ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Palette.white,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            TextSpan(
                              text:
                                  "has invited you to a meeting tomorrow for watch Breaking Bad and start "
                                  "to watch Better Call Saul.",
                              style: TextStyle(fontWeight: FontWeight.w400, color: Palette.light),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(LineIcons.calendar, color: Palette.light),
                          SizedBox(width: 8),
                          Text(
                            "1 day ago",
                            style: TextStyle(color: Palette.light),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

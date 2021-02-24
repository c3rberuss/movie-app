import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:movies_app/app/styles/palette.dart';
import 'package:movies_app/app/widgets/custom_buttons.dart';

class CustomDialog extends StatelessWidget {
  final IconData icon;
  final String text;

  CustomDialog({this.icon = LineIcons.check, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Palette.darkLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Palette.light,
            ),
            SizedBox(height: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Palette.light,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            CustomFilledButton(
              text: "Close",
              onPressed: () {
                Get.back();
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/app/styles/palette.dart';
import 'package:movies_app/app/widgets/custom_buttons.dart';
import 'package:movies_app/app/widgets/input.dart';

class AccountView extends GetView {
  final _textStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: Palette.light,
  );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/user2.png"),
              minRadius: 60,
              maxRadius: 60,
            ),
            Text(
              "User Account",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Palette.light,
              ),
            ),
            Divider(),
            SizedBox(height: 32),
            Input(
              controller: TextEditingController(text: "Josué Amaya"),
              labelWidget: Text(
                "Full name",
                style: _textStyle,
              ),
              enabled: false,
            ),
            SizedBox(height: 8),
            Input(
              controller: TextEditingController(text: "c3rberuss"),
              labelWidget: Text(
                "Nickname",
                style: _textStyle,
              ),
              enabled: false,
            ),
            SizedBox(height: 8),
            Input(
              controller: TextEditingController(text: "c3rberuss@gmail.com"),
              labelWidget: Text(
                "Email",
                style: _textStyle,
              ),
              enabled: false,
            ),
            SizedBox(height: 8),
            Input(
              controller: TextEditingController(text: "123456789"),
              isPassword: true,
              labelWidget: Text(
                "Password",
                style: _textStyle,
              ),
              enabled: false,
            ),
            SizedBox(height: 64),
            Divider(),
            CustomFilledButton(
              onPressed: () {},
              fullWidth: true,
              minWidth: 500,
              maxWidth: 500,
              text: "Save changes",
            )
          ],
        ),
      ),
    );
  }
}

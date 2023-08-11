import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundcolor;
  final Color iconColor;
  final doublesize;

  // ignore: prefer_typing_uninitialized_variables

  const AppIcon(
      {super.key,
      required this.icon,
      this.backgroundcolor = Colors.white,
      this.iconColor = Colors.black,
      this.doublesize = 40});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: backgroundcolor),
      child: Icon(
        icon,
        color: iconColor,
        size: 50,
      ),
    );
  }
}

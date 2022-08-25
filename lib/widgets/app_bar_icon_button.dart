import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  const AppBarIconButton({
    Key? key,
    required this.icon,
    required this.pressed,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback pressed;

  @override
  Widget build(BuildContext context) {

    return IconButton(
      icon: Icon(
        icon,
        color: Colors.white,
      ),
      onPressed: pressed,
    );
  }
}
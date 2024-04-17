import 'package:flutter/material.dart';
import 'package:social/utils/methods/app_methods.dart';

class CustomUserImage extends StatelessWidget {
  const CustomUserImage(
      {super.key, required this.image, this.radius = 20, required this.color});

  final String image;
  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        borderRadius: AppMethods.boderRadius(radius: radius + 30),
        border: Border.all(color: color),
      ),
      child: CircleAvatar(
        backgroundColor: color,
        foregroundColor: color,
        radius: radius,
        backgroundImage: NetworkImage(
          image,
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';

class SimpleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();
    // path start with (0.1, 0.2) point
    path.lineTo(5.0, size.height - 300);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.2);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
import 'package:flutter/material.dart';

class CustomImageWidget extends StatelessWidget {
  final String? imagepath;
  final Color? color;
  final double? size;
  const CustomImageWidget({
    Key? key,
    this.imagepath,
    this.color,
    this.size = 32.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageIcon(
      AssetImage(
        "$imagepath",
      ),
      color: color,
      size: size,
    );
  }
}

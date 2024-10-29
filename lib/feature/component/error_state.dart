import 'package:flutter/material.dart';

class ImageErrorPlaceHolder extends StatelessWidget {
  const ImageErrorPlaceHolder({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/img_error_state.webp",
      width: 100,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }
}

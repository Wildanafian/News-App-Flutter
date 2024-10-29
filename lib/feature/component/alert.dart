import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowAlert extends StatelessWidget {
  final String content;
  final VoidCallback onPressed;

  const ShowAlert({super.key, required this.content, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: const Text("Ups Something Went Wrong"),
      content: Text(content),
      actions: [TextButton(onPressed: onPressed, child: const Text("OK"))],
    );
  }
}

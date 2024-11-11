import 'package:flutter/cupertino.dart';

class NewsItemCircularLoading extends StatelessWidget {
  const NewsItemCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 100,
        height: 50,
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class GeneralCircularLoading extends StatelessWidget {
  const GeneralCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 80,
        height: 80,
        child: CupertinoActivityIndicator(
          radius: 30,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


class ShowImage extends StatelessWidget {
  String path;

  ShowImage(this.path);

  @override
  Widget build(BuildContext context) {
    return Image.asset(path);
  }
}

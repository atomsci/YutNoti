import 'package:flutter/material.dart';
import 'package:yutnoti/utility/my_constant.dart';
import 'package:yutnoti/widget/show_image.dart';

Future<Null> normalDialog(
    BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: ListTile(
        leading: ShowImage(MyConstant.account),
        title: Text(title),
        subtitle: Text(message),
      ),children: [TextButton(onPressed: () => Navigator.pop(context), child: Text('OK'))],
    ),
  );
}

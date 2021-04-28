import 'package:flutter/material.dart';
import 'package:yutnoti/states/authen.dart';
import 'package:yutnoti/states/create_acc.dart';
import 'package:yutnoti/states/my_service.dart';

final Map<String, WidgetBuilder> map = {
  '/authen': (BuildContext context) => Authen(),
  '/createAcc': (BuildContext context) => CreatAcc(),
  '/myService': (BuildContext context) => MyService(),
};

String xinitialRoute = '/authen';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: map,
      initialRoute: xinitialRoute,
      theme: ThemeData(primarySwatch: Colors.red),
    );
  }
}

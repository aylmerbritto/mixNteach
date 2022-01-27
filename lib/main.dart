import 'package:flutter/material.dart';

import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/src/appConstants.dart';
import 'package:mixnteach/routes.dart';

appTheme theme = new appTheme();
var constants = appConstants();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  var routes = mixNteachRoutes();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: theme.primaryColor,
        accentColor: theme.secondaryColor,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/',
      routes: routes.getRoutes(context),
    );
  }
}

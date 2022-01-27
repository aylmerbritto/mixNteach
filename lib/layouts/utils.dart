import 'package:flutter/material.dart';

getMeTo(context, routeName, {args = ''}) {
  Navigator.pushNamed(context, routeName, arguments: args);
}

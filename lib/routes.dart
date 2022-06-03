import 'package:mixnteach/layouts/materials/materials.dart';
import 'package:mixnteach/layouts/materials/addNew.dart';

import 'package:flutter/material.dart';
import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/layouts/materials/notesEditor.dart';

class mixNteachRoutes {
  getRoutes(context) {
    return {
      '/': (context) => materialsLandingPage(),
      '/addNewTag': (context) => addNewTag(),
      '/addNewMaterial': (context) => addNewMaterial(),
      '/addNewFile': (context) => addNewFile(),
      '/addNewLink': (context) => addNewLink(),
      '/notesEditor': (context) => EditNotePage(),
    };
  }
}

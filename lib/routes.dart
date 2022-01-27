import 'package:mixnteach/layouts/materials.dart';
import 'package:mixnteach/layouts/materials/addNew.dart';

class mixNteachRoutes {
  getRoutes(context) {
    return {
      '/': (context) => materialsLandingPage(),
      '/addNewTag': (context) => addNewTag(),
      '/addNewMaterial': (context) => addNewMaterial(),
      '/addNewFile': (context) => addNewFile()
    };
  }
}

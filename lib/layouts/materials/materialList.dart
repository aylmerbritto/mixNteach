import 'package:flutter/material.dart';

import 'package:mixnteach/layouts/templates.dart';
import 'package:mixnteach/src/materialsHelper.dart';
import 'package:mixnteach/models/learningMaterials.dart';

class materialsList extends StatefulWidget {
  String? tagOption;
  materialsList({String tagArg = ''}) {
    this.tagOption = tagArg;
  }
  @override
  _materialsListState createState() => _materialsListState();
}

class _materialsListState extends State<materialsList> {
  @override
  Widget build(BuildContext context) {
    var matObj = learningMaterialsUtils();
    return FutureBuilder<List<learningMaterials>>(
        future: matObj.getLearningMaterials(tagName: widget.tagOption!),
        builder: (BuildContext context,
            AsyncSnapshot<List<learningMaterials>> cardObj) {
          if (cardObj.connectionState == ConnectionState.done) {
            var cardList = cardObj.data!;
            return Scaffold(
                body: Container(
              //SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cardList.length,
                  itemBuilder: (context, i) {
                    return materialTile(context, cardList[i]);
                  }),
            ));
          } else {
            return getLoadingScreen();
          }
        });
  }
}

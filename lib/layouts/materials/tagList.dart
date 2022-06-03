import 'package:flutter/material.dart';

import 'package:mixnteach/layouts/templates.dart';
import 'package:mixnteach/models/tags.dart';

class tagList extends StatefulWidget {
  var keyState;
  tagList(this.keyState);
  @override
  _tagListState createState() => _tagListState();
}

class _tagListState extends State<tagList> {
  @override
  Widget build(BuildContext context) {
    var tagObj = tagsUtils();
    return FutureBuilder<List<String>>(
        future: tagObj.getTagsList(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> cardObj) {
          //print(cardList);
          if (cardObj.connectionState == ConnectionState.done) {
            var cardList = cardObj.data!;
            return Scaffold(
                body: SingleChildScrollView(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cardList.length,
                  itemBuilder: (context, i) {
                    return tagTile(context, cardList[i], widget.keyState);
                  }),
            ));
          } else {
            return getLoadingScreen();
          }
        });
  }
}

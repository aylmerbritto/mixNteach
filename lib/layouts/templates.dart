import 'package:flutter/material.dart';
import 'package:mixnteach/layouts/materials/materialList.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/layouts/utils.dart';
import 'package:mixnteach/layouts/materials/notesEditor.dart';
import 'package:mixnteach/models/notes.dart';
import 'package:mixnteach/models/learningMaterials.dart';
import 'package:mixnteach/src/appConstants.dart';

var theme = appTheme();
var constants = new appConstants();

getAppBar() {
  return AppBar(
    title: Text(constants.bannerTitle),
    centerTitle: true,
    backgroundColor: theme.primaryColor,
    automaticallyImplyLeading: false,
  );
}

double getHeight(context, setHeight) {
  return MediaQuery.of(context).size.height * setHeight;
}

double getWidth(context, setWidth) {
  return MediaQuery.of(context).size.width * setWidth;
}

Widget getLoadingScreen() {
  return Text("Loading");
}

BoxDecoration dialogBoxSetting() {
  return BoxDecoration(
    color: theme.secondaryColor,
    border: Border.all(color: theme.primaryColor),
    borderRadius: BorderRadius.all(
      Radius.circular(10),
    ),
    boxShadow: [
      BoxShadow(
        color: theme.primaryColor.withOpacity(0.2),
        spreadRadius: 10,
        blurRadius: 50,
        offset: Offset(0, 0),
      ),
    ],
  );
}

Widget getH2Text(context, content, x, y) {
  var appThemes = appTheme();
  return Container(
      margin: EdgeInsets.fromLTRB(
          getWidth(context, x), getHeight(context, y), 0, 0),
      child: Text(
        content,
        style: appThemes.h2Style(context),
      ));
}

Widget getBodyText(context, content, x, y) {
  var appThemes = appTheme();
  return Container(
      margin: EdgeInsets.fromLTRB(
          getWidth(context, x), getHeight(context, y), 0, 0),
      child: Text(
        content,
        style: appThemes.bodyStyle(context),
      ));
}

Widget inputField(context, controller, labelName, w, h) {
  return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.width * 0.8,
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * w,
          MediaQuery.of(context).size.height * h,
          MediaQuery.of(context).size.width * w,
          0),
      //decoration: theme.inputFieldDecoration(),
      child: TextField(
        controller: controller,
        style: TextStyle(
            fontSize: getWidth(context, 0.04), color: theme.primaryColor),
        decoration: InputDecoration(
            //focusColor: theme.primaryColor,
            focusColor: theme.primaryColor,
            fillColor: theme.primaryColor,
            //suffixIcon: Icon(Icons.dns, size: 18),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(2)),
            ),
            labelText: labelName,
            isDense: true),
      ));
}

Widget getConfirmButton(context, w, h, route, type, content) {
  return Container(
      child: RawMaterialButton(
    fillColor: theme.primaryColor,
    onPressed: () {
      submitNew(type, content);
      getMeTo(context, route);
    },
    child: Text("Confirm", style: TextStyle(color: theme.secondaryColor)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 10.0,
  ));
}

Text getConfirmButtonText() {
  return Text("Confirm", style: TextStyle(color: theme.secondaryColor));
}

RoundedRectangleBorder getButtonShape() {
  return RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));
}

Widget getCancelButton(context, w, h) {
  return Container(
      child: RawMaterialButton(
    fillColor: theme.secondaryColor,
    onPressed: () {
      Navigator.pop(context);
    },
    child: Text("Cancel", style: TextStyle(color: theme.contentColor)),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    elevation: 10.0,
  ));
}

Widget getDropDownField(context, w, h) {
  return Container(
    margin: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * w,
        MediaQuery.of(context).size.height * h,
        MediaQuery.of(context).size.width * 0,
        0),
    child: Text("choices"),
  );
}

Widget getChipButton(context, w, h, content, icon, route) {
  return Container(
    margin: EdgeInsets.fromLTRB(
        MediaQuery.of(context).size.width * 0,
        MediaQuery.of(context).size.height * h,
        MediaQuery.of(context).size.width * 0,
        0),
    child: GestureDetector(
      onTap: () {
        getMeTo(context, route);
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: getHeight(context, 0.065),
            color: theme.primaryColor,
          ),
          Text(content,
              style: TextStyle(
                  fontSize: getWidth(context, 0.075),
                  color: theme.primaryColor))
        ],
      ),
    ),
  );
}

Widget materialTile(context, tileContent) {
  return GestureDetector(
    onLongPress: () {
      showBottomSheet(
        context: context,
        builder: (context) {
          final theme = Theme.of(context);
          // Using Wrap makes the bottom sheet height the height of the content.
          // Otherwise, the height will be half the height of the screen.
          return Wrap(
            children: [
              ListTile(
                title: Text(
                  "Options for " + tileContent.name,
                  //style: theme.textTheme.subtitle1
                  //  .copyWith(color: theme.colorScheme.onPrimary),
                ),
                tileColor: theme.colorScheme.primary,
              ),
              ListTile(
                title: Text('Share via'),
                onTap: () async {
                  var content = await getContent(
                      tileContent.materialType, tileContent.path);
                  Share.share(content, subject: tileContent.name);
                },
              ),
              ListTile(
                title: Text('Delete'),
                onTap: () async {
                  var lmModel = learningMaterialsUtils();
                  await lmModel.deleteLearningMaterial(tileContent.id);
                  getMeTo(context, '/');
                },
              ),
            ],
          );
        },
      );
    },
    onTap: () async {
      print(tileContent.name);
      var path = tileContent.path;
      if (tileContent.materialType == "note") {
        print("Opening note with the path" + tileContent.path);
        var obj = NotesDatabaseService();
        var notes = await obj.getDbNote(path);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EditNotePage(existingNote: notes)),
        );
      }
      if (tileContent.materialType == "blog") {
        print("Opening blog with the path" + tileContent.path);
        !await canLaunch(path)
            ? await launch(path)
            : throw 'Could not launch $path';
      } else {
        //if (tileContent.materialType == "file") {
        print(tileContent.materialType);
        print("Opening file with the path" + tileContent.path);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => openImagePage(context, path)),
        );
      }
    },
    child: Stack(children: [
      Divider(),
      getBodyText(context, tileContent.materialType, 0.1, 0.02),
      getH2Text(context, tileContent.name, 0.1, 0.04),
      getBodyText(context, tileContent.tag, 0.1, 0.075),
      Container(
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.8,
            MediaQuery.of(context).size.height * 0.025,
            MediaQuery.of(context).size.width * 0,
            0),
        child: Icon(
          Icons.document_scanner,
          size: getWidth(context, 0.15),
          color: theme.disabledColor,
        ),
      ),
      Divider()
    ]),
  );
}

Widget tagTile(context, tileContent, keyState) {
  var dropdownValue, _category;
  return GestureDetector(
    onTap: () {
      print(tileContent);
      keyState.currentState!.push(
        MaterialPageRoute(
          builder: (_) => materialsList(tagArg: tileContent),
        ),
      );
    },
    child: Stack(children: [
      Divider(),
      Container(
        margin: EdgeInsets.fromLTRB(
            MediaQuery.of(context).size.width * 0.1,
            MediaQuery.of(context).size.height * 0.02,
            MediaQuery.of(context).size.width * 0,
            0),
        child: Icon(
          Icons.document_scanner,
          size: getWidth(context, 0.075),
          color: theme.disabledColor,
        ),
      ),
      getBodyText(context, tileContent, 0.2, 0.02),
      getBodyText(context, tileContent, 0.8, 0.02),
      Divider()
    ]),
  );
}

openImagePage(context, path) {
  return Scaffold(
    appBar: AppBar(
      title: Text('Camera Connect'),
      backgroundColor: Colors.green,
    ),
    body: Center(
      child: Container(
        child: path == null
            ? Text('No Image Showing')
            : Image(image: Image.file(File(path)).image),
      ),
    ),
    floatingActionButton: FloatingActionButton(
      backgroundColor: Colors.green,
      child: Icon(Icons.add_a_photo),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
  );
}

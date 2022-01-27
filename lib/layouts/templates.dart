import 'package:flutter/material.dart';
import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/layouts/utils.dart';

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

Widget getConfirmButton(context, w, h, route) {
  return Container(
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * w,
          MediaQuery.of(context).size.height * h,
          MediaQuery.of(context).size.width * 0,
          0),
      child: RawMaterialButton(
        fillColor: theme.primaryColor,
        onPressed: () {
          getMeTo(context, route);
        },
        child: Text("Confirm", style: TextStyle(color: theme.secondaryColor)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 10.0,
      ));
}

Widget getCancelButton(context, w, h) {
  return Container(
      margin: EdgeInsets.fromLTRB(
          MediaQuery.of(context).size.width * w,
          MediaQuery.of(context).size.height * h,
          MediaQuery.of(context).size.width * 0,
          0),
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
        MediaQuery.of(context).size.width * w,
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

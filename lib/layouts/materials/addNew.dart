import 'package:flutter/material.dart';

import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/layouts/templates.dart';

appTheme theme = new appTheme();
void addNewTagFunction() {
  addNewTag();
}

class addNewTag extends StatefulWidget {
  @override
  _addNewTagState createState() => _addNewTagState();
}

class _addNewTagState extends State<addNewTag> {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        width: getWidth(context, 0.8),
        height: getHeight(context, 0.4),
        margin: EdgeInsets.fromLTRB(
            getWidth(context, 0.1), getHeight(context, 0.325), 0, 0),
        //color: theme.secondaryColor,
        decoration: dialogBoxSetting(),
        child: Stack(
          children: [
            getH2Text(context, "Add New Tag", 0.05, 0.05),
            inputField(context, nameController, "Tag Name", 0.02, 0.125),
            getDropDownField(context, 0.02, 0.225),
            getConfirmButton(context, 0.425, 0.3, '/'),
            getCancelButton(context, 0.125, 0.3)
          ],
        ),
      ),
    ));
  }
}

class addNewMaterial extends StatefulWidget {
  @override
  _addNewMaterialState createState() => _addNewMaterialState();
}

class _addNewMaterialState extends State<addNewMaterial> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: getWidth(context, 0.8),
                height: getHeight(context, 0.35),
                margin: EdgeInsets.fromLTRB(
                    getWidth(context, 0.1), getHeight(context, 0.4), 0, 0),
                //color: theme.secondaryColor,
                decoration: dialogBoxSetting(),
                child: Stack(
                  children: [
                    getH2Text(context, "Add New Material", 0.06, 0.05),
                    Row(children: [
                      getChipButton(context, 0.07, 0.15, "File",
                          Icons.file_upload_outlined, '/addNewFile'),
                      getChipButton(context, 0.1, 0.15, "Notes",
                          Icons.description_outlined, '/addNewNote'),
                      getChipButton(
                          context, 0.1, 0.15, "Link", Icons.link_outlined, '/'),
                    ])
                  ],
                ))));
  }
}

class addNewFile extends StatefulWidget {
  @override
  _addNewFileState createState() => _addNewFileState();
}

class _addNewFileState extends State<addNewFile> {
  var titleController = TextEditingController();
  var fileNameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Container(
                width: getWidth(context, 0.8),
                height: getHeight(context, 0.55),
                margin: EdgeInsets.fromLTRB(
                    getWidth(context, 0.1), getHeight(context, 0.3), 0, 0),
                //color: theme.secondaryColor,
                decoration: dialogBoxSetting(),
                child: Stack(
                  children: [
                    getH2Text(context, "Add New File", 0.06, 0.05),
                    inputField(context, titleController, "Title", 0.05, 0.15),
                    inputField(
                        context, fileNameController, "File Name", 0.05, 0.25),
                    getDropDownField(context, 0.05, 0.35),
                    getConfirmButton(context, 0.45, 0.45, '/'),
                    getCancelButton(context, 0.15, 0.45)
                  ],
                ))));
  }
}

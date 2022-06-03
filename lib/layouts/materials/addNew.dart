import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/layouts/utils.dart';
import 'package:mixnteach/layouts/templates.dart';
import 'package:mixnteach/models/learningMaterials.dart';
import 'package:mixnteach/models/tags.dart';

appTheme theme = new appTheme();

class addNewTag extends StatefulWidget {
  @override
  _addNewTagState createState() => _addNewTagState();
  var scafKey;
  //addNewTag(this.scafKey);
}

class _addNewTagState extends State<addNewTag> {
  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Scaffold(
            backgroundColor: theme.primaryColor,
            body: SimpleDialog(
              children: [
                getH2Text(context, "Add New Tag", 0.05, 0.025),
                inputField(context, nameController, "Tag Name", 0.05, 0.05),
                // getDropDownField(context, 0.02, 0.65),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    getCancelButton(context, 0.05, 0.075),
                    Container(
                        child: RawMaterialButton(
                      fillColor: theme.primaryColor,
                      onPressed: () {
                        var tagObj = tagsUtils();
                        tagObj.tagName = nameController.text;
                        tagObj.insertTags();
                        getMeTo(context, '/');
                      },
                      child: getConfirmButtonText(),
                      shape: getButtonShape(),
                      elevation: 10.0,
                    ))
                  ],
                )
              ],
            )));
  }
}

class addNewMaterial extends StatefulWidget {
  @override
  _addNewMaterialState createState() => _addNewMaterialState();
}

class _addNewMaterialState extends State<addNewMaterial> {
  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
        child: Scaffold(
            backgroundColor: theme.primaryColor,
            body: SimpleDialog(
              //backgroundColor: Colors.transparent,
              children: [
                getH2Text(context, "Add New Material", 0.06, 0.05),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      getChipButton(context, 0.07, 0.05, "File",
                          Icons.file_upload_outlined, '/addNewFile'),
                      getChipButton(context, 0.1, 0.05, "Notes",
                          Icons.description_outlined, '/notesEditor'),
                      getChipButton(context, 0.1, 0.05, "Link",
                          Icons.link_outlined, '/addNewLink'),
                    ]),
                Divider()
              ],
            )));
  }
}

class addNewFile extends StatefulWidget {
  @override
  _addNewFileState createState() => _addNewFileState();
}

class _addNewFileState extends State<addNewFile> {
  var titleController = TextEditingController();
  var fileNameController = TextEditingController();
  var _category;
  String? _fileName;
  String? _filePath;
  String? _newPath;
  String? _saveAsFileName;
  List<PlatformFile>? _paths;
  String? _directoryPath;
  String? _extension;
  bool _isLoading = false;
  bool _userAborted = false;
  bool _multiPick = false;
  FileType _pickingType = FileType.any;
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      _pickFiles();
    });
  }

  @override
  Widget build(BuildContext context) {
    var matObj = tagsUtils();
    return FutureBuilder<List<String>>(
        future: matObj.getTagsList(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> cardObj) {
          if (cardObj.connectionState == ConnectionState.done &&
              cardObj.hasData == true) {
            var cardList = cardObj.data!;
            return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Scaffold(
                    backgroundColor: theme.primaryColor,
                    body: SimpleDialog(
                      //backgroundColor: Colors.transparent,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getH2Text(context, "Add New File", 0.06, 0.05),
                              SizedBox(height: getHeight(context, 0.05)),
                              inputField(
                                  context, titleController, "Title", 0.05, 0),
                              SizedBox(height: getHeight(context, 0.025)),
                              inputField(context, fileNameController,
                                  "File Name", 0.05, 0),
                              SizedBox(height: getHeight(context, 0.025)),
                              getDropDown(cardList),
                              SizedBox(height: getHeight(context, 0.025)),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              getCancelButton(context, 0.05, 0.075),
                              Container(
                                  child: RawMaterialButton(
                                fillColor: theme.primaryColor,
                                onPressed: () async {
                                  var lmObj = learningMaterialsUtils();
                                  lmObj.name = titleController.text;
                                  lmObj.path = _newPath;
                                  lmObj.materialType = 'file';
                                  lmObj.tag = _category;
                                  await lmObj.insertLearningMaterial();
                                  getMeTo(context, '/');
                                },
                                child: getConfirmButtonText(),
                                shape: getButtonShape(),
                                elevation: 10.0,
                              ))
                            ])
                      ],
                    )));
          } else {
            return getLoadingScreen();
          }
        });
  }

  void _pickFiles() async {
    _resetState();
    _directoryPath = null;
    final tmpPath = (await getApplicationDocumentsDirectory()).path;
    _paths = (await FilePicker.platform.pickFiles(
      type: _pickingType,
      allowMultiple: _multiPick,
      onFileLoading: (FilePickerStatus status) => print(status),
      allowedExtensions: (_extension?.isNotEmpty ?? false)
          ? _extension?.replaceAll(' ', '').split(',')
          : null,
    ))
        ?.files;
    if (!mounted) return;
    setState(() {
      _isLoading = false;

      var fileName =
          _paths != null ? _paths!.map((e) => e.name).toString() : '...';
      var filePath =
          _paths != null ? _paths!.map((e) => e.path).toString() : '...';
      _filePath = filePath.substring(1, filePath.length - 1);
      _fileName = fileName.substring(1, fileName.length - 1);
      _newPath = '$tmpPath/$_fileName';
      File(_filePath!).copy('$tmpPath/$_fileName');
      _userAborted = _paths == null;
      fileNameController.text = _fileName.toString();
    });
  }

  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _directoryPath = null;
      _fileName = null;
      _paths = null;
      _saveAsFileName = null;
      _userAborted = false;
    });
  }

  getDropDown(List<String> cardList) {
    return Container(
        margin: EdgeInsets.fromLTRB(getWidth(context, 0.05),
            getHeight(context, 0), getWidth(context, 0.05), 0),
        child: DropdownButtonFormField(
          hint: Text("  Tag"),
          items: cardList.map((String category) {
            return new DropdownMenuItem(
                value: category,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Text(category),
                  ],
                ));
          }).toList(),
          onChanged: (newValue) {
            // do other stuff with _category
            setState(() => _category = newValue);
          },
          value: _category,
        ));
  }
}

class addNewLink extends StatefulWidget {
  @override
  _addNewLinkState createState() => _addNewLinkState();
}

class _addNewLinkState extends State<addNewLink> {
  var titleController = TextEditingController();
  var fileNameController = TextEditingController();
  var _category;

  @override
  Widget build(BuildContext context) {
    var matObj = tagsUtils();
    return FutureBuilder<List<String>>(
        future: matObj.getTagsList(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> cardObj) {
          if (cardObj.connectionState == ConnectionState.done) {
            var cardList = cardObj.data!;
            return BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Scaffold(
                    backgroundColor: theme.primaryColor,
                    body: SimpleDialog(
                      //backgroundColor: Colors.transparent,
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getH2Text(context, "Add New Link", 0.06, 0.05),
                              SizedBox(height: getHeight(context, 0.05)),
                              inputField(
                                  context, titleController, "Title", 0.05, 0),
                              SizedBox(height: getHeight(context, 0.025)),
                              inputField(
                                  context, fileNameController, "Link", 0.05, 0),
                              SizedBox(height: getHeight(context, 0.025)),
                              _getDropDown(cardList),
                              SizedBox(height: getHeight(context, 0.025)),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              getCancelButton(context, 0.05, 0.075),
                              Container(
                                  child: RawMaterialButton(
                                fillColor: theme.primaryColor,
                                onPressed: () {
                                  var lmObj = learningMaterialsUtils();
                                  lmObj.name = titleController.text;
                                  lmObj.path = fileNameController.text;
                                  lmObj.materialType = 'blog';
                                  lmObj.tag = _category;
                                  lmObj.insertLearningMaterial();
                                  getMeTo(context, '/');
                                },
                                child: getConfirmButtonText(),
                                shape: getButtonShape(),
                                elevation: 10.0,
                              ))
                            ])
                      ],
                    )));
          } else {
            return getLoadingScreen();
          }
        });
  }

  _getDropDown(List<String> cardList) {
    return Container(
        margin: EdgeInsets.fromLTRB(getWidth(context, 0.05),
            getHeight(context, 0), getWidth(context, 0.05), 0),
        child: DropdownButtonFormField(
          hint: Text("  Tag"),
          items: cardList.map((String category) {
            return new DropdownMenuItem(
                value: category,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.star),
                    Text(category),
                  ],
                ));
          }).toList(),
          onChanged: (newValue) {
            // do other stuff with _category
            setState(() => _category = newValue);
          },
          value: _category,
        ));
  }
}

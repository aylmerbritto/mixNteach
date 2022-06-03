import 'package:flutter/material.dart';
import 'package:mixnteach/models/tags.dart';
import 'package:mixnteach/models/learningMaterials.dart';
import 'package:mixnteach/models/notes.dart';

getMeTo(context, routeName, {args = ''}) {
  Navigator.pushNamed(context, routeName, arguments: args);
}

submitNew(type, content) {
  if (type == 'tags') {
    var tagObj = tagsUtils();
  } else {}
}

getContent(materialType, path) async {
  if (materialType == "blog") {
    return path;
  } else if (materialType == "note") {
    var getNotes = NotesDatabaseService();
    var content = await getNotes.getDbNote(path);
    return content.content;
  }
}

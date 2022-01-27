import 'package:flutter/material.dart';

import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/layouts/utils.dart';

appTheme theme = new appTheme();

class materialsLandingPage extends StatefulWidget {
  @override
  _materialsLandingPageState createState() => _materialsLandingPageState();
}

class _materialsLandingPageState extends State<materialsLandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RawMaterialButton(
              onPressed: () {
                getMeTo(context, '/addNewTag');
              },
              child: Icon(
                Icons.style_outlined,
                color: theme.secondaryColor,
              ),
              shape: CircleBorder(),
              elevation: 10.0,
              fillColor: theme.primaryColor,
            ),
            RawMaterialButton(
              fillColor: theme.primaryColor,
              onPressed: () {
                getMeTo(context, '/addNewMaterial');
              },
              child: Icon(
                Icons.add_outlined,
                color: theme.secondaryColor,
              ),
              shape: CircleBorder(),
              elevation: 10.0,
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            iconSize: 24.0,
            fixedColor: theme.secondaryColor,
            backgroundColor: theme.primaryColor,
            unselectedItemColor: theme.disabledColor,
            //selectedItemColor: theme.secondaryColor,
            onTap: _onItemTapped,
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                  label: 'Materials', icon: Icon(Icons.library_add_outlined)),
              BottomNavigationBarItem(
                  label: 'Modules',
                  icon: Icon(Icons.app_registration_outlined)),
              BottomNavigationBarItem(
                  label: 'Lessons', icon: Icon(Icons.contacts_outlined)),
            ]));
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

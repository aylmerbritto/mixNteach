import 'package:flutter/material.dart';

import 'package:mixnteach/layouts/themes.dart';
import 'package:mixnteach/layouts/utils.dart';
import 'package:mixnteach/layouts/templates.dart';
import 'package:mixnteach/layouts/materials/materialList.dart';
import 'package:mixnteach/layouts/materials/tagList.dart';

appTheme theme = new appTheme();
final GlobalKey<NavigatorState> _navKey = GlobalKey<NavigatorState>();

class materialsLandingPage extends StatefulWidget {
  @override
  _materialsLandingPageState createState() => _materialsLandingPageState();
}

class _materialsLandingPageState extends State<materialsLandingPage> {
  @override
  Widget build(BuildContext context) {
    var _scaffoldKey = new GlobalKey<ScaffoldState>();
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Icon(Icons.list),
                      text: "Items",
                    ),
                    Tab(
                      icon: Icon(Icons.local_offer_outlined),
                      text: "Tags",
                    ),
                  ],
                ),
                title: Text('Materials')),
            body: Navigator(
              key: _navKey,
              onGenerateRoute: (_) => MaterialPageRoute(
                builder: (_) => TabBarView(
                  //controller: _tabController,
                  children: [
                    materialsList(),
                    tagList(_navKey),
                  ],
                ),
              ),
            ),
            floatingActionButton: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RawMaterialButton(
                  onPressed: () {
                    getMeTo(context, '/addNewTag', args: _scaffoldKey);
                    //_showDialog(context);
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
                      label: 'Materials',
                      icon: Icon(Icons.library_add_outlined)),
                  BottomNavigationBarItem(
                      label: 'Modules',
                      icon: Icon(Icons.app_registration_outlined)),
                  BottomNavigationBarItem(
                      label: 'Lessons', icon: Icon(Icons.contacts_outlined)),
                ])));
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _showDialog(BuildContext context) {
    print('object');
    return Scaffold(
        body: SimpleDialog(
      children: [Text("hi")],
    ));
  }
}
